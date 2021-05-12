import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  // getUsers() {
  //   usersRef.get().then((snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       print(doc.data());
  //     });
  //   });
  // }

  getUsers() async {
    final QuerySnapshot snapshot = await usersRef.get();
    snapshot.docs.forEach((doc) {
      print(doc.data());
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(),
      body: Text('time Line'),
    );
  }
}
