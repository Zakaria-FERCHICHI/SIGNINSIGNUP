import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Fingerhome extends StatefulWidget {
  const Fingerhome({super.key});

  @override
  State<Fingerhome> createState() => _FingerhomeState();
}

class _FingerhomeState extends State<Fingerhome> {
  signout()async{
    await FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verification"),
      actions: [
        IconButton(
            icon: Icon(Icons.logout),
            onPressed: (()=>signout()), 
            tooltip: 'Logout',
          )
      ],),
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