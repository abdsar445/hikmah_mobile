import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatResponse {
  final String answer;
  final List<Map<String, dynamic>> sources;

  ChatResponse({required this.answer, this.sources = const []});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    final sourcesRaw = json['sources'];
    final parsedSources = <Map<String, dynamic>>[];
    List<dynamic>? sourceList;

    if (sourcesRaw is List) {
      sourceList = sourcesRaw;
    } else if (sourcesRaw is Map<String, dynamic> && sourcesRaw['results'] is List) {
      sourceList = sourcesRaw['results'] as List<dynamic>;
    } else if (sourcesRaw is Map<String, dynamic>) {
      sourceList = [sourcesRaw];
    }

    if (sourceList != null) {
      for (final item in sourceList) {
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

  bool _isGreeting(String text) {
    final normalized = text.toLowerCase().trim();
    final greetings = {
      'hi',
      'hello',
      'hey',
      'salam',
      'assalamualaikum',
      'assalamu alaikum',
      'how are you',
      'good morning',
      'good afternoon',
      'good evening',
    };

    if (greetings.contains(normalized)) {
      return true;
    }

    final words = normalized.split(RegExp(r'\s+'));
    return words.isNotEmpty && greetings.contains(words.first);
  }

  Future<ChatResponse> sendMessageToBackend(String text) async {
    if (_isGreeting(text)) {
      return ChatResponse(
        answer: "Wa alaikum assalam! I am Himak, your Islamic Hadith assistant. Ask me about authentic Hadith and I will answer from the sources.",
        sources: [],
      );
    }

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
