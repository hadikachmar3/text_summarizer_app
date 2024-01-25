import 'package:flutter/material.dart';
import '../models/audio_model.dart';
import '../services/api_service.dart';

class TextToAudioProvider with ChangeNotifier {
  TextToAudioModel? textToAudioModel;
  // String? error;

  // String? get getError {
  //   return error;
  // }

  // void setError(String err) {
  //   error = err;
  //   notifyListeners();
  // }

  // void clearError() {
  //   error = null;
  //   notifyListeners();
  // }

  TextToAudioModel? get getTextToAudioModel {
    return textToAudioModel;
  }

  Future<void> textToVoiceFCT({
    required String text,
    required String provider,
    required String option,
    required int rate,
    required int pitch,
  }) async {
    // log(" provider $provider");
    textToAudioModel = await ApiService.textToVoice(
        text: text,
        provider: provider,
        pitch: pitch,
        rate: rate,
        option: option);
    notifyListeners();
  }

  void clearTextToVoiceModel() {
    textToAudioModel = null;
    notifyListeners();
  }
}
