import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                child: const Text('Log In'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  text: 'Don`t have an account? ',
                  children: [
                    TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signin(),
                              ),
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
