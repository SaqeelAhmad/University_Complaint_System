import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var taskController = TextEditingController();
  var natureController = TextEditingController();
  var subCategoryController = TextEditingController();
  String Department = 'Select';
  String Category = 'Select';


  final firestore = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Account')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Complaint'),
        ),

        body: StreamBuilder(

          stream: firestore,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){

                return
                     SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [            //----------------------------- Department--------------------------
                            Row(
                              children: [
                                SizedBox(width: 28,),
                                Text('Department',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 28, right: 28),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(width: 1,color: Colors.black)
                                ),
                                height: 63,
                                width:  double.infinity,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(Department),
                                    Expanded(child: Container()),
                                    Container(
                                      child: PopupMenuButton(
                                        icon: Icon(Icons.menu_open_sharp),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(

                                              child: Column(

                                                children: [
                                                  RadioListTile(
                                                    title: Text('Select'),
                                                    value: 'Select',
                                                    groupValue: Department,
                                                    activeColor: Colors.black,
                                                    onChanged: (value){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Department = value.toString();
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: Text('IBMS(BSCS)'),
                                                    value: 'IBMS(BSCS)',
                                                    groupValue: Department,
                                                    activeColor: Colors.black,
                                                    onChanged: (value){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Department = value.toString();
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: Text('IBMS(BSIT)'),
                                                    value: 'IBMS(BSIT)',
                                                    groupValue: Department,
                                                    activeColor: Colors.black,
                                                    onChanged: (value){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Department = value.toString();
                                                      });
                                                    },

                                                  ),
                                                  RadioListTile(
                                                    title: Text('Other'),
                                                    value: 'Other',
                                                    groupValue: Department,
                                                    activeColor: Colors.black,
                                                    onChanged: (value){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Department = value.toString();
                                                      });
                                                    },

                                                  )
                                                ],
                                              )),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),

                            Row(
                              children: [
                                SizedBox(width: 28,),
                              Text('Category',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 28, right: 28),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(width: 1,color: Colors.black)
                                ),
                                height: 63,
                                width:  double.infinity,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(Category),
                                    Expanded(child: Container()),
                                    Container(
                                      child: PopupMenuButton(
                                        icon: Icon(Icons.menu_open_sharp),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(

                                              child: Column(

                                                children: [
                                                  RadioListTile(
                                                    title: Text('Select'),
                                                    value: 'Select',
                                                    groupValue: Category,
                                                    activeColor: Colors.black,
                                                    onChanged: (value){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Category = value.toString();
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: Text('Faculty'),
                                                    value: 'Faculty',
                                                    groupValue: Category,
                                                    activeColor: Colors.black,
                                                    onChanged: (value){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Category = value.toString();
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: Text('Student'),
                                                    value: 'Student',
                                                    groupValue: Category,
                                                    activeColor: Colors.black,
                                                    onChanged: (value){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Category = value.toString();
                                                      });
                                                    },

                                                  ),
                                                ],
                                              )),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30, left: 29),
                              child: TextField(

                                controller: natureController,
                                decoration: const InputDecoration(
                                    label: Text('Registration No'),
                                    labelStyle: TextStyle(
                                        fontSize: 18
                                    ),
                                    hintText: 'eg: 2018_agr_u_12345',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(right: 30, left: 30),
                              child: TextField(
                                controller: subCategoryController,
                                decoration: const InputDecoration(
                                    hintText: 'Sub category',
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30, left: 30),
                              child: TextField(
                                controller: taskController,
                                decoration: const InputDecoration(
                                    hintText: 'Complaint',
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    border: OutlineInputBorder()),
                                maxLines: 5,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String Profile = snapshot.data!.docs[index]['profileImage'].toString();
                                String fullName = snapshot.data!.docs[index]['fullName'].toString();
                                String taskName = taskController.text.trim();
                                String natureName = natureController.text.trim();
                                String subCategoryName = subCategoryController.text.trim();

                                if (natureName.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'please provide nature',
                                      gravity: ToastGravity.CENTER);
                                  return;
                                }

                                if (subCategoryName.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'please provide sub category',
                                      gravity: ToastGravity.CENTER);
                                  return;
                                }

                                if (taskName.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'please provide task name',
                                      gravity: ToastGravity.CENTER);
                                  return;
                                }
                                User? user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  final dt = DateTime.now().microsecondsSinceEpoch;
                                  FirebaseFirestore firestor = FirebaseFirestore.instance;

                                  firestor.collection('admin_tasks').doc(dt.toString()).set({
                                    'profileImage':Profile,
                                    'id' : FirebaseAuth.instance.currentUser!.uid,
                                    'fullName' : fullName,
                                    'dt': dt,
                                    'taskName': taskName,
                                    'natureName': natureName,
                                    'subCategoryName': subCategoryName,
                                    'Department' : Department,
                                    'Category' : Category,
                                  });

                                  String uid = user.uid;
                                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                                  var taskRef = firestore
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('tasks')
                                      .doc(dt.toString());
                                  await taskRef.set({
                                    'dt': dt,
                                    'profileImage':Profile,
                                    'taskName': taskName,
                                    'fullName' : fullName,
                                    'natureName': natureName,
                                    'subCategoryName': subCategoryName,
                                    'Department' : Department,
                                    'Category' : Category,
                                    'taskId': taskRef.id,
                                  });
                                  Fluttertoast.showToast(
                                      msg: 'Complaint sent successfully',
                                      gravity: ToastGravity.CENTER);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('send'),
                            ),
                          ],
                        ),
                      ),
                    );

              });



            }else{
              return Container();
            }
          },

        )

      //  SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       children: [
      //         FormHelper.dropDownWidgetWithLabel(
      //           context,
      //           "Category",
      //           "select category",
      //           this.categoryId,
      //           this.category,
      //           (onChanged) {
      //             this.categoryId = onChanged;
      //
      //             print("Selected Category : $onChanged");
      //           },
      //           (onValidate) {
      //             if (onValidate == null) {
      //               Fluttertoast.showToast(msg: "please select category");
      //               return;
      //             }
      //           },
      //           borderColor: Theme.of(context).primaryColor,
      //           borderFocusColor: Theme.of(context).primaryColor,
      //           borderRadius: 10,
      //           optionValue: "value",
      //           optionLabel: "name",
      //         ),
      //         FormHelper.dropDownWidgetWithLabel(
      //           context,
      //           "Dicipline",
      //           "select disipline",
      //           this.diciplineId,
      //           this.dicipline,
      //           (onChanged) {
      //             this.diciplineId = onChanged;
      //
      //             print("Selected Dicipline : $onChanged");
      //           },
      //           (onValidate) {
      //             if (onValidate == null) {
      //               Fluttertoast.showToast(msg: "please select dicipline");
      //               return;
      //             }
      //           },
      //           borderColor: Theme.of(context).primaryColor,
      //           borderFocusColor: Theme.of(context).primaryColor,
      //           borderRadius: 10,
      //           optionValue: "value",
      //           optionLabel: "name",
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(right: 30, left: 30),
      //           child: TextField(
      //             controller: subCategoryController,
      //             decoration: const InputDecoration(
      //                 hintText: 'Sub category',
      //                 hintStyle: TextStyle(
      //                   fontSize: 18,
      //                   fontStyle: FontStyle.italic,
      //                 ),
      //                 border: OutlineInputBorder()),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(right: 30, left: 30),
      //           child: TextField(
      //             controller: natureController,
      //             decoration: const InputDecoration(
      //                 hintText: 'Nature',
      //                 hintStyle: TextStyle(
      //                   fontSize: 18,
      //                   fontStyle: FontStyle.italic,
      //                 ),
      //                 border: OutlineInputBorder()),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(right: 30, left: 30),
      //           child: TextField(
      //             controller: taskController,
      //             decoration: const InputDecoration(
      //                 hintText: 'Complaint',
      //                 hintStyle: TextStyle(
      //                   fontSize: 18,
      //                   fontStyle: FontStyle.italic,
      //                 ),
      //                 border: OutlineInputBorder()),
      //             maxLines: 5,
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         ElevatedButton(
      //           onPressed: () async {
      //             String taskName = taskController.text.trim();
      //             String natureName = natureController.text.trim();
      //             String subCategoryName = subCategoryController.text.trim();
      //
      //             if (natureName.isEmpty) {
      //               Fluttertoast.showToast(
      //                   msg: 'please provide nature',
      //                   gravity: ToastGravity.CENTER);
      //               return;
      //             }
      //
      //             if (subCategoryName.isEmpty) {
      //               Fluttertoast.showToast(
      //                   msg: 'please provide sub category',
      //                   gravity: ToastGravity.CENTER);
      //               return;
      //             }
      //
      //             if (taskName.isEmpty) {
      //               Fluttertoast.showToast(
      //                   msg: 'please provide task name',
      //                   gravity: ToastGravity.CENTER);
      //               return;
      //             }
      //             User? user = FirebaseAuth.instance.currentUser;
      //             if (user != null) {
      //               final id = DateTime.now().microsecondsSinceEpoch;
      //               FirebaseFirestore firestor = FirebaseFirestore.instance;
      //
      //               firestor.collection('admin_tasks').doc(id.toString()).set({
      //                 'dt': id,
      //                 'taskName': taskName,
      //                 'natureName': natureName,
      //                 'subCategoryName': subCategoryName,
      //               });
      //
      //               String uid = user.uid;
      //               int dt = DateTime.now().microsecondsSinceEpoch;
      //               FirebaseFirestore firestore = FirebaseFirestore.instance;
      //               var taskRef = firestore
      //                   .collection('tasks')
      //                   .doc(uid)
      //                   .collection('tasks')
      //                   .doc(dt.toString());
      //               await taskRef.set({
      //                 'dt': dt,
      //                 'taskName': taskName,
      //                 'natureName': natureName,
      //                 'subCategoryName': subCategoryName,
      //                 'taskId': taskRef.id,
      //               });
      //               Fluttertoast.showToast(
      //                   msg: 'Complaint sent successfully',
      //                   gravity: ToastGravity.CENTER);
      //               Navigator.of(context).pop();
      //             }
      //           },
      //           child: const Text('send'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
