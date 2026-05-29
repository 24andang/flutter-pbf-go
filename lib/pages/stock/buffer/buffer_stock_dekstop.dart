import 'package:dfa_pbf_fe/models/pbf_buffer_stock_model.dart';
import 'package:flutter/material.dart';

class BufferStockDekstop extends StatelessWidget {
  final List<PbfBufferStockModel> buffer;

  const BufferStockDekstop({super.key, required this.buffer});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('No')),
          DataColumn(label: Text('Kode')),
          DataColumn(label: Text('Produk')),
          DataColumn(label: Text('Unit')),
          DataColumn(label: Text('Inhand')),
          DataColumn(label: Text('Buffer')),
        ],
        rows: [
          for (int i = 0; i < buffer.length; i++)
            DataRow(
              cells: [
                DataCell(Text('${i + 1}')),
                DataCell(Text(buffer[i].code)),
                DataCell(Text(buffer[i].name)),
                DataCell(Text(buffer[i].unit)),
                DataCell(Text('${buffer[i].inhand}')),
                DataCell(Text('${buffer[i].buffer}')),
              ],
            ),
        ],
      ),
    );
  }
}
