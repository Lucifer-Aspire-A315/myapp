import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Pages/LoginPage.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
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
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
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
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: 'Contact',
                    hintText: 'Enter Your Mobile No.',
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
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Enter Your E-mail ID',
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
                controller: TextEditingController(),
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    )),
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
