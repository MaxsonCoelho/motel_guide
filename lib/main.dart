import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/providers/motel_provider.dart';
import 'package:motel_guide/widgets/discount_suites_carousel.dart';
import 'widgets/custom_tab_bar.dart'; 
import 'screens/motel_list_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motel Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( 
        preferredSize: Size.fromHeight(100), 
        child: CustomTabBar(
          onTabSelected: (index) {
            setState(() {
              selectedTab = index;
            });
          },
        ),
      ),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                final motelState = ref.watch(motelProvider);

                return motelState.maybeWhen(
                  data: (moteis) => DiscountSuitesCarousel(moteis: moteis),
                  orElse: () => SizedBox.shrink(),
                );
              },
            ),
            MotelListScreen(),
          ],
        ),
      ),
    );
  }
}
