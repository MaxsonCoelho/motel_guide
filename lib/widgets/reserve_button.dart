import 'package:flutter/material.dart';

class ReserveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor; 
  final Color textColor; 

  const ReserveButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor = const Color.fromARGB(255, 31, 156, 54), 
    this.textColor = Colors.white, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Reservar >",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
