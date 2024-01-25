import 'dart:convert';
import 'package:http/http.dart' as http;

import '../consts/constants.dart';
import '../models/audio_model.dart';
import '../models/summarized_text.dart';

class ApiService {
  static Future<SummarizerTextModel> summarizeText({
    required String msj,
    required int sentenceNumber,
    required String provider,
    required String lang,
  }) async {
    try {
      var url = '${Constants.BASE_URL}/text/summarize';

      var body = jsonEncode({
        'providers': provider,
        'text': msj,
        'response_as_dict': true,
        'attributes_as_list': false,
        'show_original_response': false,
        'language': lang,
        'settings': {},
        'output_sentences': sentenceNumber,
      });

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer ${Constants.API_KEY}",
        },
        body: body,
      );

      var jsonResponse = jsonDecode(response.body);
      // This happens is text is less than 250 characters
      if (jsonResponse[provider] != null &&
          jsonResponse[provider]["error"] != null) {
        throw Exception(
            jsonResponse[provider]["error"]["message"]); //.split(":")[2]
      }
      // This happen if the API KEY is empty
      else if (jsonResponse['detail'] != null &&
          jsonResponse['detail'] is String) {
        throw Exception(jsonResponse['detail']);
      }
      // if we dont add a provider
      else if (jsonResponse['error'] != null &&
          jsonResponse['error']['message']['providers'] != null) {
        throw Exception(jsonResponse['error']['message']['providers'][0]);
      } else {
        return SummarizerTextModel.fromJson(jsonResponse[provider]);
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<TextToAudioModel> textToVoice({
    required String text,
    required String provider,
    required String option,
    required int rate,
    required int pitch,
    String language = "en-US",
  }) async {
    try {
      var url = '${Constants.BASE_URL}/audio/text_to_speech';

      var body = jsonEncode({
        'providers': provider,
        'text': text,
        'language': language,
        'option': option,
        "rate": 0,
        "pitch": 0,
      });

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer ${Constants.API_KEY}",
        },
        body: body,
      );

      var jsonResponse = jsonDecode(response.body);
      // This happen if the API KEY is empty
      if (jsonResponse['detail'] != null && jsonResponse['detail'] is String) {
        throw Exception(jsonResponse['detail']);
      }
      // if we dont add a provider
      else if (jsonResponse['error'] != null &&
          jsonResponse['error']['message']['providers'] != null) {
        throw Exception(jsonResponse['error']['message']['providers'][0]);
      } else if (jsonResponse['error'] != null) {
        throw Exception(jsonResponse['error']);
      } else {
        return TextToAudioModel.fromJson(jsonResponse[
            provider]); // jsonResponse[provider] because inside the map
      }
    } catch (error) {
      rethrow;
    }
  }
}
