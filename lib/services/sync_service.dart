import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fishing_entry.dart';
import 'local_db_service.dart';

class SyncService {
  static const String serverUrl = 'http://127.0.0.1:3000/upload'; // Remplacez <ADRESSE_IP> par l'adresse de votre serveur

  static Future<void> syncEntries() async {
    final entries = await LocalDbService.getEntries();
    for (var entry in entries) {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fishermanName': entry.fishermanName,
          'boatName': entry.boatName,
          'date': entry.date.toIso8601String(),
          'categories': entry.categories,
          'quantity': entry.quantity,
          'inseminated': entry.inseminated,
        }),
      );
      if (response.statusCode == 200) {
        // Suppression locale après upload réussi
        await LocalDbService.Entry(entry.id!);
      }
    }
  }
}