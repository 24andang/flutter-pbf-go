import 'package:dfa_pbf_fe/cubit/stock/stock_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/error_page.dart';
import 'package:dfa_pbf_fe/pages/main/loading_page.dart';
import 'package:dfa_pbf_fe/pages/main/pbf_drawer.dart';
import 'package:dfa_pbf_fe/pages/stock/inhand/in_hand_stock_dekstop.dart';
import 'package:dfa_pbf_fe/pages/stock/inhand/in_hand_stock_mobile.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InHandStockPage extends StatelessWidget {
  const InHandStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockCubit()..getInHandStocks(),
      child: BlocBuilder<StockCubit, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return LoadingPage();
          } else if (state is StockInHand) {
            return Scaffold(
              appBar: AppBar(
                title: Text('In Hand Stock'),
                foregroundColor: PbfColor.light,
                backgroundColor: PbfColor.main,
              ),
              drawer: PbfDrawer(),
              body: MediaQuery.of(context).size.width > 640
                  ? InHandStockDekstop(stocks: state.stock)
                  : InHandStockMobile(stocks: state.stock),
            );
          } else if (state is StockError) {
            return ErrorPage(error: state.error, detail: state.detail);
          }
          return ErrorPage(error: "Gagal memuat in hand stock.");
        },
      ),
    );
  }
}
