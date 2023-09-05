import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordobsured = true;
  bool check = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

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
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text("Sign Up Page"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.01, right: size.width * 0.01),
                    child: Image.asset(
                      "images/login.jpg",
                      width: size.width,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(size.height * 0.01),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.cyan,
                          validator: Validators.compose(
                              [Validators.required("Enter your name")]),
                          decoration: const InputDecoration(
                            hintText: "Name",
                            icon: Icon(Icons.person),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01)),
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.cyan,
                          validator: Validators.compose([
                            Validators.required("Email is reqiured"),
                            Validators.email("Invalid Email Address")
                          ]),
                          decoration: const InputDecoration(
                            hintText: "Email ID",
                            icon: Icon(Icons.account_box),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01)),
                        TextFormField(
                            controller: passwordcontroller,
                            cursorColor: Colors.cyan,
                            keyboardType: TextInputType.text,
                            obscureText: passwordobsured,
                            validator: Validators.compose(
                                [Validators.required("Enter password")]),
                            decoration: InputDecoration(
                              hintText: "Password",
                              icon: const Icon(Icons.lock),
                              suffixIcon: togglePassword(),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01)),
                        TextFormField(
                            controller: confirmpassword,
                            cursorColor: Colors.cyan,
                            validator: Validators.compose([
                              Validators.required("Enter confirm password")
                            ]),
                            keyboardType: TextInputType.text,
                            obscureText: passwordobsured,
                            decoration: InputDecoration(
                              hintText: " Confirm Password",
                              icon: const Icon(Icons.confirmation_number_sharp),
                              suffixIcon: togglePassword(),
                            )),
                      ],
                    ),
                  ),
                  CheckboxMenuButton(
                    value: check,
                    onChanged: (check) {
                      setState(() {
                        this.check = check!;
                      });
                    },
                    child: const Text("Terms and Condition"),
                  ),
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.6,
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate() && check == true) {
                          emailcontroller.clear();
                          confirmpassword.clear();
                          namecontroller.clear();
                          passwordcontroller.clear();
                          Navigator.of(context).pushNamed("/Dashboard");
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/Signin");
                      },
                      child: const Text.rich(TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        text: "Already have Account?",
                        children: [
                          TextSpan(
                            style: TextStyle(color: Colors.cyan, fontSize: 18),
                            text: "Sign In",
                          )
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
