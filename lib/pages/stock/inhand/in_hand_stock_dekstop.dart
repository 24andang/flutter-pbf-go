import 'package:dfa_pbf_fe/models/pbf_in_hand_stock_model.dart';
import 'package:flutter/material.dart';

class InHandStockDekstop extends StatelessWidget {
  final List<PbfInHandStockModel> stocks;

  const InHandStockDekstop({super.key, required this.stocks});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('No')),
          DataColumn(label: Text('Kode')),
          DataColumn(label: Text('Produk')),
          DataColumn(label: Text('Stok')),
          DataColumn(label: Text('Unit')),
        ],
        rows: [
          for (int i = 0; i < stocks.length; i++)
            DataRow(
              cells: [
                DataCell(Text('${i + 1}')),
                DataCell(Text(stocks[i].code)),
                DataCell(Text(stocks[i].name)),
                DataCell(Text('${stocks[i].stock}')),
                DataCell(Text(stocks[i].unit)),
              ],
            ),
        ],
      ),
    );
  }
}
