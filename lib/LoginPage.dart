import 'package:flutter/material.dart';
import 'package:myapp/main.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    ColorTween colorTween = ColorTween(
        begin: Colors.white, end: const Color.fromARGB(255, 110, 178, 241));
    return Scaffold(
      body: TweenAnimationBuilder(
        tween: colorTween,
        duration: const Duration(milliseconds: 1500),
        builder: (context, value, child) => Container(
          color: value,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const TextField(
                    decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 300, maxHeight: 50),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Email/Contact',
                )),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                    decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 300, maxHeight: 50),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Password',
                )),
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
                          onEnter: (event) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
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
      ),
    );
  }
}
