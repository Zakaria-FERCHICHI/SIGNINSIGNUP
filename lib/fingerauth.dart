import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_authentification_1/fingerhome.dart';

class FingerAuth extends StatefulWidget {
  const FingerAuth({super.key});

  @override
  State<FingerAuth> createState() => _FingerAuthState();
}

class _FingerAuthState extends State<FingerAuth> {

  final LocalAuthentication auth = LocalAuthentication();

  checkAuth()async {
    bool isAvailable;
    isAvailable=await auth.canCheckBiometrics;
    print(isAvailable);
    if(isAvailable){
      
      bool result=await auth.authenticate(
        localizedReason: 'Scan your fingerprint to proceed',
        options : AuthenticationOptions(biometricOnly: true)
        );
        if (result){
          Get.to(Fingerhome());
        }
        else  {
          print('Permission Denied');
        }

    }else{
      print('No biometric sensor detected');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 80,),
          Center(
            child: Text("Login",style: TextStyle(fontSize: 50,fontWeight: FontWeight.normal),),
          ),
          SizedBox(height: 50,),
          Lottie.asset('Animations/fingerAuth.json',height: 180,width: 180,fit: BoxFit.cover),
          SizedBox(height: 30,),
          Center(
            child: Text("Fingerprint Auth",style: TextStyle(fontSize: 28,fontWeight: FontWeight.normal),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 5),
            child: Center(
              child: Text("Authentication using fingerprint to proceed in application"),
            ),
            ),
            SizedBox(height: 100,),

            ElevatedButton( onPressed: () {
                checkAuth(); 
                },
              style: ElevatedButton.styleFrom(
                backgroundColor:Color.fromRGBO(117,201,253,1),
                foregroundColor: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child :Text("Authenticate",style: TextStyle(fontSize: 25,fontWeight: FontWeight.normal),),
                )
              )
            
              ],
      )
    );
  }
}