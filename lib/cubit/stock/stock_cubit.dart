import 'package:bloc/bloc.dart';
import 'package:dfa_pbf_fe/models/pbf_in_hand_stock_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final _baseUrl = dotenv.get('BASE_URL');

  StockCubit() : super(StockInitial());

  void getInHandStocks() async {
    try {
      final token = await _storage.read(key: 'token');
      final response = await _dio.get(
        '$_baseUrl/in-hand-stock',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      List data = response.data['data'];
      List<PbfInHandStockModel> stocks = data
          .map((item) => PbfInHandStockModel.fromJson(item))
          .toList();

      emit(StockInHand(stocks));
    } catch (e) {
      emit(StockError('Error emit/fetch in hand stocks.', e.toString()));
    }
  }
}
