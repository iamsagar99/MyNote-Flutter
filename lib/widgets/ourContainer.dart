import 'package:flutter/material.dart';


class OurContainer extends StatelessWidget {
  final Widget child;
  const OurContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10.0),

      ),
    );
  }
}
