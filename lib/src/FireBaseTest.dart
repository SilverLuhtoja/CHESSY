import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FireBaseTest extends StatefulWidget {
  final FirebaseApp app;

  const FireBaseTest({super.key, required this.app});

  @override
  State<FireBaseTest> createState() => _FireBaseTestState();
}

class _FireBaseTestState extends State<FireBaseTest> {
  final referenceDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.ref();
    return const Placeholder();
  }
}
