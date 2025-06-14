import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentification_1/wrapper.dart';
import 'package:get/get.dart';

class Verifyemail extends StatefulWidget {
  const Verifyemail({super.key});

  @override
  State<Verifyemail> createState() => _VerifyemailState();
}

class _VerifyemailState extends State<Verifyemail> {

    signout()async{
    await FirebaseAuth.instance.signOut();
  }
  @override
  void initState() {
    sendverifylink();
    super.initState();
  }

  sendverifylink()async{
    final user=FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value)=> {
      Get.snackbar('Link sent','A link has been send to your email',margin:EdgeInsets.all(30),snackPosition: SnackPosition.BOTTOM)
    });
  }

  reload()async{
    await FirebaseAuth.instance.currentUser!.reload().then((value)=>{Get.offAll(Wrapper())});
  }
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
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Text('Open your mail and click on the link provided to verify email & reload this page')
        ),
      ),
      
            floatingActionButton: FloatingActionButton(
              onPressed: (()=>reload()),
              child:Icon(Icons.restart_alt_rounded),
              ),  
        );
  }
}