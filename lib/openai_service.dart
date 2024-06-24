import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = 'sk-proj-c8rICvMLMazbLai9oaYWT3BlbkFJ68BjP2wcDIkxTf63CyNl';

  Future<String> completePrompt(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': 150,
        'n': 1,
        'stop': null,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].toString();
    } else {
      throw Exception('Failed to fetch completion');
    }
  }
}
