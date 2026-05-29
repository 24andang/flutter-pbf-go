class PbfBufferStockModel {
  final String code;
  final String name;
  final String unit;
  final int inhand;
  final int buffer;

  PbfBufferStockModel({
    required this.code,
    required this.name,
    required this.unit,
    required this.inhand,
    required this.buffer,
  });

  factory PbfBufferStockModel.fromJson(Map<String, dynamic> json) {
    return PbfBufferStockModel(
      code: json['code'],
      name: json['name'],
      unit: json['unit'],
      inhand: json['inhand'],
      buffer: json['buffer'],
    );
  }
}
