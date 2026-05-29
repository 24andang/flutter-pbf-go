import 'package:dfa_pbf_fe/cubit/buffer/buffer_stock_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/error_page.dart';
import 'package:dfa_pbf_fe/pages/main/loading_page.dart';
import 'package:dfa_pbf_fe/widgets/alert.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BufferHistory extends StatelessWidget {
  const BufferHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BufferStockCubit()..getHistories(),
      child: BlocConsumer<BufferStockCubit, BufferStockState>(
        listener: (context, state) {
          if (state is BufferStockSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is BufferStockLoading) {
            return LoadingPage();
          } else if (state is BufferStockHistory) {
            final history = state.history;
            return Scaffold(
              appBar: AppBar(
                title: Text('History Upload Mutasi(Buffer Stock)'),
                foregroundColor: PbfColor.light,
                backgroundColor: PbfColor.main,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Kode Upload')),
                        DataColumn(label: Text('Waktu')),
                        DataColumn(label: Text('PIC')),
                        DataColumn(label: Text('Hapus')),
                      ],
                      rows: [
                        for (int i = 0; i < history.data.length; i++)
                          DataRow(
                            cells: [
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(history.data[i].code)),
                              DataCell(Text(history.data[i].time)),
                              DataCell(Text(history.data[i].uploader)),
                              DataCell(
                                IconButton(
                                  onPressed: () => PbfAlert.confirm(
                                    context,
                                    title:
                                        'Anda akan menghapus ${history.data[i].code} ?',
                                    actionText: 'Ya, Hapus!',
                                    onConfirm: () => context
                                        .read<BufferStockCubit>()
                                        .deleteHistory(history.data[i].code),
                                  ),
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: PbfColor.fire,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('Prev')),
                      Text(history.currentpage.toString()),
                      ElevatedButton(onPressed: () {}, child: Text('Next')),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is BufferStockerror) {
            return ErrorPage(error: state.error, detail: state.detail);
          }
          return ErrorPage(error: "Gagal memuat halaman history buffer page.");
        },
      ),
    );
  }
}
