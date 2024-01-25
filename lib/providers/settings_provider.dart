import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/languages_model.dart';

class SettingsProvider with ChangeNotifier {
  // Shared Preferences keys
  static const String VOICE_PROVIDER_KEY = 'VOICE_PROVIDER';
  static const String VOICE_SPEED_KEY = 'VOICE_SPEED';
  static const String VOICE_PITCH_KEY = 'VOICE_PITCH';
  static const String SELECTED_GENDER_KEY = 'SELECTED_GENDER';
  static const String LANGUAGE_NAME_KEY = 'LANGUAGE_NAME';
  static const String LANGUAGE_CODE_KEY = 'LANGUAGE_CODE';
  static const String TEXT_SUMMARIZER_PROVIDER_KEY = 'TEXT_SUMMARIZER_PROVIDER';

  SettingsProvider() {
    loadPreferences();
  }

  // For Language
  Language languageModel = Language('English', 'en');

  Language get getLanguageModel {
    return languageModel;
  }

  void setLanguageModel({
    required String languageName,
    required String languageCode,
  }) {
    languageModel = Language(languageName, languageCode);
    savePreferences();
    notifyListeners();
  }

  // For summarizing
  final textSummarizerProvidersList = [
    'cohere',
    'openai',
    'emvista',
    'connexun',
    // 'oneai',
  ];
  String textSummarizerProvider = 'cohere';

  String get getTextSummarizerProvider {
    return textSummarizerProvider;
  }

  List get getTextSummarizerProvidersList {
    return textSummarizerProvidersList;
  }

  void setTextSummarizerProvider({required String provider}) {
    textSummarizerProvider = provider;
    savePreferences();
    notifyListeners();
  }

  void resetTextSummarizerProvider() {
    textSummarizerProvider = 'cohere';
    savePreferences();
    notifyListeners();
  }

  // For the voice
  final voiceProvidersList = [
    'Microsoft'.toLowerCase(),
    'Google'.toLowerCase(),
    'IBM'.toLowerCase(),
    'Amazon'.toLowerCase(),
  ];
  String voiceProvider = 'Microsoft'.toLowerCase();

  String get getVoiceProvider {
    return voiceProvider;
  }

  void setVoiceProvider({required String voicePro}) {
    voiceProvider = voicePro;
    savePreferences();
    notifyListeners();
  }

  final List<String> genderLabels = ['MALE', "FEMALE"];
  String selectedGenderLabel = 'MALE';

  double voiceSpeed = 0;

  double get getVoiceSpeed {
    return voiceSpeed;
  }

  void setVoiceSpeed({required double speed}) {
    voiceSpeed = speed;
    savePreferences();
    notifyListeners();
  }

  double voicePitch = 0;

  double get getVoicePitch {
    return voicePitch;
  }

  void setVoicePitch({required double pitch}) {
    voicePitch = pitch;
    savePreferences();
    notifyListeners();
  }

  List<String> get getGenderLabels {
    return genderLabels;
  }

  String get getSelectedGenderLabel {
    return selectedGenderLabel;
  }

  void setSelectedGenderLabel({required String gender}) {
    selectedGenderLabel = gender;
    savePreferences();
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    voiceProvider =
        prefs.getString(VOICE_PROVIDER_KEY) ?? 'Microsoft'.toLowerCase();
    voiceSpeed = prefs.getDouble(VOICE_SPEED_KEY) ?? 0;
    voicePitch = prefs.getDouble(VOICE_PITCH_KEY) ?? 0;
    selectedGenderLabel = prefs.getString(SELECTED_GENDER_KEY) ?? 'MALE';
    String languageName = prefs.getString(LANGUAGE_NAME_KEY) ?? 'English';
    String languageCode = prefs.getString(LANGUAGE_CODE_KEY) ?? 'en';
    languageModel = Language(languageName, languageCode);
    textSummarizerProvider =
        prefs.getString(TEXT_SUMMARIZER_PROVIDER_KEY) ?? 'cohere';
    notifyListeners();
  }

  Future<void> savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(VOICE_PROVIDER_KEY, voiceProvider);
    prefs.setDouble(VOICE_SPEED_KEY, voiceSpeed);
    prefs.setDouble(VOICE_PITCH_KEY, voicePitch);
    prefs.setString(SELECTED_GENDER_KEY, selectedGenderLabel);
    prefs.setString(LANGUAGE_NAME_KEY, languageModel.name);
    prefs.setString(LANGUAGE_CODE_KEY, languageModel.code);
    prefs.setString(TEXT_SUMMARIZER_PROVIDER_KEY, textSummarizerProvider);
  }
}
