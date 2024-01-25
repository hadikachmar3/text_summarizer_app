class TextToAudioModel {
  String status;
  String audioResourceUrl;
  TextToAudioModel({
    required this.status,
    required this.audioResourceUrl,
  });

  factory TextToAudioModel.fromJson(Map<String, dynamic> json) {
    return TextToAudioModel(
      status: json['status'],
      audioResourceUrl: json['audio_resource_url'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['status'] = status;
  //   data['audio_resource_url'] = audioResourceUrl;
  //   return data;
  // }
}
