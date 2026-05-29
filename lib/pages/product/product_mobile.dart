import 'package:dfa_pbf_fe/cubit/product/product_cubit.dart';
import 'package:dfa_pbf_fe/models/pbf_product_model.dart';
import 'package:dfa_pbf_fe/widgets/alert.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductMobile extends StatelessWidget {
  final List<PbfProductModel> products;

  const ProductMobile({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        var item = products[index];

        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(item.name),
          subtitle: Text('${item.code} | ${item.unit}'),
          trailing: IconButton(
            color: PbfColor.fire,
            onPressed: () {
              final productCubit = context.read<ProductCubit>();

              PbfAlert.confirm(
                context,
                title: "Anda yakin ingin menghapus produk ini?",
                actionText: "Ya, Hapus!",
                onConfirm: () => productCubit.deleteProduct(item.code),
              );
            },
            icon: Icon(Icons.delete_forever_rounded),
          ),
        );
      },
    );
  }
}
