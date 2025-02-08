import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:motel_guide/core/theme/app_theme.dart';

// Provedor do tema com estado
final themeProvider = StateProvider<ThemeData>((ref) {
  return AppTheme.lightTheme; 
});
