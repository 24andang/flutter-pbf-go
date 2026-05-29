import 'package:bloc/bloc.dart';
import 'package:dfa_pbf_fe/models/pbf_product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = dotenv.get('BASE_URL');
  ProductCubit() : super(ProductInitial());

  void getAllProducts() async {
    final token = await _storage.read(key: 'token');

    emit(ProductLoading());
    try {
      final respose = await _dio.get(
        '$baseUrl/products/',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      List data = respose.data['data'];

      List<PbfProductModel> result = data
          .map((item) => PbfProductModel.fromJson(item))
          .toList();

      emit(ProductLoaded(result));
    } catch (e) {
      emit(ProductError('Gagal emit fetch products.'));
    }
  }

  void createProduct(PbfProductModel product) async {
    final token = await _storage.read(key: 'token');

    emit(ProductLoading());
    try {
      final response = await _dio.post(
        '$baseUrl/products/',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: product.toJson(),
      );
      emit(ProductSuccess(response.data['message']));
      getAllProducts();
    } catch (e) {
      emit(ProductError('Error : Data input tidak valid.'));
    }
  }

  void deleteProduct(String code) async {
    final token = await _storage.read(key: 'token');

    emit(ProductLoading());
    try {
      final response = await _dio.delete(
        '$baseUrl/products/$code',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      emit(ProductSuccess(response.data['message']));
      getAllProducts();
    } catch (e) {
      emit(ProductError('Gagal emit hapus produk.'));
    }
  }
}
