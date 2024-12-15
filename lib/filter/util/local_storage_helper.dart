import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorageHelper {
  static const String fileName = "pokemon_data.json";

  // Vérifie si le fichier existe
  static Future<bool> doesFileExist() async {
    final file = await _getLocalFile();
    return file.exists();
  }

  // Écrit les données dans le fichier
  static Future<void> writeToFile(String data) async {
    final file = await _getLocalFile();
    await file.writeAsString(data);
  }

  // Lit les données depuis le fichier
static Future<List<dynamic>> readFromFile() async {
  try {
    final file = await _getLocalFile();
    if (!await file.exists()) {
      return []; // Return empty list instead of throwing
    }
    
    final contents = await file.readAsString();
    return jsonDecode(contents) as List<dynamic>;
  } catch (e) {
    print("Error reading file: $e"); // Log error instead of throwing
    return []; // Return empty list as fallback
  }
}


  // Récupère le fichier local
  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/$fileName");
  }
}
