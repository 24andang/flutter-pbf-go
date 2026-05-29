import 'package:dfa_pbf_fe/models/pbf_buffer_stock_model.dart';
import 'package:flutter/material.dart';

class BufferStockMobile extends StatelessWidget {
  final List<PbfBufferStockModel> buffer;

  const BufferStockMobile({super.key, required this.buffer});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: buffer.length,
      itemBuilder: (context, index) {
        var item = buffer[index];
        return ListTile(
          leading: Text('${index + 1}'),
          title: Text(item.code),
          subtitle: Text('Inhand: ${item.inhand}. Buffer: ${item.buffer}.'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(item.name),
                duration: Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
