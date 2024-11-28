import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/gocolors1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  final String Mobile;
  const RegistrationScreen({
    Key? key,
    required this.Mobile,
  }) : super(key: key);
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? _selectedYear;
  String? _selectedMonth;
  String? _selectedDay;
  bool _isLoading = false;

  late TextEditingController _mobileController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController(text: widget.Mobile);
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final url = Uri.parse('http://192.168.1.10:5002/api/auth/registeration');

    final dateOfBirth = _selectedYear != null &&
            _selectedMonth != null &&
            _selectedDay != null
        ? '$_selectedYear-${_selectedMonth!.padLeft(2, '0')}-${_selectedDay!.padLeft(2, '0')}'
        : null;

    final body = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobileNo": _mobileController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text,
      "dateOfBirth": dateOfBirth,
      "gender": _selectedGender,
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(data);

        final email = data['user']['email'] ??
            ''; // Extracting email from the 'user' object
        final dob = data['user']['dateOfBirth'] ??
            ''; // Extracting dateOfBirth from the 'user' object
        final firstname = data['user']['firstName'] ??
            ''; // Extracting firstName from the 'user' object
        final lastname = data['user']['lastName'] ?? '';
        final Mobileno = data['user']['mobileNo'] ??
            ''; // Extracting lastName from the 'user' object
            final id = data['user']['id'] ?? '';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('dob', dob);
        await prefs.setString('firstname', firstname);
        await prefs.setString('lastname', lastname);
        await prefs.setString('Mobileno', Mobileno);
        await prefs.setInt('id', id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error['msg']}')),
        );
      }
    } catch (e) {
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Text(
                    "MEMBER REGISTRATION",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: "First Name*",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last Name*",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: _mobileController,
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
                SizedBox(height: 15.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                  "Date Of Birth",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        hint: Text("Year"),
                        items: List.generate(50, (index) {
                          int year = DateTime.now().year - index;
                          return DropdownMenuItem(
                            value: year.toString(),
                            child: Text(year.toString()),
                          );
                        }),
                        onChanged: (value) => setState(() {
                          _selectedYear = value;
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a year";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        hint: Text("Month"),
                        items: List.generate(12, (index) {
                          return DropdownMenuItem(
                            value: (index + 1).toString(),
                            child: Text((index + 1).toString()),
                          );
                        }),
                        onChanged: (value) => setState(() {
                          _selectedMonth = value;
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a month";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        hint: Text("Day"),
                        items: List.generate(31, (index) {
                          return DropdownMenuItem(
                            value: (index + 1).toString(),
                            child: Text((index + 1).toString()),
                          );
                        }),
                        onChanged: (value) => setState(() {
                          _selectedDay = value;
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a day";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: "Female",
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value.toString();
                              });
                            }),
                        Text("Female"),
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Row(
                      children: [
                        Radio(
                            value: "Male",
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value.toString();
                              });
                            }),
                        Text("Male"),
                      ],
                    ),
                  ],
                ),
                if (_selectedGender == null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Please select a gender",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedGender != null &&
                          _selectedYear != null &&
                          _selectedMonth != null &&
                          _selectedDay != null) {
                        registerUser(); // Call the API
                      } else if (_selectedGender == null) {
                        setState(() {}); // Show gender validation error
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
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
