import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_compaint/user_login/login.dart';
import 'admin_complaint/admin_completed_screen.dart';
import 'admin_complaint/admin_inprogress_screen.dart';
import 'admin_complaint/admin_pending_screen.dart';


class AdminPannel extends StatefulWidget {
  const AdminPannel({Key? key}) : super(key: key);

  @override
  State<AdminPannel> createState() => _AdminPannelState();
}

class _AdminPannelState extends State<AdminPannel> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
    initialIndex: 0,
        length: 3,
    child: Scaffold(
      appBar: AppBar(
      bottom: const TabBar(
      isScrollable: true,
        indicatorColor: Colors.white,
        labelPadding: EdgeInsets.symmetric(horizontal: 30),
    tabs: [
    Tab(
    icon: Text(
    'Pending',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    Tab(
    icon: Text(
    'In Progrees',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    Tab(
    icon: Text(
    'Completed',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    ],
    ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(context: (context), builder: (context){

                return AlertDialog(

                  title: Text('Confirmation!!!'),
                  content: Text('Are you sure to Logout'),
                  actions: [
                    TextButton(onPressed: (){

                      Navigator.of(context).pop();

                    }, child: Text('No'),),
                    TextButton(onPressed: (){

                      Navigator.of(context).pop();
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return const MyLogin();
                      }));
                      }, child: Text('yes'),),
                  ],
                );
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: const Text('Admin panel'),
      ),
        body: TabBarView(
          children: [
            AdminpendingScreen(),
            AdimninProgressScreen(),
            AdmincompletedScreen(),
          ],
        )


    ),
    );
  }
}
