import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatResponse {
  final String answer;
  final List<Map<String, dynamic>> sources;

  ChatResponse({required this.answer, this.sources = const []});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    final sources = json['sources'];
    final parsedSources = <Map<String, dynamic>>[];

    if (sources is List) {
      for (final item in sources) {
        if (item is Map) {
          parsedSources.add(Map<String, dynamic>.from(item));
        }
      }
    }

    return ChatResponse(
      answer: json['answer']?.toString() ?? 'The AI did not provide a response.',
      sources: parsedSources,
    );
  }
}

class ChatService {
  // 1. Ensure karein ke port :8000 lazmi ho
  final String baseUrl = "https://abdsar445-hikmah-backend.hf.space/api/v1";

  Future<ChatResponse> sendMessageToBackend(String text) async {
    final url = Uri.parse("$baseUrl/chat/ask");

    try {
      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"question": text}),
          )
          .timeout(const Duration(seconds: 90)); // Increased timeout for Render Free Tier cold starts

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ChatResponse.fromJson(data);
      } else {
        return ChatResponse(answer: "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      return ChatResponse(
        answer: "Connection Error: Please verify the server is running. $e",
      );
    }
  }

  Future<void> ensureAuth() async {}
  get currentUser => null;
}
