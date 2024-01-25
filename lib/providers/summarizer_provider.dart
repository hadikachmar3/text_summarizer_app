import 'package:flutter/material.dart';
import '../models/summarized_text.dart';
import '../services/api_service.dart';

class SummarizerTextProvider with ChangeNotifier {
  SummarizerTextModel? summarizedModel;
  String? error;

  String? get getError {
    return error;
  }

  void setError(String err) {
    error = err;
    notifyListeners();
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  SummarizerTextModel? get getSummarizerTextModel {
    return summarizedModel;
  }

  Future<void> summarizeTextProv({
    required String msg,
    required int summarySentenceCount,
    required String provider,
    required String lang,
  }) async {
    summarizedModel = await ApiService.summarizeText(
      msj: msg,
      sentenceNumber: summarySentenceCount,
      provider: provider,
      lang: lang,
    );
    notifyListeners();
  }

  void clearSummarizedText() {
    summarizedModel = null;
    notifyListeners();
  }
}
