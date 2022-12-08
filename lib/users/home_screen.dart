import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:university_compaint/users/profile_screen.dart';

import 'taskAdd.dart';
import 'users_complaint/completed_screen.dart';
import 'users_complaint/inprogress_screen.dart';
import 'users_complaint/pending_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended( // Make Complaint----------------------------------------
          elevation: 0.0,
          foregroundColor: Colors.cyanAccent,
          label: const Text('Make Complaint'),
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AddTaskScreen();
            }));
          },
        ),
        appBar: AppBar(
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelPadding: EdgeInsets.symmetric(horizontal: 30),
            tabs: [
              Tab(  //------------------------------Tabs-------------------------------------------------
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
          backgroundColor: Colors.blueGrey,
          leading: InkWell(
              onTap: () => ZoomDrawer.of(context)?.toggle.call(),
              child: const Icon(Icons.menu)),
          title:  Center(child:  Text('Home')),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return  const ProfileScreen();
                  }));
                },
                icon: const Icon(Icons.person)),
          ],
        ),
        body: TabBarView(
          children: [
            pendingScreen(),
            inProgressScreen(),
            completedScreen(),
          ],
        )
    ));
  }
}
