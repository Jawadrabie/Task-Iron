import 'package:flutter/material.dart';
import '../models/steel_section.dart';
import '../services/steel_data_service.dart';
import '../widgets/steel_details_dialog.dart';

class SteelViewerController extends ChangeNotifier {
  SteelSection? _steelData;
  bool _isLoading = true;
  String? _errorMessage;
  int _selectedTypeIndex = 0;
  int _selectedVariantIndex = 0;

  // Getters
  SteelSection? get steelData => _steelData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedTypeIndex => _selectedTypeIndex;
  int get selectedVariantIndex => _selectedVariantIndex;

  SteelType? get currentType {
    if (_steelData == null || _selectedTypeIndex >= _steelData!.types.length) {
      return null;
    }
    return _steelData!.types[_selectedTypeIndex];
  }

  SteelVariant? get currentVariant {
    final type = currentType;
    if (type == null || _selectedVariantIndex >= type.variants.length) {
      return null;
    }
    return type.variants[_selectedVariantIndex];
  }

  /// Loads steel data from service
  Future<void> loadData() async {
    _setLoading(true);
    _clearError();

    try {
      final steelData = await SteelDataService.loadSteelData();
      _steelData = steelData;
      _setLoading(false);
    } catch (e) {
      print('Failed to load steel data: $e');
      _setError(e.toString());
      _setLoading(false);
    }
  }

  /// Selects a steel type
  void selectType(int typeIndex) {
    if (_steelData == null ||
        typeIndex < 0 ||
        typeIndex >= _steelData!.types.length) {
      print('Invalid type index: $typeIndex');
      return;
    }

    _selectedTypeIndex = typeIndex;
    _selectedVariantIndex = 0; // Reset to first variant
    notifyListeners();
  }

  /// Selects a steel variant
  void selectVariant(int variantIndex) {
    final type = currentType;
    if (type == null ||
        variantIndex < 0 ||
        variantIndex >= type.variants.length) {
      print('Invalid variant index: $variantIndex');
      return;
    }

    _selectedVariantIndex = variantIndex;
    notifyListeners();
  }

  /// Shows details dialog
  void showDetails(BuildContext context) {
    final variant = currentVariant;
    if (variant == null) {
      print('No variant selected to show details');
      return;
    }

    try {
      showDialog(
        context: context,
        builder: (context) => SteelDetailsDialog(variant: variant),
      );
    } catch (e) {
      print('Error showing details dialog: $e');
      _showErrorSnackBar(context, 'خطأ في عرض التفاصيل');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[600],
        action: SnackBarAction(
          label: 'موافق',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
