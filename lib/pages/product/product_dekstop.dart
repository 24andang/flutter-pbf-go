import 'package:dfa_pbf_fe/cubit/product/product_cubit.dart';
import 'package:dfa_pbf_fe/models/pbf_product_model.dart';
import 'package:dfa_pbf_fe/widgets/alert.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDekstop extends StatelessWidget {
  final List<PbfProductModel> products;

  const ProductDekstop({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text("No")),
          DataColumn(label: Text("Kode")),
          DataColumn(label: Text("Produk")),
          DataColumn(label: Text("Unit")),
          DataColumn(label: Text("Hapus")),
        ],
        rows: <DataRow>[
          for (int i = 0; i < products.length; i++)
            DataRow(
              cells: [
                DataCell(Text('${i + 1}')),
                DataCell(Text(products[i].code)),
                DataCell(Text(products[i].name)),
                DataCell(Text(products[i].unit)),
                DataCell(
                  IconButton(
                    color: PbfColor.fire,
                    onPressed: () {
                      final productCubit = context.read<ProductCubit>();

                      PbfAlert.confirm(
                        context,
                        title:
                            "Anda yakin ingin menghapus produk ${products[i].code}?",
                        content:
                            "Menghapus akan menghilangkan keseluruhan data dan informasi produk ${products[i].code}, termasuk stok.",
                        actionText: "Ya, Hapus!",
                        onConfirm: () =>
                            productCubit.deleteProduct(products[i].code),
                      );
                    },
                    icon: Icon(Icons.delete_forever_rounded),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
