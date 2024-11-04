import 'package:flutter/material.dart';
import 'package:goormthonfe/views/mainscreen_view.dart';
import 'package:goormthonfe/views/create_appointment_view.dart';
import 'package:goormthonfe/views/post_view.dart';
import 'package:goormthonfe/views/vote_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: VoteScreen(),
    );
  }
}
