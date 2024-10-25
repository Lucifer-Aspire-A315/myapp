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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 88, 155, 209),
            Color.fromARGB(255, 113, 212, 117),
            Color.fromARGB(255, 247, 236, 145),
            Color.fromARGB(255, 250, 183, 82),
            Color.fromARGB(255, 245, 92, 82),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        )),
        // decoration: BoxDecoration(
        //   gradient: linearGradient,
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: TextEditingController(text: 'Name'),
                decoration: InputDecoration(
                    filled: true,
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
                controller: TextEditingController(text: 'Contact'),
                decoration: InputDecoration(
                    filled: true,
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
                controller: TextEditingController(text: 'E-mail'),
                decoration: InputDecoration(
                    filled: true,
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
                controller: TextEditingController(text: 'Password'),
                decoration: InputDecoration(
                    filled: true,
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
                  backgroundColor: const Color.fromARGB(204, 95, 31, 243),
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
                        onEnter: (event) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          decoration: TextDecoration.underline,
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
