import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'home.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );

 //await  uploadFiletest();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorFind',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: const HomePage(),
    );
  }



}
/*
uploadFiletest() async {


  final path = 'C:/Users/vini5/Desktop/Krita/gui.png';
  final destination = 'files/gui.png';
  File? _photo = File(path);
  try {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .child('file/');
    await ref.putFile(_photo!);
  } catch (e) {
    print('$e');
  }


}
*/
