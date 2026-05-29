class PbfAuthModel {
  final String initial;
  final String password;

  PbfAuthModel({required this.initial, required this.password});

  Map<String, dynamic> toJson() {
    return {'initial': initial, 'password': password};
  }
}
