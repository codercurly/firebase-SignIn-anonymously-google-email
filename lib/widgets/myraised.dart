import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {






  final Widget child;
  final Color color;
 final  VoidCallback? onPressed;

   MyRaisedButton(
      {
        required this.color,
         this.onPressed,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      // ignore: deprecated_member_use



      child: ElevatedButton(


          onPressed: onPressed,
          child: child,
      )
    );
  }
}