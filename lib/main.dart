import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:book_library_flutter/providers/api.dart';
import 'package:book_library_flutter/screens/detailed_screen.dart';
import 'package:book_library_flutter/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Api>(
      create: (context) => Api(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          // animationDuration: ,
          duration: 5000,
          nextScreen: HomePage(),
          splash: Builder(builder: (context) {
            return Center(
              child: LottieBuilder.network(
                'https://assets10.lottiefiles.com/packages/lf20_1a8dx7zj.json',
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
            );
          }),
        ),
      ),
    );
  }
}
