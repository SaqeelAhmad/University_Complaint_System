import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:university_compaint/users/profile_screen.dart';


import '../user_login/login.dart';
import 'home_screen.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {


  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: Colors.white.withOpacity(0.9),
      borderRadius: 24,
      style: DrawerStyle.style3,
      moveMenuScreen: false,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      mainScreen:  const HomeScreen(),
      menuScreen: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String dt = DateTime.now().microsecondsSinceEpoch.toString();
  final fireStore = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Account')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: StreamBuilder(
        stream: fireStore,
        builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                     Container(
                       width: 150,
                       height: 150,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(200),
                         border:Border.all(width: 2,color: Colors.black)
                       ),
                       child: ClipOval(

                        child: CachedNetworkImage(imageUrl: snapshot.data!.docs[index]['profileImage'].toString(),fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Icon(Icons.error),),

                    ),
                     ),

                    const SizedBox(height: 20,),
                    Text(snapshot.data!.docs[index]['fullName'].toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 100,),
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Screen1()));
                        }, icon: const Icon(Icons.home),),
                        const Text("Home"),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileScreen()));
                        }, icon: const Icon(Icons.person),),
                        const Text("Profile"),
                      ],
                    ),
                    const SizedBox(height: 20,),


                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.help_center),),
                        const Text("Any Issue"),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation!!!'),
                                      content: const Text('Are you sure to logout ? '),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: (const Text('No'))),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();

                                              FirebaseAuth.instance.signOut();
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(builder: (context) {
                                                    return const MyLogin();
                                                  }));
                                            },
                                            child: (const Text('yes'))),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.logout)),const Text('LogOut')

                      ],
                    ),
                  ]);

            });
      } else {
        return Container();
      }
    },
    ));
        }


  }





