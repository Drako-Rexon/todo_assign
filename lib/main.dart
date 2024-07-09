import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/todo_povider.dart';
import 'package:todo_app/views/homepage/homepage.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodoPovider>(create: (_) => TodoPovider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
