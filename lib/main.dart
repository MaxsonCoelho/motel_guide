import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/providers/motel_provider.dart';
import 'package:motel_guide/widgets/discount_suites_carousel.dart';
import 'package:motel_guide/widgets/discount_suites_list.dart';
import 'package:motel_guide/widgets/filter_bar.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, ref, _) {
                final motelState = ref.watch(motelProvider);
                return motelState.maybeWhen(
                  data: (moteis) => DiscountSuitesCarousel(moteis: moteis),
                  orElse: () => SizedBox.shrink(),
                );
              },
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: StickyFilterBar(),
          ),
          SliverToBoxAdapter(
            child: MotelListScreen(),
          ),
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, ref, _) {
                final motelState = ref.watch(motelProvider);
                return motelState.maybeWhen(
                  data: (moteis) => DiscountSuitesList(moteis: moteis),
                  orElse: () => SizedBox.shrink(),
                );
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 30), 
          ),
        ],
      ),
    );
  }
}
