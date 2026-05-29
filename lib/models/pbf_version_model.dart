class PbfVersionModel {
  final String name;
  final String url;

  PbfVersionModel({required this.name, required this.url});

  factory PbfVersionModel.fromJson(Map<String, dynamic> json) {
    return PbfVersionModel(name: json['name'], url: json['url']);
  }
}
