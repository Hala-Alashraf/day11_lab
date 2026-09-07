import 'dart:convert';

import 'package:http/http.dart' as http;

class GeminiApi {
  Future<String> getWordInfo(String word) async {
    final String apiKey = "REDACTED_API_KEY";
    
        
    final String apiKey = "REDACTED_API_KEY";

    final prompt = 
    "اعطني معنى كلمة \"$word\" باختصار، ثم مثال جملة واحدة عليها. رجعي الرد بصيغة:\nالمعنى: ...\nمثال: ...";

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "x-goog-api-key": "",
    };

    Map<String, String>? body = {
      "model": "gemini-3.8-flash",
      "input": prompt,
    };

    var response = await http.post(uri, headers: headers, body: jsonEncode(body));



    if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          return responseBody["steps"][1]["content"][0]["text"].toString();
    } 
      
    

    return ("Error  $response.statusCode");
  }
}


