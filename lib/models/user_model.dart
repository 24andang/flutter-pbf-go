class UserModel {
  final String initial;
  final String name;
  final String role;
  final String? isSet;

  UserModel({
    required this.initial,
    required this.name,
    required this.role,
    required this.isSet,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      initial: json['initial'],
      name: json['name'],
      role: json['role'],
      isSet: json['is_set'],
    );
  }
}

class UserCreateModel {
  final String initial;
  final String name;

  UserCreateModel({required this.initial, required this.name});

  Map<String, dynamic> toJson() {
    return {'initial': initial, 'name': name};
  }
}
