import 'dart:io';

import 'package:dfa_pbf_fe/cubit/buffer/buffer_stock_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/error_page.dart';
import 'package:dfa_pbf_fe/pages/main/loading_page.dart';
import 'package:dfa_pbf_fe/pages/main/pbf_drawer.dart';
import 'package:dfa_pbf_fe/pages/stock/buffer/buffer_history.dart';
import 'package:dfa_pbf_fe/pages/stock/buffer/buffer_stock_dekstop.dart';
import 'package:dfa_pbf_fe/pages/stock/buffer/buffer_stock_mobile.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BufferStockPage extends StatefulWidget {
  const BufferStockPage({super.key});

  @override
  State<BufferStockPage> createState() => _BufferStockPageState();
}

class _BufferStockPageState extends State<BufferStockPage> {
  File? filepath;
  String filelabel = 'Pilih file .csv.';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BufferStockCubit()..getBufferStock(),
      child: BlocConsumer<BufferStockCubit, BufferStockState>(
        listener: (context, state) {
          if (state is BufferStockSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return BlocBuilder<BufferStockCubit, BufferStockState>(
            builder: (context, state) {
              if (state is BufferStockLoading) {
                return LoadingPage();
              } else if (state is BufferStockLoaded) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Buffer Stock'),
                    actions: [
                      PopupMenuButton<int>(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              final parentContext = context;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setStateDialog) {
                                      return AlertDialog(
                                        title: Text('Form Upload Mutasi'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing:
                                              MediaQuery.of(
                                                context,
                                              ).size.height /
                                              36,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.pickFiles(
                                                      type: FileType.custom,
                                                      allowedExtensions: [
                                                        'csv',
                                                      ],
                                                    );
                                                if (result != null) {
                                                  setStateDialog(() {
                                                    filepath = File(
                                                      result.files.single.path!,
                                                    );

                                                    filelabel = result
                                                        .files
                                                        .single
                                                        .name;
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.file_upload_outlined,
                                              ),
                                              label: Text(filelabel),
                                            ),
                                            MainBtn(
                                              text: 'Upload',
                                              onclick: () {
                                                if (filepath != null) {
                                                  parentContext
                                                      .read<BufferStockCubit>()
                                                      .uploadCSV(filepath!);

                                                  Navigator.pop(context);
                                                } else {
                                                  ScaffoldMessenger.of(
                                                    parentContext,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'File tidak valid',
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Text('Update mutasi (.csv).'),
                          ),
                          PopupMenuItem(
                            onTap: () => Nav.goto(context, BufferHistory()),
                            child: Text('History'),
                          ),
                        ],
                      ),
                    ],
                    foregroundColor: PbfColor.light,
                    backgroundColor: PbfColor.main,
                  ),
                  drawer: PbfDrawer(),
                  body: MediaQuery.of(context).size.width > 640
                      ? BufferStockDekstop(buffer: state.buffer)
                      : BufferStockMobile(buffer: state.buffer),
                );
              } else if (state is BufferStockerror) {
                return ErrorPage(error: state.error, detail: state.detail);
              }
              return ErrorPage(
                error: 'Error',
                detail: 'Gagal memuat halaman buffer.',
              );
            },
          );
        },
      ),
    );
  }
}
