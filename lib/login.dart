import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentification_1/fingerauth.dart';
import 'package:flutter_authentification_1/forgot.dart';
import 'package:flutter_authentification_1/signup.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isloading = false;

  login() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signIn() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text("Login"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: 'Enter Email'),
                  ),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(hintText: 'Enter Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: signIn,
                    child: Text("Login"),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Get.to(Signup()),
                    child: Text("Register"),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Get.to(Forgot()),
                    child: Text("Forgot Password?"),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: login,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  
                  ElevatedButton(
                  onPressed: () => Get.to(FingerAuth()),
                  child: Text("Login with Fingerprint"),
                ),
                ],
              ),
            ),
          );
  }
}
