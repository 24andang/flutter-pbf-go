class HistoryItem {
  final String code;
  final String uploader;
  final String time;

  HistoryItem({required this.code, required this.uploader, required this.time});

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      code: json['code'],
      uploader: json['uploader'],
      time: json['time'],
    );
  }
}

class PbfBufferHistoryModel {
  final List<HistoryItem> data;

  final String? firstpage;
  final String? lastpage;
  final String? prevpage;
  final String? nextpage;

  final int? currentpage;
  final int? perpage;
  final int? frompage;
  final int? topage;

  PbfBufferHistoryModel({
    required this.data,
    required this.firstpage,
    required this.lastpage,
    required this.prevpage,
    required this.nextpage,
    required this.currentpage,
    required this.perpage,
    required this.frompage,
    required this.topage,
  });

  factory PbfBufferHistoryModel.fromJson(Map<String, dynamic> json) {
    List<HistoryItem> datalist = (json['data'] as List)
        .map((item) => HistoryItem.fromJson(item))
        .toList();

    return PbfBufferHistoryModel(
      data: datalist,
      firstpage: json['first'],
      lastpage: json['last'],
      prevpage: json['prev'],
      nextpage: json['next'],
      currentpage: json['meta']['current_page'],
      perpage: json['per_page'],
      frompage: json['from'],
      topage: json['to'],
    );
  }
}
