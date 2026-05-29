import 'package:dfa_pbf_fe/cubit/product/product_cubit.dart';
import 'package:dfa_pbf_fe/models/pbf_product_model.dart';
import 'package:dfa_pbf_fe/pages/product/product_page.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/input.dart';
import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCreatePage extends StatefulWidget {
  const ProductCreatePage({super.key});

  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  final _key = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  String productUnit = '';

  final units = [
    'AMPUL',
    'BOTOL',
    'BOX',
    'KAPSUL',
    'POT',
    'TABLET',
    'TUBE',
    'VIAL',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Nav.to(context, ProductPage());
          }

          if (state is ProductError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tambah Produk'),
            foregroundColor: PbfColor.light,
            backgroundColor: PbfColor.main,
          ),
          body: Form(
            key: _key,
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 42),
              width: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width,
              child: Column(
                spacing: MediaQuery.of(context).size.height / 42,
                children: [
                  InputText(
                    controller: _codeController,
                    label: "Kode",
                    max: 8,
                    cap: TextCapitalization.characters,
                  ),
                  InputText(controller: _nameController, label: "Produk"),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      label: Text('Unit'),
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    items: units.map((String unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        productUnit = value.toString();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Builder(
                        builder: (buttonContext) {
                          return MainBtn(
                            onclick: () {
                              if (_key.currentState!.validate()) {
                                final product = PbfProductModel(
                                  code: _codeController.text,
                                  name: _nameController.text,
                                  unit: productUnit,
                                );

                                buttonContext
                                    .read<ProductCubit>()
                                    .createProduct(product);
                              }
                            },
                            text: "Simpan",
                          );
                        },
                      ),
                      BackBtn(text: "Kembali", backTo: ProductPage()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
