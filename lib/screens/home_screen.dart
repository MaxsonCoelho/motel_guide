import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/providers/motel_provider.dart';
import 'package:motel_guide/widgets/suite/discount_suites_carousel.dart';
import 'package:motel_guide/widgets/suite/discount_suites_list.dart';
import 'package:motel_guide/widgets/filter_bar.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/motel/motel_list.dart'; 

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
          // TabBar personalizada
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: StickyFilterBar(),
          ),
          // Carrossel com descontos
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
          // Lista de hotéis com suítes
          SliverToBoxAdapter(
            child: MotelList(),  
          ),
          // Carrossel com descontos incríveis
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
            padding: EdgeInsets.only(bottom: 40), 
          ),
        ],
      ),
    );
  }
}
