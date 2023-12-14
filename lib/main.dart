import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paxa_health/screens/login_screen.dart';
import 'package:paxa_health/screens/todo_screen.dart';
import 'package:paxa_health/state_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateProvider>(
          create: (_) => StateProvider(),
        ),
      ],
      child: CupertinoApp(
        title: 'Flutter Demo',
        home: LoginScreen(),
      ),
    );
  }
}
// 🐛 {
// I/flutter ( 2169): │ 🐛   "id": 2,
// I/flutter ( 2169): │ 🐛   "username": "hbingley1",
// I/flutter ( 2169): │ 🐛   "email": "hbingley1@plala.or.jp",
// I/flutter ( 2169): │ 🐛   "firstName": "Sheldon",
// I/flutter ( 2169): │ 🐛   "lastName": "Quigley",
// I/flutter ( 2169): │ 🐛   "gender": "male",
// I/flutter ( 2169): │ 🐛   "image": "https://robohash.org/doloremquesintcorrupti.png",
// I/flutter ( 2169): │ 🐛   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJoYmluZ2xleTEiLCJlbWFpbCI6ImhiaW5nbGV5MUBwbGFsYS5vci5qcCIsImZpcnN0TmFtZSI6IlNoZWxkb24iLCJsYXN0TmFtZSI6IlF1aWdsZXkiLCJnZW5kZXIiOiJtYWxlIiwiaW1hZ2UiOiJodHRwczovL3JvYm9oYXNoLm9yZy9kb2xvcmVtcXVlc2ludGNvcnJ1cHRpLnBuZyIsImlhdCI6MTcwMjU0MDA0MSwiZXhwIjoxNzAyNTQzNjQxfQ.Ln3ex8lCHXHLsJlL9rBSWzoAYLZyB36ouyn8UebBawM"
// I/flutter ( 2169): │ 🐛 }
