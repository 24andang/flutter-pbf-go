import 'package:bloc/bloc.dart';
import 'package:dfa_pbf_fe/models/pbf_version_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'version_state.dart';

class VersionCubit extends Cubit<VersionState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final _baseUrl = dotenv.get('BASE_URL');
  final _currentVersion = dotenv.get('VERSION');

  VersionCubit() : super(VersionInitial());

  void checkVersion() async {
    emit(VersionLoading());
    try {
      final token = await _storage.read(key: 'token');
      final response = await _dio.get(
        '$_baseUrl/version/latest',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final version = response.data['data'];
      if (_currentVersion != version['latest']) {
        emit(VersionCheck(true, _currentVersion));
      } else {
        emit(VersionCheck(false, _currentVersion));
      }
    } catch (e) {
      emit(VersionError('Gagal melakukan cek versi.', e.toString()));
    }
  }

  void getUpdatedVersion() async {
    emit(VersionLoading());
    try {
      final token = await _storage.read(key: 'token');
      final response = await _dio.get(
        '$_baseUrl/version/updates',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      List data = response.data['data'];
      List<PbfVersionModel> apps = data
          .map((item) => PbfVersionModel.fromJson(item))
          .toList();
      emit(VersionAppLists(apps));
    } catch (e) {
      emit(VersionError('Gagal mengakses list aplikasi.', e.toString()));
    }
  }
}
