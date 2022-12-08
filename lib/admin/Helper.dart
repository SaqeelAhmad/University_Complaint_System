import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'admin_panel.dart';

class Authservice {
  final auth = FirebaseAuth.instance;

  TextEditingController adminEmail = TextEditingController();
  TextEditingController adminPassword = TextEditingController();
  final firestore = FirebaseFirestore.instance;


  void adminLogin(context) async {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });

     await FirebaseFirestore.instance.collection('admin')
        .doc('7CIjVdPHPoWqIi6wbFuc')
        .snapshots()
        .forEach((element) {
      if (element.data()?['adminEmail'] == adminEmail.text &&
          element.data()?['adminPassword'] == adminPassword.text) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> AdminPannel()), (route) => false);
      }}).catchError((e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(e.toString()),
        );
      });

    });

  }

}