import 'dart:convert';

import 'package:http/http.dart' as http;

class CurrencyConverterDatasource {
  Future<Map<String, dynamic>> getAll() async {
    const String url = "https://open.er-api.com/v6/latest/GBP";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body);

        if (result != null && result.containsKey('rates')) {
          return result['rates'];
        } else {
          throw Exception("Unexpected response format: 'rates' key not found");
        }
      } else {
        throw Exception("Failed to load rates: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error occurred while fetching rates: $e");
    }
  }
}
