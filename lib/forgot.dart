import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  TextEditingController email=TextEditingController();

 reset() async {
  final emailText = email.text.trim();
  if (emailText.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veuillez saisir une adresse e-mail.")),
    );
    return;
  }

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailText);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ Lien de réinitialisation est envoyé ")),
    );
  } on FirebaseAuthException catch (e) {
    String message = "Une erreur est survenue.";
    if (e.code == 'user-not-found') {
      message = "Aucun utilisateur trouvé pour cet e-mail.";
    } else if (e.code == 'invalid-email') {
      message = "Adresse e-mail invalide.";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ $message")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erreur : ${e.toString()}")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller:email,
              decoration: InputDecoration(hintText: 'Saisir email'),
            ),
            ElevatedButton(onPressed: (()=>reset()), child: Text("Send Link"))
          ],
        ),
      ),
    );
  }
}