import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeminiApi {
  Future<String> getWordInfo(String word) async {
    final String link = "https://generativelanguage.googleapis.com/v1beta/interactions";
    var uri = Uri.parse(link);
    
        
     

    final prompt = 
    "اعطني معنى كلمة \"$word\" باختصار، ثم مثال جملة واحدة عليها. رجعي الرد بصيغة:\nالمعنى: ...\nمثال: ...";

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "x-goog-api-key": dotenv.get('api_key'),
    };

    Map<String, String>? body = {
      "model": "gemini-3.5-flash",
      "input": prompt,
    };

    var response = await http.post(uri, headers: headers, body: jsonEncode(body));



    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      final steps = responseBody["steps"] as List;
      final modelStep = steps.firstWhere(
        (s) => s["type"] == "model_output",
        orElse: () => null,
      );
      if (modelStep == null) {
        return "لم يصل رد من النموذج";
      }
      return modelStep["content"][0]["text"].toString();
    }

    return "Error ${response.statusCode}: ${response.body}";
  }
}

