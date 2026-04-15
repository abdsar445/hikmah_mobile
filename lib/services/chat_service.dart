import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  // 1. Ensure karein ke port :8000 lazmi ho
  final String baseUrl = "https://abdsar445-hikmah-backend.hf.space/api/v1";

  Future<String> sendMessageToBackend(String text) async {
    final url = Uri.parse("$baseUrl/chat");

    try {
      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"text": text}),
          )
          .timeout(const Duration(seconds: 90)); // Increased timeout for Render Free Tier cold starts

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply'] ?? "The AI did not provide a response.";
      } else {
        return "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      // ERROR FIX: Hamesha String return karein taake 'Null' error na aaye
      return "Connection Error: Please verify the server is running. $e";
    }
  }

  Future<void> ensureAuth() async {}
  get currentUser => null;
}
