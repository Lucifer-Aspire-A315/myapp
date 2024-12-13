import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/payment.dart';
import 'package:myapp/Pages/progressindicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/status.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  bool istap = false;
  String email = '';
  String mobileNumber = '';
  String name = '';
  String dob = '';
  String mob = '';
  int id = 0;
  bool? isaddress = false;
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  // Sample data for default addresses
  final List<Map<String, String>> defaultAddresses = [];

  // Sample data for countries, states, and cities
  final Map<String, List<String>> countryStateData = {
    'India': ['Maharashtra', 'Gujarat', 'Rajasthan'],
  };

  final Map<String, List<String>> stateCityData = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
  };
  @override
  void initState() {
    super.initState();

    // _loadUserData();
    getaddress();
  }

  @override
  void dispose() {
    address1Controller.dispose();
    address2Controller.dispose();
    postalCodeController.dispose();
    mobileNumberController.dispose();
    super.dispose();
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

  bool isLoading = false;

  Future<void> deleteAddress(String addressId) async {
    setState(() => isLoading = true);
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.35:5002/api/auth/deleteaddress/$addressId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            defaultAddresses
                .removeWhere((address) => address['id'] == addressId);
            isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() => isLoading = false);
          final error =
              json.decode(response.body)['message'] ?? 'Error occurred';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete the address')),
        );
      }
    }
  }

  Future<void> getaddress() async {
    await _loadUserData();
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.35:5002/api/auth/getaddresses/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            defaultAddresses.clear();
            final List addresses = data['addresses'];
            for (var address in addresses) {
              defaultAddresses.add({
                'name': 'User',
                'address': address['address'],
                'mobile': address['mobileNumber'].toString(),
                'postalCode': address['postalCode'].toString(),
                'country': address['country'].toString(),
                'state': address['state'].toString(),
                'city': address['city'].toString(),
                'id': address['id'].toString(),
              });
            }
          });
          print(defaultAddresses);
        }
      } else {
        if (mounted) {
          final error =
              json.decode(response.body)['message'] ?? 'Error occurred';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to retrieve address')),
        );
      }
    }
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
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Address saved successfully')),
          );
          setState(() {
            istap = false;
            address1Controller.clear();
            address2Controller.clear();
            postalCodeController.clear();
            mobileNumberController.clear();
            selectedCountry = null;
            selectedState = null;
            selectedCity = null;
            isaddress = true;
            getaddress();
          }); // Close the bottom sheet
        }
      } else {
        if (mounted) {
          final error =
              json.decode(response.body)['message'] ?? 'Error occurred';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save address')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageStatus = Provider.of<PageStatusProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('YOUR ADDRESS'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Decrement step and navigate back
            Provider.of<PageStatusProvider>(context, listen: false)
                .updateStep(1); // Decrement step by 1
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          StepProgressIndicator(currentStep: pageStatus.currentStep),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display default addresses
                    if (!istap && defaultAddresses.isNotEmpty) ...[
                      Text(
                        "DEFAULT ADDRESS",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      for (var address in defaultAddresses)
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      address['name']!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Chip(
                                      label: Text('HOME'),
                                      backgroundColor: Colors.green.shade100,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${address['address']!},${address['state']!},${address['city']!},${address['country']!}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Mobile: ${address['mobile']}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        print("Edit Address");
                                      },
                                      child: Text('EDIT'),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          defaultAddresses.remove(address);
                                          print(address['id']);
                                          deleteAddress(address['id']!);
                                        });
                                      },
                                      child: Text('REMOVE'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                    ],

                    // Add Address Button
                    GestureDetector(
                      onTap: () {
                        print("Add A New Address clicked");
                        setState(() {
                          istap = true;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Add A New Address",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Form for adding a new address
                    if (istap) ...[
                      SizedBox(height: 30),
                      Text(
                        "Add a New Address",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      buildTextField("Address1", address1Controller),
                      SizedBox(height: 16),
                      buildTextField("Address2", address2Controller),
                      SizedBox(height: 16),
                      buildDropdown(
                        label: "COUNTRY",
                        value: selectedCountry,
                        items: countryStateData.keys.toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                            selectedState = null;
                            selectedCity = null;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      buildDropdown(
                        label: "STATE",
                        value: selectedState,
                        items: selectedCountry == null
                            ? []
                            : countryStateData[selectedCountry] ?? [],
                        onChanged: (value) {
                          setState(() {
                            selectedState = value;
                            selectedCity = null;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      buildDropdown(
                        label: "CITY",
                        value: selectedCity,
                        items: selectedState == null
                            ? []
                            : stateCityData[selectedState] ?? [],
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      buildTextField("Postal/Zip Code", postalCodeController),
                      SizedBox(height: 16),
                      buildTextField("Mobile Number", mobileNumberController),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            saveAddress();
                          },
                          child: Text('CONFIRM'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (isaddress == true || defaultAddresses.length > 0) {
            Provider.of<PageStatusProvider>(context, listen: false)
                .updateStep(3); // Navigate to Address step
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Payment(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
              ),
            );
          }
          ;
        },
        child: const Text('Continue Payment'),
      ),
    );
  }

  // Function to build each TextField
  Widget buildTextField(
    String labelText,
    TextEditingController controller,
  ) {
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

  // Function to build dropdowns
  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          value: value,
          hint: Text("Select $label"),
          onChanged: onChanged,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
