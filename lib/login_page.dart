import 'package:flutter/material.dart';
import 'package:loginapp/home_page.dart';

import 'package:loginapp/services/login_validation.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUserName = TextEditingController();

  TextEditingController controllerPWD = TextEditingController();

  bool isVisibile = false;

  loginCheckRouter() async {
    bool isLoggedIn = await loginStatus();
    if (isLoggedIn == true) {
      //print("Login Status: $isLoggedIn");
      //
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => const HomePage())),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    loginCheckRouter();
  }

  @override
  void dispose() {
    super.dispose();
    controllerPWD.dispose();
    controllerUserName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: Lottie.asset(
                  'assets/lotties/walking.json',
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 700),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      spreadRadius: 0.1,
                      color: Color.fromARGB(255, 210, 210, 210),
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Amigos",
                      style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'FontBunchBlossom'),
                    ),
                    Container(
                      //GAP

                      height: 20,
                    ),
                    TextField(
                      controller: controllerUserName,
                      style: const TextStyle(fontFamily: 'FontAndaleMono'),
                      decoration: const InputDecoration(
                        //hintText: "Username",
                        label: Text("Username"), //instead of hintText
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Container(
                      //GAP

                      height: 20,
                    ),
                    TextField(
                      controller: controllerPWD,
                      obscureText: true,
                      style: const TextStyle(fontFamily: 'FontAndaleMono'),
                      decoration: const InputDecoration(
                        // hintText: "Password",
                        label: Text("Password"), //instead of hint text
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Visibility(
                      visible: isVisibile,
                      child: const Text(
                        "Username and password doesn't match!!",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Container(
                      //GAP

                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (await loginValidate(
                              //THis function validates if username and pwd is correct
                              username: controllerUserName.text,
                              password: controllerPWD.text)) {
                            //print("Credentials Matched!!");
                            setState(() {
                              isVisibile = false;
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false);
                            //
                            const snackBar = SnackBar(
                              content: Text("Login Successful"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            //print("Credentials Mismatch :(:(");

                            setState(() {
                              isVisibile = true;
                            });
                          }
                        },
                        child: const Text(
                          "        Login        ",
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
