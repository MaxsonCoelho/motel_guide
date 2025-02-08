import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/providers/theme_provider.dart';
import 'package:motel_guide/screens/preload_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider); 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go', 
      theme: theme, 
      home: PreloadScreen(),
    );
  }
}
