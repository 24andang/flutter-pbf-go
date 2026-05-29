import 'package:bloc/bloc.dart';
import 'package:dfa_pbf_fe/models/pbf_auth_model.dart';
import 'package:dfa_pbf_fe/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();

  final baseUrl = dotenv.get('BASE_URL');

  AuthCubit() : super(AuthInitial());

  void login(PbfAuthModel user) async {
    try {
      final response = await _dio.post('$baseUrl/login', data: user.toJson());

      final userdata = response.data['user'];

      UserModel loginuser = UserModel(
        initial: userdata['initial'],
        name: userdata['name'],
        role: userdata['role'],
        isSet: userdata['is_set'],
      );

      await _storage.write(key: 'initial', value: loginuser.initial);
      await _storage.write(key: 'name', value: loginuser.name);
      await _storage.write(key: 'role', value: loginuser.role);
      await _storage.write(key: 'isSet', value: loginuser.isSet);

      await _storage.write(key: 'token', value: response.data['token']);

      emit(AuthLogin(loginuser));
    } catch (e) {
      emit(AuthError("Invalid login. Gagal emit login."));
    }
  }

  void logout() async {
    emit(AuthLoading());
    await _storage.deleteAll();
    emit(AuthInitial());
  }

  Future<UserModel> getLoginUser() async {
    final initial = await _storage.read(key: 'initial');
    final name = await _storage.read(key: 'name');
    final role = await _storage.read(key: 'role');
    final isSet = await _storage.read(key: 'isSet');

    UserModel data = UserModel(
      initial: initial.toString(),
      name: name.toString(),
      role: role.toString(),
      isSet: isSet,
    );

    return data;
  }

  Future<String> getToken() async {
    final token = await _storage.read(key: 'token');
    return token.toString();
  }

  Future<String> getRole() async {
    final role = await _storage.read(key: 'role');
    return role.toString();
  }

  void updatePassword(String newpassword) async {
    final token = await getToken();
    final user = await getLoginUser();

    try {
      final response = await _dio.patch(
        '$baseUrl/users/${user.initial}',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {'password': newpassword},
      );

      emit(AuthSuccess(response.data['message']));
    } catch (e) {
      emit(AuthError("Gagal update password"));
    }
  }
}
