import 'package:bloc/bloc.dart';
import 'package:dfa_pbf_fe/models/pbf_buffer_history_model.dart';
import 'package:dfa_pbf_fe/models/pbf_buffer_stock_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'dart:io';

part 'buffer_stock_state.dart';

class BufferStockCubit extends Cubit<BufferStockState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final _baseUrl = dotenv.get('BASE_URL');

  BufferStockCubit() : super(BufferStockInitial());

  void getBufferStock() async {
    emit(BufferStockLoading());
    try {
      final token = await _storage.read(key: 'token');
      final response = await _dio.get(
        '$_baseUrl/buffer-stock/',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      List data = response.data['data'];
      List<PbfBufferStockModel> buffer = data
          .map((item) => PbfBufferStockModel.fromJson(item))
          .toList();
      emit(BufferStockLoaded(buffer));
    } catch (e) {
      emit(BufferStockerror("Error: Gagal fetch buffer stock.", e.toString()));
    }
  }

  void uploadCSV(File file) async {
    emit(BufferStockLoading());
    try {
      final token = await _storage.read(key: 'token');
      final initial = await _storage.read(key: 'initial');

      FormData formdata = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'uploader': initial,
      });

      final response = await _dio.post(
        '$_baseUrl/buffer-stock/',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: formdata,
      );
      getBufferStock();
      emit(BufferStockSuccess(response.data['message']));
    } catch (e) {
      emit(BufferStockerror('Gagal upload file .csv.', e.toString()));
    }
  }

  void getHistories({int page = 1}) async {
    emit(BufferStockLoading());

    try {
      final Response response;
      final token = await _storage.read(key: 'token');

      if (page != 1) {
        response = await _dio.get(
          '$_baseUrl/buffer-stock/history?page=$page',
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );
      } else {
        response = await _dio.get(
          '$_baseUrl/buffer-stock/history',
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );
      }

      final history = PbfBufferHistoryModel.fromJson(response.data);
      emit(BufferStockHistory(history));
    } catch (e) {
      emit(
        BufferStockerror(
          "Gagal menampilkan history buffer stock.",
          e.toString(),
        ),
      );
    }
  }

  void deleteHistory(String code) async {
    emit(BufferStockLoading());

    final token = await _storage.read(key: 'token');
    try {
      final response = await _dio.delete(
        '$_baseUrl/buffer-stock/$code',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      emit(BufferStockSuccess(response.data['message']));
      getHistories();
    } catch (e) {
      emit(
        BufferStockerror(
          "Gagal menghapus file $code dari history buffer stock.",
          e.toString(),
        ),
      );
    }
  }
}
