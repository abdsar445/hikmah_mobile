import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // --- SERVER ADDRESS ---
  // 10.0.2.2 Android Emulator ke liye computer ka 'localhost' hota hai.
  // Agar aap real phone use kar rahe hain toh computer ka IP address use karein.
  final String baseUrl = "https://abdsar445-hikmah-backend.hf.space/api/v1";

  // --- ASK AI FUNCTION ---
  Future<String> askAI(String question) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/chat/ask"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "question": question,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['answer'] ?? "The AI did not provide a response.";
      } else {
        return "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      print("Connection Error: $e");
      return "Connection Error: The Python Server is offline. Please start it using uvicorn.";
    }
  }
}
