import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_store;

import '../widget/utility.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DocumentSnapshot? userSnapshot;
  File? imageFile;
  bool showLocalFile = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String dt = DateTime.now().microsecondsSinceEpoch.toString();
  final fireStore = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Account')
      .snapshots();

// -------------------------------  Image taken to mobile  --------------------------------------
  File? _image;
  final packer = ImagePicker();

  Future imagegetCamera() async {
    final pickedFile =
    await packer.pickImage(source: ImageSource.camera, imageQuality: 40);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  Future imagegetGallery() async {
    final pickedFile =
    await packer.pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: StreamBuilder(
        stream: fireStore,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String id = snapshot.data!.docs[index]['dt'].toString();
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.090,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.107),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 90),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['fullName']
                                            .toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['email']
                                            .toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Joined ${Utility.getHumanReadableDate(snapshot.data!.docs[index]['dt'])}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(200)),
                              //update image
                              child: GestureDetector(  
                                onTap: () {
                                  showModalBottomSheet(context: context, builder: (context){

                                    return Padding(
                                        padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){
                                              imagegetGallery();
                                            }, icon: Icon(Icons.image)),Text('From Gallery',)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){
                                              imagegetCamera();
                                            }, icon: Icon(Icons.camera_alt)),Text('From Camera')
                                          ],
                                        ),
                                        
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(child: Container(

                                              )),
                                              TextButton(onPressed: ()async {

                                                final uid = FirebaseAuth.instance.currentUser!.uid;
                                                final firebaseFirestore = FirebaseFirestore.instance.collection('users').doc(uid);
                                                firebase_store.Reference Users = firebase_store.FirebaseStorage.instance.ref('/Profile Image/'+ id);
                                                firebase_store.UploadTask uploadTask =Users.putFile(_image!.absolute);
                                                await Future.value(uploadTask).then((value) async {

                                                  var newurl = await Users.getDownloadURL();
                                                  firebaseFirestore.collection('Account').doc(id.toString()).update({
                                                    'profileImage' : newurl,
                                                  }).then((value) {
                                                    Navigator.pop(context);
                                                    Utility().toastMessege('Uploaded');
                                                  }).onError((error, stackTrace) {
                                                    Utility().toastMessege(error.toString());
                                                  });

                                                });
                                              }, child: Text('Upload')),
                                              SizedBox(width: 10,)
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    );

                                  });
                                },
                                child: ClipOval(
                                  child: _image != null
                                      ? Image.file(
                                    _image!.absolute,
                                    fit: BoxFit.cover,
                                  )
                                      : CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: snapshot
                                        .data!.docs[index]['profileImage']
                                        .toString(),
                                    errorWidget: (context, url, error) =>
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                    placeholder: (context, url) =>
                                        Container(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Container();
          }
        },
      ),

    );
  }

}