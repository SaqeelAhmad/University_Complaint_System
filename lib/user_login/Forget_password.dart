import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/utility.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController Email = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Forget Password'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: Email,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: (){ForegetAuth();}, child: Text("Forget"))

          ],
        ),
      ),
    );
  }
  void ForegetAuth(){
    if (_formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      auth
          .sendPasswordResetEmail(email: Email.text.toString())
          .then((value) {
        Utility().toastMessege(
            "We have sent you email to recover password, please check email.");

        Navigator.pop(context);
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utility().toastMessege(error.toString());
      });
    } else {
      return null;
    }
  }
}