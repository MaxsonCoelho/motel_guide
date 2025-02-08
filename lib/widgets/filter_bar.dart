import 'dart:async';
import 'package:flutter/material.dart';

class StickyFilterBar extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _FilterBar();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _FilterBar extends StatefulWidget {
  @override
  __FilterBarState createState() => __FilterBarState();
}

class __FilterBarState extends State<_FilterBar> {
  final ScrollController _scrollController = ScrollController();
  bool _showRightArrow = true;
  bool _showLeftArrow = false;
  int _blinkCount = 0;
  final double _buttonWidth = 120;
  final Set<int> _selectedFilters = {};
  late Timer _blinkTimer; // ✅ Adicionado para evitar erro nos testes

  @override
  void initState() {
    super.initState();

    _blinkTimer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      if (mounted) {
        setState(() {
          _blinkCount = (_blinkCount < 6) ? _blinkCount + 1 : -5;
        });
      }
    });

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;

      setState(() {
        _showRightArrow = currentScroll < maxScroll;
        _showLeftArrow = currentScroll > 0;
      });
    });
  }

  void _scroll(bool isRight) {
    double currentOffset = _scrollController.offset;
    double newOffset = isRight ? currentOffset + (_buttonWidth * 2) : currentOffset - (_buttonWidth * 2);

    _scrollController.animateTo(
      newOffset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _toggleFilter(int index) {
    setState(() {
      _selectedFilters.contains(index)
          ? _selectedFilters.remove(index)
          : _selectedFilters.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 120, 120, 120),
                width: 1,
              ),
            ),
          ),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: _filters.length,
            itemBuilder: (context, index) {
              bool isSelected = _selectedFilters.contains(index);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: OutlinedButton.icon(
                  onPressed: () => _toggleFilter(index),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(4),
                    backgroundColor: isSelected ? const Color.fromARGB(255, 255, 17, 0) : Colors.white,
                    side: BorderSide(
                      color: Color.fromARGB(255, 120, 120, 120),
                      width: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                  ),
                  icon: Icon(
                    _filters[index]['icon'],
                    size: 16,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  label: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      _filters[index]['text'],
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        if (_showRightArrow)
          Positioned(
            right: 1.5,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => _scroll(true),
              child: _buildArrow(Icons.keyboard_arrow_right),
            ),
          ),

        if (_showLeftArrow)
          Positioned(
            left: 1.5,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => _scroll(false),
              child: _buildArrow(Icons.keyboard_arrow_left),
            ),
          ),
      ],
    );
  }

  Widget _buildArrow(IconData icon) {
    return AnimatedOpacity(
      opacity: (_blinkCount >= 0) ? 0.8 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Icon(
          icon,
          color: (_blinkCount % 2 == 0)
              ? const Color.fromARGB(255, 255, 17, 0)
              : const Color.fromARGB(255, 130, 130, 130),
          size: 35,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _blinkTimer.cancel(); // ✅ Cancela o Timer ao destruir o widget
    _scrollController.dispose();
    super.dispose();
  }
}

final List<Map<String, dynamic>> _filters = [
  {'text': 'Filtros', 'icon': Icons.filter_list},
  {'text': 'Com desconto', 'icon': Icons.local_offer_outlined},
  {'text': 'Disponíveis', 'icon': Icons.check_circle_outline},
  {'text': 'Hidro', 'icon': Icons.bathtub_outlined},
  {'text': 'Piscina', 'icon': Icons.pool_outlined},
  {'text': 'Sauna', 'icon': Icons.spa_outlined},
  {'text': 'Ofurô', 'icon': Icons.hot_tub_outlined},
  {'text': 'Decoração erótica', 'icon': Icons.favorite_border},
  {'text': 'Decoração térmica', 'icon': Icons.whatshot_outlined},
  {'text': 'Pista de dança', 'icon': Icons.music_note_outlined},
  {'text': 'Garagem privativa', 'icon': Icons.garage_outlined},
  {'text': 'Frigobar', 'icon': Icons.kitchen_outlined},
  {'text': 'Internet Wi-Fi', 'icon': Icons.wifi_outlined},
  {'text': 'Suíte para festas', 'icon': Icons.celebration_outlined},
  {'text': 'Acessibilidade', 'icon': Icons.accessible_outlined},
];
