import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ndialog/ndialog.dart';
import 'package:university_compaint/user_login/register.dart';

import '../admin/Helper.dart';
import '../users/screen1.dart';
import 'Forget_password.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool PasswordPatDay = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [

            SingleChildScrollView(
              child: Container(

                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 35,
                  right: 35,
                ),
                child: Column(
                  children: [
                    Container(
                      padding:  EdgeInsets.only(left: 20,right: 130),
                      child: Text(
                        'Welcome\nBack',
                        style: TextStyle(color: Colors.white, fontSize: 33),
                      ),
                    ),

                    SizedBox(height: 120,),

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: PasswordPatDay,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                PasswordPatDay = !PasswordPatDay;
                              });
                            },
                            icon: Icon(PasswordPatDay
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SIGN IN',
                          style: TextStyle(
                              color: Color(0xff4c505b),
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                //show toast
                                Fluttertoast.showToast(
                                    msg: 'please fill all fields',
                                    backgroundColor: Colors.red);
                                return;
                              }
                              //request to firebaseAuth
                              ProgressDialog progressDialog = ProgressDialog(
                                context,
                                title: Text('Logging In'),
                                message: Text('please wait'),
                              );
                              progressDialog.show();

                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential userCredential =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                if (userCredential.user != null) {
                                  progressDialog.dismiss();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return const Screen1();
                                  }));
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'user-not-found') {
                                  Fluttertoast.showToast(
                                      msg: 'User not found',
                                      backgroundColor: Colors.red);
                                } else if (e.code == 'wrong-password') {
                                  Fluttertoast.showToast(
                                      msg: 'Wrong password',
                                      backgroundColor: Colors.red);
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: 'something went wrong',
                                    backgroundColor: Colors.green);
                                progressDialog.dismiss();
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator .push(context, MaterialPageRoute(builder: (context)=> AdminLogin()));

                          },
                          child: Text(
                            'Admin',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const MyRegister();
                            }));
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff4c505b),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ForgotPassword()));},
                            child: Text(
                              'FORGOT PASSWORD',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff4c505b),
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  Authservice authservice = Authservice();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage( // Admin Asset------------------------------------------------------------
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 80, top: 130),
              child: const Text(
                'Admin',
                style: TextStyle(color: Colors.white, fontSize: 33,),
              ),

            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: 35,
                  right: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: authservice.adminEmail,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: authservice.adminPassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SIGN IN',
                          style: TextStyle(
                              color: Color(0xff4c505b),
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),

                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              if(authservice.adminEmail.text.isEmpty || authservice.adminPassword.text.isEmpty){
                                Fluttertoast.showToast(msg: 'please fill all fields');
                                return;
                              }
                              if(authservice.adminEmail != " " && authservice.adminPassword != " "){

                                authservice.adminLogin(context);
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),


                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
