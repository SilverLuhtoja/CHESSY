import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FireBaseTestScreen extends StatefulWidget {
  const FireBaseTestScreen({Key? key}) : super(key: key);

  @override
  State<FireBaseTestScreen> createState() => _FireBaseTestScreenState();
}

class _FireBaseTestScreenState extends State<FireBaseTestScreen> {
  final database_controller = TextEditingController();
  // final realtime_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIREBASE_TEST_SCREEN"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(60),
            color: Colors.grey,
            child: TextField(controller: database_controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("send to firestore database"),
              IconButton(onPressed: () {
                final name = database_controller.text;

                createUser(name: name);
              }, icon: const Icon(Icons.send)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("send to realtime database"),
              IconButton(onPressed: () {
                final message = database_controller.text;

                sendRealTimeMessage(message: message);
              }, icon: const Icon(Icons.send)),
            ],
          )
        ],
      ),
    );
  }

  Future createUser({required String name}) async {
    // Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');

    final json = {
      'name': name,
      'age': 32,
      'birthday': DateTime(1991, 3, 30),
    };

    // Create document and write data to Firebase
    await docUser.set(json);
  }


  Future sendRealTimeMessage({required String message}) async {
    final DatabaseReference  ref = FirebaseDatabase(databaseURL: "https://kood01-chessy-default-rtdb.europe-west1.firebasedatabase.app").ref();

    final json = {
      'name': "Silvcer",
      'message': message,
    };

    ref.child("users").set(json);
  }
}

// {
// "rules": {
// ".read": "now < 1685566800000",  // 2023-6-1
// ".write": "now < 1685566800000",  // 2023-6-1
// }
// }
