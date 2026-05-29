import 'package:dfa_pbf_fe/cubit/product/product_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/error_page.dart';
import 'package:dfa_pbf_fe/pages/main/loading_page.dart';
import 'package:dfa_pbf_fe/pages/main/pbf_drawer.dart';
import 'package:dfa_pbf_fe/pages/product/product_create_page.dart';
import 'package:dfa_pbf_fe/pages/product/product_dekstop.dart';
import 'package:dfa_pbf_fe/pages/product/product_mobile.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getAllProducts(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is ProductError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            return LoadingPage();
          } else if (state is ProductLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Produk'),
                foregroundColor: PbfColor.light,
                backgroundColor: PbfColor.main,
              ),
              drawer: PbfDrawer(),
              body: MediaQuery.of(context).size.width > 640
                  ? ProductDekstop(products: state.products)
                  : ProductMobile(products: state.products),
              floatingActionButton: FloatAddBtn(to: ProductCreatePage()),
            );
          } else if (state is ProductError) {
            return ErrorPage(error: state.message);
          }
          return ErrorPage(error: "Gagal memuat halaman produk.");
        },
      ),
    );
  }
}
