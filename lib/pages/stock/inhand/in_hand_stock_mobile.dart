import 'package:dfa_pbf_fe/models/pbf_in_hand_stock_model.dart';
import 'package:flutter/material.dart';

class InHandStockMobile extends StatelessWidget {
  final List<PbfInHandStockModel> stocks;
  const InHandStockMobile({super.key, required this.stocks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        var item = stocks[index];
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(item.code),
          subtitle: Text('${item.stock} ${item.unit}'),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(item.name), duration: Duration(seconds: 1)),
          ),
        );
      },
    );
  }
}
