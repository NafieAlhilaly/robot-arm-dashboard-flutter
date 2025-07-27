import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://localhost:8081';

  static Future<Map<String, dynamic>> startRun(
    Map<String, double> motorValues,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/update_status.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'create_new': true, 'motor_values': motorValues}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to start run: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
