import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/steel_section.dart';

class SteelDataService {
  static SteelSection? _cachedData;
  static const String _jsonAssetPath = '2-i.json';

  /// Loads steel data from JSON asset
  static Future<SteelSection> loadSteelData() async {
    try {
      if (_cachedData != null) {
        return _cachedData!;
      }

      final String jsonString = await _loadJsonString();

      final Map<String, dynamic> jsonData = _parseJson(jsonString);

      final steelSection = SteelSection.fromJson(jsonData);
      _cachedData = steelSection;

      return steelSection;
    } catch (e) {
      print('Error loading steel data: $e');
      rethrow;
    }
  }

  static Future<String> _loadJsonString() async {
    try {
      return await rootBundle.loadString(_jsonAssetPath);
    } catch (e) {
      print('Failed to load JSON asset: $_jsonAssetPath - $e');
      rethrow;
    }
  }

  static Map<String, dynamic> _parseJson(String jsonString) {
    try {
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('Failed to parse JSON string: $e');
      rethrow;
    }
  }

  /// Handles missing ip2.svg by replacing with ip3.svg
  static String getImagePath(String imagePath) {
    if (imagePath.contains('ip2.svg')) {
      return imagePath.replaceAll('ip2.svg', 'ip3.svg');
    }
    return imagePath;
  }

  static String getAssetPath(String path) {
    if (path.startsWith('/icons/')) {
      final assetPath = 'assete/icons/${path.substring(7)}';
      return assetPath;
    }
    return path;
  }

  static void clearCache() {
    _cachedData = null;
  }
}
