import 'dart:async';

import "package:flutter/material.dart";

import "../data/api/mod.dart";
import "../data/theme.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double width = 0;
  double height = 0;
  String submitText = "Submit";
  String uid = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      width = (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .width *
              80) /
          100;
      height = (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .height *
              80) /
          100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "User Id",
                      icon: width >= 250
                          ? const Icon(
                              Icons.supervised_user_circle_outlined,
                            )
                          : null,
                      iconColor: Colors.black,
                    ),
                    initialValue: uid,
                    onSaved: (value) {
                      setState(() {
                        uid = value as String;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a user id";
                      } else if (value.length < 8) {
                        return "Enter valid user id";
                      } else if (int.tryParse(value) == null) {
                        return "Invalid User id";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      icon: width >= 250
                          ? const Icon(
                              Icons.password_rounded,
                            )
                          : null,
                      iconColor: Colors.black,
                    ),
                    initialValue: password,
                    onSaved: (value) {
                      setState(() {
                        password = value as String;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a valid password";
                      } else if (value.length < 8) {
                        return "Password must be more than 8 digits";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 80,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Timer(const Duration(milliseconds: 200), () {
                          setState(() {
                            submitText = "Checking";
                          });
                          setUser(uid, password);
                          verify().then((status) {
                            if (!status) {
                              setState(() {
                                submitText = "Invalid!";
                              });
                              Timer(const Duration(seconds: 2), () {
                                setState(() {
                                  submitText = "Submit";
                                });
                              });
                            }
                          }).catchError((_) {
                            setState(() {
                              submitText = "Error";
                            });
                            Timer(const Duration(seconds: 2), () {
                              setState(() {
                                submitText = "Submit";
                              });
                            });
                          });
                        });
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 60,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          (submitText != "Submit" && submitText != "Checking")
                              ? Colors.red[500]
                              : Colors.blue),
                    ),
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        submitText,
                        textAlign: TextAlign.center,
                      ),
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
