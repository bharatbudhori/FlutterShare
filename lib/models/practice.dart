import 'package:flutter/material.dart';

import 'package:flutter_share/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/home.dart';

//final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    getUsersById();
    getUsers();
    createUser();
    updateUser();
    deleteUser();
    super.initState();
  }

  //**************adding with custom Id('bharat') */
  // createUser() async {
  //   await usersRef.doc('bharat').set({
  //     'username': 'Henry',
  //     'isAdmin': false,
  //     'postsCount': 4,
  //   });
  // }

  createUser() async {
    await usersRef.add({
      'username': 'Henry',
      'isAdmin': false,
      'postsCount': 4,
    });
  }

  updateUser() async {
    //await usersRef.doc('bharat')
    final docData = await usersRef.doc('bharat').get();
    if (docData.exists) {
      docData.reference.update({
        'username': 'Jason',
        'isAdmin': false,
        'postsCount': 1,
      });
    }

    // .update({
    //   'username': 'Jason',
    //   'isAdmin': false,
    //   'postsCount': 1,
    // });
  }

  deleteUser() async {
    //usersRef.doc('bharat').delete();
    final docData = await usersRef.doc('bharat').get();
    if (docData.exists) {
      docData.reference.delete();
    }
  }

  // getUsers() {
  //   usersRef.get().then((snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       print(doc.data());
  //     });
  //   });
  // }

  getUsers() async {
    final QuerySnapshot snapshot = await usersRef
        .limit(1)
        .orderBy('postsCount', descending: true)
        .where('isAdmin', isEqualTo: true)
        .where('username', isEqualTo: 'Fred')
        .get();

    setState(() {
      users = snapshot.docs;
    });
    snapshot.docs.forEach((doc) {
      print(doc.data());
      print(doc.id);
    });
  }

  getUsersById() async {
    final String id = 'oV7RB8I1z8XSCXS2TYnQ';
    final DocumentSnapshot doc = await usersRef.doc(id).get();

    print(doc.data());
    print(doc.id);
    print(doc.exists);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(),
      // body: Container(
      //   child: ListView.builder(
      //     itemCount: users.length,
      //     itemBuilder: (context, index) {
      //       return users.map((user) => Text(user['username'])).toList()[index];
      //     },
      //   ),
      // ),

      body: StreamBuilder(
        //future: usersRef.get(),
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<dynamic> userData =
              snapshot.data.docs.map((doc) => Text(doc['username'])).toList();
          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return userData[index];
            },
          );
        },
      ),
    );
  }
}
