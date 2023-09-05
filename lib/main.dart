import 'package:exam/Main Screens/Dashbord.dart';
import 'package:exam/Main Screens/Sign_in.dart';
import 'package:exam/Main Screens/Sign_up.dart';
import 'package:exam/Services/googlesignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  static final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/Signin": (_) => const SignIn(),
          "/Signup": (_) => const SignUp(),
          "/Dashboard": (_) => const Dashboard()
        },
        home: const SignIn(),
      ));
}
