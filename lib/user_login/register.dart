import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({
    Key? key,
  }) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  late String select;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool PasswordPatDay = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.30,
                  left: 35,
                  right: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: fullNameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email ID',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: PasswordPatDay,
                      style: const TextStyle(color: Colors.white),
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
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              var fullName = fullNameController.text.trim();
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();
                              var phone = phoneController.text.trim();
                              if (fullName.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  phone.isEmpty) {
                                //show toast
                                Fluttertoast.showToast(
                                    msg: 'please fill all fields',backgroundColor: Colors.red);

                                return;
                              }
                              if (password.length < 6) {
                                //show toast
                                Fluttertoast.showToast(
                                    msg:
                                        'Weak password,\nAt least 6 or more characters are required',backgroundColor: Colors.red);
                                return;
                              }
                              //request to firebaseAuth

                              ProgressDialog progressDialog = ProgressDialog(
                                context,
                                title: const Text('Signing up'),
                                message: const Text('please wait'),
                              );
                              progressDialog.show();
                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential usercredential =
                                    await auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                if (usercredential.user != null) {


                                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                                  String uid = usercredential.user!.uid;
                                  int dt = DateTime.now().microsecondsSinceEpoch;

                                  final store = FirebaseFirestore.instance.collection('users').doc(uid);

                                  await store.collection('Account').doc(dt.toString()).set({

                                    'fullName' : fullName,
                                    'email' : email,
                                    'password' : password,
                                    'uid' : uid,
                                    'dt' : dt,
                                    'profileImage': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrQoGh518HulzrSYOTee8UO517D_j6h4AYQ&usqp=CAU'

                                  });

                                  Fluttertoast.showToast(msg: 'success');
                                  Navigator.of(context).pop();
                                } else {
                                  Fluttertoast.showToast(msg: 'Failed',backgroundColor: Colors.red);
                                }
                                progressDialog.dismiss();
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();

                                if (e.code == 'email-already-in-use') {
                                  Fluttertoast.showToast(
                                      msg: 'Email is already in use',backgroundColor: Colors.red);
                                } else if (e.code == 'weak-password') {
                                  Fluttertoast.showToast(
                                      msg: 'password is weak',backgroundColor: Colors.red);
                                }
                              } catch (e) {
                                progressDialog.dismiss();

                                Fluttertoast.showToast(
                                    msg: 'something went wrong',backgroundColor: Colors.red);
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
