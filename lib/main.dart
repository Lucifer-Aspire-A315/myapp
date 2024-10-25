import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(96, 24, 22, 22),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const Signin(),
    );
  }
}

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    LinearGradient linearGradient = const LinearGradient(
      colors: [Colors.red, Colors.blue, Colors.green],
      begin: AlignmentDirectional.topStart,
      end: AlignmentDirectional.bottomEnd,
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter your name",
                    filled: true,
                    fillColor: Colors.blueGrey,
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      maxWidth: 300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: "Contact",
                    hintText: "Enter your contact number",
                    filled: true,
                    fillColor: Colors.blueGrey,
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      maxWidth: 300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    filled: true,
                    fillColor: Colors.blueGrey,
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      maxWidth: 300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    filled: true,
                    fillColor: Colors.blueGrey,
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      maxWidth: 300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 40),
                  backgroundColor: const Color.fromARGB(204, 47, 76, 204),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          }),
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
