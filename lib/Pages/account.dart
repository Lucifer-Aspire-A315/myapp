import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  String email = '';
  String mobileNumber = '';
  String name = '';
  String dob = '';
  String mob = '';
  int id = 0;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  bool istap = false;
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  // Sample data for countries, states, and cities
  final Map<String, List<String>> countryStateData = {
    'India': ['Maharashtra', 'Gujarat', 'Rajasthan'],
    'USA': ['California', 'New York', 'Texas'],
    'Canada': ['Ontario', 'Quebec', 'Alberta'],
    'Australia': ['Victoria', 'Queensland', 'Tasmania'],
    'Germany': ['Bavaria', 'Berlin', 'Hamburg'],
    'France': ['Ile-de-France', 'Provence', 'Normandy'],
    'Italy': ['Lombardy', 'Veneto', 'Sicily'],
    'UK': ['England', 'Scotland', 'Wales'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto'],
    'China': ['Beijing', 'Shanghai', 'Shenzhen'],
  };

  final Map<String, List<String>> stateCityData = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Gujarat': ['Mumbai', 'Pune', 'Nagpur'],
    'California': ['Los Angeles', 'San Francisco', 'San Diego'],
    'Ontario': ['Toronto', 'Ottawa', 'Mississauga'],
    'Victoria': ['Melbourne', 'Geelong', 'Ballarat'],
    'Bavaria': ['Munich', 'Nuremberg', 'Augsburg'],
    // Add more states and cities here
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'Not Available';
      mobileNumber = prefs.getString('Mobileno') ?? 'Not Available';
      name = prefs.getString('firstname') ?? 'Not Available';
      dob = prefs.getString('dob') ?? 'Not Available';
      mob = prefs.getString('mobileNo') ?? 'Not Available';
      id = prefs.getInt('id') ?? 0;
    });
  }

  Future<void> saveAddress() async {
    final combinedAddress =
        "${address1Controller.text}, ${address2Controller.text}";
    final country = selectedCountry;
    final state = selectedState;
    final city = selectedCity;
    final postalCode = postalCodeController.text;
    final mobileNumber = mobileNumberController.text;

    if (combinedAddress.isEmpty ||
        country == null ||
        state == null ||
        city == null ||
        postalCode.isEmpty ||
        mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    final body = {
      'userId': id, // Replace with dynamic userId
      'address': combinedAddress,
      'country': country,
      'state': state,
      'city': city,
      'postalCode': postalCode,
      'mobileNumber': mobileNumber,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.1.35:5002/api/auth/saveaddress'), // Replace with your API URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Address saved successfully')),
        );
        Navigator.pop(context); // Close the bottom sheet
      } else {
        final error = json.decode(response.body)['message'] ?? 'Error occurred';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save address')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: My Account
            Center(
              child: Column(
                children: [
                  Text(
                    'MY ACCOUNT',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // MY PROFILE Button
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('MY PROFILE'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.black),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                  // PURCHASE AND ORDERS Button
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('PURCHASE AND ORDERS'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.black),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                  // LOGOUT Button (Disabled)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text('LOGOUT'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Divider(),

            // Section: Contact Detail
            Text(
              'CONTACT DETAIL',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('EMAIL', style: TextStyle(fontSize: 14)),
                Text(email, style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('MOBILE NUMBER', style: TextStyle(fontSize: 14)),
                Text(mob, style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: 30),
            Divider(),

            // Section: Personal Data
            Text(
              'PERSONAL DATA',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NAME', style: TextStyle(fontSize: 14)),
                Text(name, style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('DATE OF BIRTH', style: TextStyle(fontSize: 14)),
                Text(dob, style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "ADDRESS",
            //       style: TextStyle(fontSize: 20),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Center(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           // Action for "ADD A NEW ADDRESS"
            //           Navigator.push(context,
            //               MaterialPageRoute(builder: (context) => Address()));
            //         },
            //         child: Container(
            //           padding:
            //               EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            //           decoration: BoxDecoration(
            //             shape: BoxShape.rectangle,
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(color: Colors.black, width: 1),
            //           ),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(
            //                 "ADD A NEW",
            //                 style: TextStyle(fontSize: 16, color: Colors.black),
            //               ),
            //               Text(
            //                 "ADDRESS",
            //                 style: TextStyle(fontSize: 16, color: Colors.black),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 20), // Space between buttons
            //       GestureDetector(
            //         onTap: () {
            //           // Action for "EDIT ADDRESSES"
            //           print("Edit Addresses button clicked");
            //         },
            //         child: Container(
            //           padding:
            //               EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            //           decoration: BoxDecoration(
            //             shape: BoxShape.rectangle,
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(color: Colors.black, width: 1),
            //           ),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(
            //                 "EDIT",
            //                 style: TextStyle(fontSize: 16, color: Colors.black),
            //               ),
            //               Text(
            //                 "ADDRESSES",
            //                 style: TextStyle(fontSize: 16, color: Colors.black),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
