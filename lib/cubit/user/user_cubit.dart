import 'package:bloc/bloc.dart';
import 'package:dfa_pbf_fe/cubit/auth/auth_cubit.dart';
import 'package:dfa_pbf_fe/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = dotenv.get('BASE_URL');

  UserCubit() : super(UserInitial());

  void getAllUsers() async {
    final token = await _storage.read(key: 'token');

    emit(UserLoading());
    try {
      final response = await _dio.get(
        '$baseUrl/users',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      List data = response.data['data'];

      List<UserModel> result = data
          .map((item) => UserModel.fromJson(item))
          .toList();

      emit(UserLoaded(result));
    } catch (e) {
      emit(UserError('Gagal emit fetch users.'));
    }
  }

  void createUser(UserCreateModel user) async {
    final token = await _storage.read(key: 'token');

    emit(UserLoading());
    try {
      final response = await _dio.post(
        '$baseUrl/users',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: user.toJson(),
      );
      getAllUsers();
      emit(UserSuccess(response.data['message']));
    } catch (e) {
      emit(UserError('Error : Data input tidak valid.'));
    }
  }

  void deleteUser(String initial) async {
    final token = await _storage.read(key: 'token');

    emit(UserLoading());
    try {
      final response = await _dio.delete(
        '$baseUrl/users/$initial',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      getAllUsers();
      emit(UserSuccess(response.data['message']));
    } catch (e) {
      emit(UserError('Gagal emit delete user.'));
    }
  }

  void resetPassword(String initial) async {
    final token = await _storage.read(key: 'token');

    emit(UserLoading());
    try {
      final response = await _dio.patch(
        '$baseUrl/users/$initial',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {},
      );
      getAllUsers();
      emit(UserSuccess(response.data['message']));
    } catch (e) {
      emit(UserError('Gagal emit reset password.'));
    }
  }

  void updatePassword(String newpassword) async {
    final token = await _storage.read(key: 'token');
    final user = await AuthCubit().getLoginUser();

    try {
      final response = await _dio.patch(
        '$baseUrl/users/${user.initial}',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {'password': newpassword},
      );

      emit(UserSuccess(response.data['message']));
    } catch (e) {
      emit(UserError("Gagal update password"));
    }
  }
}
