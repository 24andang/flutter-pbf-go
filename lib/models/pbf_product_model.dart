class PbfProductModel {
  final String code;
  final String name;
  final String unit;

  PbfProductModel({required this.code, required this.name, required this.unit});

  factory PbfProductModel.fromJson(Map<String, dynamic> json) {
    return PbfProductModel(
      code: json['code'],
      name: json['name'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {"code": code, "name": name, "unit": unit};
}
