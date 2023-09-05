import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loggedin extends StatefulWidget {
  const loggedin({super.key});

  @override
  State<loggedin> createState() => _loggedinState();
}

class _loggedinState extends State<loggedin> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.35),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
          const SizedBox(
            height: 12,
          ),
          Text("Name :- ${user.displayName!}"),
          const SizedBox(
            height: 8,
          ),
          Text("Email :- ${user.email!}"),
        ],
      ),
    );
  }
}
