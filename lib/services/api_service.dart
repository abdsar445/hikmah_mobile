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
      // Python backend ke '/chat' endpoint par POST request bhejna
      final response = await http.post(
        Uri.parse("$baseUrl/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "text":
              question, // Python backend yahan 'text' field ka wait kar raha hai
        }),
      );

      if (response.statusCode == 200) {
        // Agar response sahi hai toh JSON ko parse karein
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['response']; // Python se aya hua jawab
      } else {
        // Agar server koi error deta hai
        return "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      // Agar connection nahi ban pata (e.g. Server band hai)
      print("Connection Error: $e");
      return "Connection Error: The Python Server is offline. Please start it using uvicorn.";
    }
  }
}
