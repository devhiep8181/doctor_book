import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_book/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              final firestoreInstance = FirebaseFirestore.instance;
              firestoreInstance.collection("bacsi").add({
                "name": "john",
                "age": 50,
                "email": "example@example.com",
                "address": {"street": "street 24", "city": "new york"}
              }).then((value) {
                print(value.id);
              });
            },
            child: const Text('ADD DATA')),
      ),
    );
  }
}
