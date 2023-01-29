import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
          child: Container(
            child: Column(
              children: const  [
                 Text("Upload Book", style: TextStyle(fontWeight: FontWeight.bold),)
              ],


            ),
          ),
        ),
      ),

    );

  }
}
