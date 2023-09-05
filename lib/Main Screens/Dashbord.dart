import 'package:exam/Main Screens/Orderpage.dart';
import 'package:exam/Main Screens/Profile.dart';
import 'package:exam/Main Screens/Sign_in.dart';
import 'package:exam/Main Screens/homepage.dart';
import 'package:exam/Services/googlesignin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int nowcurrentindex = 0;
  final Screens = [const homepage(), const order(), const profile()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                  Navigator.of(context).pushNamed('/Signin');
                  var sharedpref = await SharedPreferences.getInstance();
                  sharedpref.setBool(SignInState.keylogin, false);
                },
                icon: const Icon(Icons.logout))
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SignIn()));
            },
          ),
          title: const Text("Dashboard"),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          currentIndex: nowcurrentindex,
          onTap: (index) => setState(() => nowcurrentindex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: "Order",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            )
          ],
        ),
        body: SingleChildScrollView(child: Screens[nowcurrentindex]),
      ),
    );
  }
}
