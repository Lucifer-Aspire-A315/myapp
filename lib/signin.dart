// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/Pages/gocolors1.dart';
// import 'package:myapp/registration.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // Import your MainScreen

// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController Mobile = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   Future<void> checkMobileNumber(String mobile) async {
//     final url = Uri.parse(
//         'http://192.168.1.10:5002/api/auth/check-mobile'); // Replace with your API URL

//     try {
//       // Send a POST request to check if the mobile number exists
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"mobileNo": mobile}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print(data);
//         final Mobileno = data['user']['mobileNo'];

//         print(Mobileno);
//         // final userEmail = data['userEmail'];

//         // await prefs.setString('exists', data['exists']);
//         final email = data['user']['email'] ??
//             ''; // Extracting email from the 'user' object
//         final dob = data['user']['dateOfBirth'] ??
//             ''; // Extracting dateOfBirth from the 'user' object
//         final firstname = data['user']['firstName'] ??
//             ''; // Extracting firstName from the 'user' object
//         final lastname = data['user']['lastName'] ?? '';
//         // final Mobileno = data['user']['mobileNo'] ??
//         ''; // Extracting lastName from the 'user' object
//         final id = data['user']['id'] ?? '';

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('email', email);
//         await prefs.setString('dob', dob);
//         await prefs.setString('firstname', firstname);
//         await prefs.setString('lastname', lastname);
//         await prefs.setString('Mobileno', Mobileno);
//         await prefs.setInt('id', id);

//         if (data['exists'] == true) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Welcome")),
//           );
//           // Navigate to MainScreen if the mobile number exists
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => Home()),
//           );
//         } else {
//           // Navigate to RegistrationScreen if the mobile number does not exist
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => RegistrationScreen(Mobile: mobile),
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: Unable to check mobile number.")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to connect to the server.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "MEMBER LOGIN / SIGN UP",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 TextFormField(
//                   controller: Mobile,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     hintText: "Phone",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your phone number";
//                     } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                       return "Please enter a valid 10-digit phone number";
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // Call the API to check if the mobile number exists
//                       checkMobileNumber(Mobile.text);
//                     } else {
//                       // Show an error message if validation fails
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text("Please enter a valid phone number."),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     padding: EdgeInsets.symmetric(vertical: 15.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Submit",
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/gocolors1.dart';
import 'package:myapp/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state

  Future<void> checkMobileNumber(String mobile) async {
    final url = Uri.parse(
        'http://192.168.1.10:5002/api/auth/check-mobile'); // Replace with your API URL

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      // Send a POST request to check if the mobile number exists
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"mobileNo": mobile}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final bool exists = data['exists'] ?? false;

        if (exists) {
          // Save user data to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          final user = data['user'];
          await prefs.setString('email', user['email'] ?? '');
          await prefs.setString('dob', user['dateOfBirth'] ?? '');
          await prefs.setString('firstname', user['firstName'] ?? '');
          await prefs.setString('lastname', user['lastName'] ?? '');
          await prefs.setString('mobileNo', user['mobileNo'] ?? '');
          await prefs.setInt('id', user['id'] ?? 0);

          // Navigate to Home screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Welcome")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          // Navigate to RegistrationScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationScreen(Mobile: mobile),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Unable to check mobile number.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect to the server.")),
      );
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "MEMBER LOGIN / SIGN UP",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return "Please enter a valid 10-digit phone number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                _isLoading
                    ? CircularProgressIndicator() // Show loading indicator
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            checkMobileNumber(mobileController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Please enter a valid phone number.")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
