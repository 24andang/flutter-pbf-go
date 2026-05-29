class PbfInHandStockModel {
  final String code;
  final String name;
  final int stock;
  final String unit;

  PbfInHandStockModel({
    required this.code,
    required this.name,
    required this.stock,
    required this.unit,
  });

  factory PbfInHandStockModel.fromJson(Map<String, dynamic> json) {
    return PbfInHandStockModel(
      code: json['code'],
      name: json['name'],
      stock: json['stock'],
      unit: json['unit'],
    );
  }
}
