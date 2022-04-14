import 'package:flutter/material.dart';
import 'package:taskapp/page/notes_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   _navigateToHome();
  // }

  // _navigateToHome() async {
  //   await Future.delayed(Duration(milliseconds: 2000), () {});
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => NotesPage()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/assets/notesIcon.png"),
              Text(
                "Notes",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
