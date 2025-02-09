import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/providers/motel_provider.dart';
import 'package:motel_guide/providers/theme_provider.dart';
import 'package:motel_guide/widgets/suite/discount_suites_carousel.dart';
import 'package:motel_guide/widgets/suite/discount_suites_list.dart';
import 'package:motel_guide/widgets/filter_bar.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/motel/motel_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedTab = 1;

  Future<void> _refreshData() async {
    ref.invalidate(motelProvider);
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    double appBarHeight = Platform.isAndroid ? 115 : 100;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      //TabBar personalizada
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: CustomTabBar(
          onTabSelected: (index) {
            setState(() {
              selectedTab = index;
            });
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            //Carrossel com descontos
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, _) {
                  final motelState = ref.watch(motelProvider);
                  return motelState.when(
                    data: (moteis) => DiscountSuitesCarousel(moteis: moteis),
                    loading: () => _buildShimmerCarousel(),
                    error: (_, __) => SizedBox.shrink(),
                  );
                },
              ),
            ),
            //FilterBar personalizada
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: StickyFilterBar(),
            ),
            //Lista de hotéis com suítes
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, _) {
                  final motelState = ref.watch(motelProvider);
                  return motelState.when(
                    data: (moteis) => MotelList(),
                    loading: () => _buildShimmerList(),
                    error: (_, __) => SizedBox.shrink(),
                  );
                },
              ),
            ),
            //Carrossel com descontos incríveis
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, _) {
                  final motelState = ref.watch(motelProvider);
                  return motelState.when(
                    data: (moteis) => DiscountSuitesList(moteis: moteis),
                    loading: () => _buildShimmerCarousel(),
                    error: (_, __) => SizedBox.shrink(),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 40),
            ),
          ],
        ),
      ),
    );
  }

  //Shimmer para o Carrossel
  Widget _buildShimmerCarousel() {
    return Container(
      height: 230,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  //Shimmer para a Lista de Motéis
  Widget _buildShimmerList() {
    return Column(
      children: List.generate(5, (index) {
        return Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}
