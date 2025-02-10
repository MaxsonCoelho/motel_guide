import 'package:flutter/material.dart';
import 'package:motel_guide/core/theme/app_theme.dart';

class MapaFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MapaFloatingButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(  
      color: Colors.white, 
      elevation: 3,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), 
          child: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Icon(Icons.map, color: AppTheme.primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                "Mapa",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
