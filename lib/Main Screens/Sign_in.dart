import 'package:exam/Main%20Screens/Dashbord.dart';
import 'package:exam/Services/googlesignin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends State<SignIn> {
  String password1 = "";

  String email1 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late String email;
  late String password;
  static const String keylogin = "login";
  void wheretogo() async {
    var sharedpref = await SharedPreferences.getInstance();
    var isloggedin = sharedpref.getBool(keylogin);

    if (isloggedin != null) {
      if (isloggedin) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      } /*else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }*/
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    }
  }

  bool passwordobsured = true;
  final _formfield = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          passwordobsured = !passwordobsured;
        });
      },
      icon: passwordobsured
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Sign In Page"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formfield,
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(
                      left: size.width * 0.01, right: size.width * 0.01),
                  child: Image.asset(
                    "images/person.jpg",
                    width: size.width,
                  )),
              Container(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: EdgeInsets.only(top: size.height * 0.01)),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      cursorColor: Colors.cyan,
                      decoration: const InputDecoration(
                        hintText: "Email ID",
                        icon: Icon(Icons.account_box),
                      ),
                      validator: Validators.compose([
                        Validators.required("email is required"),
                        Validators.email("Invalid email address")
                      ]),
                    ),
                    Padding(padding: EdgeInsets.only(top: size.height * 0.01)),
                    TextFormField(
                      controller: passwordcontroller,
                      cursorColor: Colors.cyan,
                      obscureText: passwordobsured,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: const Icon(Icons.lock),
                        suffixIcon: togglePassword(),
                      ),
                      validator: Validators.compose(
                          [Validators.required("password is required")]),
                    )
                  ],
                ),
              ),
              Container(
                height: size.height * 0.07,
                width: size.width * 0.6,
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text("Sign In"),
                  onPressed: () {
                    email1 = emailcontroller.text;
                    password1 = passwordcontroller.text;
                    setState(() async {
                      if (_formfield.currentState!.validate()) {
                        Navigator.of(context).pushNamed("/Dashboard");
                        var sharedpref = await SharedPreferences.getInstance();
                        sharedpref.setBool(SignInState.keylogin, true);
                        sharedpref.setString(email, email1);
                        sharedpref.setString(password, password1);
                      }
                    });
                    emailcontroller.clear();
                    passwordcontroller.clear();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.15, top: size.height * 0.01),
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.cyan),
                  onPressed: () {},
                  child: const Text(
                    "Forgot Your Password?",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: SizedBox(
                  height: size.height * 0.053,
                  width: size.width * 0.6,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.white54),
                      onPressed: () {
                        setState(() async {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                          Navigator.of(context).pushNamed("/Dashboard");
                          var sharedpref =
                              await SharedPreferences.getInstance();
                          sharedpref.setBool(SignInState.keylogin, true);
                        });
                      },
                      label: const Text(
                        "Login With Google",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      icon: Image.asset(
                        "images/google.png",
                        width: 30,
                      )),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/Signup");
                  },
                  child: const Text.rich(TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    text: "Don't Have Account?",
                    children: [
                      TextSpan(
                        style: TextStyle(color: Colors.cyan, fontSize: 18),
                        text: "Register",
                      )
                    ],
                  )),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
