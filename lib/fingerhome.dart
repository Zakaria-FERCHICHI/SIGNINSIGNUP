import 'package:flutter/material.dart';

class Fingerhome extends StatefulWidget {
  const Fingerhome({super.key});

  @override
  State<Fingerhome> createState() => _FingerhomeState();
}

class _FingerhomeState extends State<Fingerhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Home Page", style: TextStyle(fontSize: 28,fontWeight: FontWeight.normal),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 5),
            child: Center(
              child: Text("Successfully authenticated using fingerprint"),
            ),
          ),
        ],
      ),

    );
  }
}