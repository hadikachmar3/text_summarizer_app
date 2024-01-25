class SummarizerTextModel {
  String status;
  String result;
  SummarizerTextModel({
    required this.status,
    required this.result,
  });

  factory SummarizerTextModel.fromJson(Map<String, dynamic> json) {
    return SummarizerTextModel(
      status: json['status'],
      result: json['result'],
    );
  }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['result'] = result;
//     return data;
//   }
}
