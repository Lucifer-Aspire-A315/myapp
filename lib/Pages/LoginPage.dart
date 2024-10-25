import 'package:flutter/material.dart';
import 'package:myapp/Pages/HomePage.dart';
import 'package:myapp/Pages/SigninPage.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LinearGradient linearGradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 245, 92, 82),
        Color.fromARGB(255, 88, 155, 209),
        Color.fromARGB(255, 113, 212, 117),
      ],
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
                controller: TextEditingController(text: 'E-mail/Contact'),
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage(),)
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 40),
                  backgroundColor: const Color.fromARGB(204, 95, 31, 243),
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
                              builder: (context) => const Signin(),
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
    );
  }
}
