import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class completedScreen extends StatefulWidget {
  const completedScreen({Key? key}) : super(key: key);

  @override
  State<completedScreen> createState() => _completedScreen();
}

class _completedScreen extends State<completedScreen> {
  final userStore = FirebaseFirestore.instance.collection('Completed_users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: userStore.collection('tasks').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

          if(snapshot.hasData){
            if(snapshot.data!.docs.isEmpty){

            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  String profile =
                  snapshot.data!.docs[index]['profileImage'].toString();
                  String id = snapshot.data!.docs[index]['id'].toString();
                  String fullName =
                  snapshot.data!.docs[index]['fullName'].toString();
                  String dt = snapshot.data!.docs[index]['dt'].toString();
                  String taskName =
                  snapshot.data!.docs[index]['taskName'].toString();
                  String natureName =
                  snapshot.data!.docs[index]['natureName'].toString();
                  String subCategoryName =
                  snapshot.data!.docs[index]['subCategoryName'].toString();
                  String Department =
                  snapshot.data!.docs[index]['Department'].toString();
                  String Category =
                  snapshot.data!.docs[index]['Category'].toString();

                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.greenAccent,
                      ),
                    ),
                    elevation: 50,
                    shadowColor: Colors.blueAccent,
                    child: Column(
                      children: [
                        ListTile(
                          //----------------------------Adding full name and date in listTile-------------
                          title: Text(snapshot.data!.docs[index]['fullName']
                              .toString()),
                          // subtitle: Text(Utility.getHumanReadableDate(
                          //     snapshot.data!.docs[index]['dt'])),
                          trailing: ElevatedButton(
                              onPressed: () {
                                //--------------- View Complaint-------------------------
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (ctx) {
                                                      return AlertDialog(
                                                        title:
                                                        const Text('Confirmation !!!'),
                                                        content: const Text(
                                                            'Are you sure to delete ? '),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: const Text('No')),
                                                          TextButton(
                                                              onPressed: () async {
                                                                Navigator.of(context).pop();
                                                                if (userStore != null) {
                                                                  await FirebaseFirestore.instance.collection('Completed_users')
                                                                  .doc(id).collection('tasks').doc(dt).delete();
                                                                  // await taskRef!
                                                                  //     .doc(
                                                                  //     '${snapshot.data!.docs[index]['taskId']}')
                                                                  //     .delete();
                                                                  Navigator.of(context).pop();

                                                                }
                                                              },
                                                              child: const Text('Yes')),
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                size: 20,
                                              )),
                                        ],

                                        title: Text(snapshot
                                            .data!.docs[index]['fullName']
                                            .toString()),
                                      ),
                                      body: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 18,
                                                  ),
                                                  // Text(Utility
                                                  //     .getHumanReadableDate(
                                                  //     snapshot.data!
                                                  //         .docs[
                                                  //     index]
                                                  //     ['dt'])),
                                                ],
                                              ),
                                              Card(
                                                //----------------Card in view complaint---------------------
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20.0),
                                                  side: BorderSide(
                                                    color:
                                                    Colors.greenAccent,
                                                  ),
                                                ),
                                                elevation: 50,
                                                shadowColor:
                                                Colors.blueGrey[100],
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 20,
                                                      right: 8,
                                                      left: 8,
                                                      bottom: 20),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text('Category',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          Text(snapshot
                                                              .data!
                                                              .docs[index][
                                                          'Category']
                                                              .toString()),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Department',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          Text(snapshot
                                                              .data!
                                                              .docs[index][
                                                          'Department']
                                                              .toString()),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text('Registration No',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          Text(snapshot
                                                              .data!
                                                              .docs[index][
                                                          'natureName']
                                                              .toString()),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Sub_Category',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          Text(snapshot
                                                              .data!
                                                              .docs[index][
                                                          'subCategoryName']
                                                              .toString()),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(
                                                        color: Colors
                                                            .blueAccent,
                                                      ),
                                                      //-------Divider------------
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Complaint',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width:
                                                        double.infinity,
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                          'taskName']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(
                                                        color: Colors
                                                            .blueAccent,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      //-------Divider---------------
                                                      Text(
                                                        'Replying.......',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Container(
                                                        width: double.infinity,
                                                        child: Text(snapshot.data!.docs[index]['adminCompleted'].toString(),style: TextStyle(
                                                          fontSize: 18,
                                                        ),),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )));
                              },
                              //----------------------------------------------------------------------------
                              child: Text('View')),
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title: Text(snapshot
                                          .data!.docs[index]['fullName']
                                          .toString()),
                                    ),
                                    body: Center(
                                      child: Hero(
                                        tag: () {},
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: snapshot.data!
                                              .docs[index]['profileImage'],
                                          errorWidget:
                                              (context, url, error) => Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                                child: Center(
                                                  child:
                                                  CircularProgressIndicator(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                                  )));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.docs[index]
                                  ['profileImage'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );


                });
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
