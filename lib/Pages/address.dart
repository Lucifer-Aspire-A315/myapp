import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('YOUR ADDRESS'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20), // Equal padding from all sides
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buttons
              GestureDetector(
                onTap: () {
                  print("Add A New Address clicked");
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
              SizedBox(height: 20), // Spacing between buttons
              GestureDetector(
                onTap: () {
                  print("Return To Orders clicked");
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
                      "Return To Orders",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // Space between buttons and form

              // Form
              Text(
                "Add a New Address",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              buildTextField("First Name"),
              SizedBox(height: 16),
              buildTextField("Last Name"),
              SizedBox(height: 16),
              buildTextField("Company"),
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
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each TextField
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
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
