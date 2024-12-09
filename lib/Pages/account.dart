import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/Pages/address.dart';
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
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  bool istap = false;

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
    });
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ADDRESS",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Action for "ADD A NEW ADDRESS"
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Address()));
                      showMaterialModalBottomSheet(
                        closeProgressThreshold: 0.6,
                        bounce: true,
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          controller: ModalScrollController.of(context),
                          child:  Container(
                            padding:
                                EdgeInsets.all(16), // Apply consistent padding
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20), // Rounded top corners
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Title
                                Center(
                                  child:Text(
                "Add a New Address",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
                                ),
              // SizedBox(height: 20),
              // buildTextField("First Name"),
              // SizedBox(height: 16),
              // buildTextField("Last Name"),
              // SizedBox(height: 16),
              // buildTextField("Company"),
              SizedBox(height: 16),
              buildTextField("Address1"),
              SizedBox(height: 16),
              buildTextField("Address2"),
              SizedBox(height: 16),
              Text(
                "COUNTRY",
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
                value: selectedCountry,
                hint: Text("Select Country"),
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value;
                    selectedState = null; // Reset state
                    selectedCity = null; // Reset city
                  });
                },
                items: countryStateData.keys
                    .map((country) => DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        ))
                    .toList(), // Explicitly cast to List<DropdownMenuItem<String>>
              ),

              SizedBox(height: 16),

              // State Dropdown
              Text(
                "STATE",
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
                value: selectedState,
                hint: Text("Select State"),
                onChanged: selectedCountry == null
                    ? null
                    : (value) {
                        setState(() {
                          selectedState = value;
                          selectedCity = null; // Reset city
                        });
                      },
                items: (selectedCountry == null
                        ? []
                        : countryStateData[selectedCountry] ?? [])
                    .map((state) => DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        ))
                    .toList(), // Explicitly cast to List<DropdownMenuItem<String>>
              ),
              SizedBox(height: 16),

              // City Dropdown
              Text(
                "CITY",
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
                value: selectedCity,
                hint: Text("Select City"),
                onChanged: selectedState == null
                    ? null
                    : (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                items: (selectedState == null
                        ? []
                        : stateCityData[selectedState] ?? [])
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(), // Explicitly cast to List<DropdownMenuItem<String>>
              ),
              SizedBox(height: 16),
              buildTextField("postal/zip code"),
              SizedBox(height: 16),
              buildTextField("mobile number"),

                                // Save Button
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle save address action
                                      print("Address Saved");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      backgroundColor: Colors.black,
                                    ),
                                    child: Text(
                                      "Save Address",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                     
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "ADD A NEW",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            "ADDRESS",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Space between buttons
                  GestureDetector(
                    onTap: () {
                      // Action for "EDIT ADDRESSES"
                      print("Edit Addresses button clicked");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "EDIT",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            "ADDRESSES",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText) {
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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
