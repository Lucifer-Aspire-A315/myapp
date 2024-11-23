// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/cards/clothingCard.dart';

// import '../models/cloth.dart'; // Import your model

// class ClothingListPage extends StatefulWidget {
//   @override
//   State<ClothingListPage> createState() => _ClothingListPageState();
// }

// class _ClothingListPageState extends State<ClothingListPage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Calculate the number of items per row dynamically
//     int crossAxisCount = screenWidth < 600
//         ? 2
//         : screenWidth < 1200
//             ? 3
//             : 4;

//     double childAspectRatio = screenWidth < 600 ? 0.7 : 0.8;

//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Clothing Store')),
//       ),
//       body: Column(
//         children: [
//           // Padding widget with Dropdown and Refine By button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color.fromARGB(255, 71, 66, 66), width: 1.0),
//                 color: const Color.fromARGB(0, 255, 255, 255),
//               ),
//               child: Row(
//                 children: [
//                   // Dropdown container
//                   Expanded(
//                     child: Container(
//                       height: 50,
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       decoration: const BoxDecoration(
//                         border: Border(
//                           right: BorderSide(color: Colors.grey, width: 1.0),
//                         ),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           value: "Best Selling",
//                           items: <String>[
//                             'Best Selling',
//                             'Price: Low to High',
//                             'Price: High to Low'
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             // Handle dropdown value change
//                           },
//                           isExpanded: true,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Refine By button
//                   Expanded(
//                     child: Container(
//                       height: 50,
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.filter_list, color: Colors.black),
//                           SizedBox(width: 8.0),
//                           Text(
//                             "Refine By",
//                             style: TextStyle(fontSize: 16.0, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // FutureBuilder for displaying items
//           Expanded(
//             child: FutureBuilder<List<ClothingItem>>(
//               future: fetchClothingItems(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No items found'));
//                 } else {
//                   final items = snapshot.data!;
//                   return GridView.builder(
//                     padding: EdgeInsets.all(16.0),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossAxisCount,
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 5,
//                       childAspectRatio: 0.55,
//                     ),
//                     itemCount: items.length,
//                     itemBuilder: (context, index) {
//                       return ClothingCard(item: items[index]);
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Future<List<ClothingItem>> fetchClothingItems() async {
//   final response = await http
//       .get(Uri.parse('http://192.168.1.10:5002/api/auth/clothing-item'));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body);
//     return data.map((json) => ClothingItem.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load clothing items');
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/cards/clothingCard.dart';
import '../models/cloth.dart';

class ClothingListPage extends StatefulWidget {
  @override
  State<ClothingListPage> createState() => _ClothingListPageState();
}

class _ClothingListPageState extends State<ClothingListPage> {
  String _selectedSort = "Best Selling"; // State to track selected sorting option
  List<ClothingItem> _items = []; // To hold fetched items
  bool _isLoading = true; // Loading indicator
  String? _error; // To track errors

  @override
  void initState() {
    super.initState();
    _fetchAndSetClothingItems(); // Fetch items only once during initialization
  }

  Future<void> _fetchAndSetClothingItems() async {
    try {
      final items = await fetchClothingItems();
      setState(() {
        _items = items;
        _isLoading = false; // Mark loading as complete
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _error = "Failed to fetch items. Please try again."; // Capture the error
      });
    }
  }

  void _sortItems(String sortOption) {
    setState(() {
      _selectedSort = sortOption;
      if (sortOption == 'Price: Low to High') {
        _items.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortOption == 'Price: High to Low') {
        _items.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the number of items per row dynamically
    int crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 1200
            ? 3
            : 4;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Clothing Store')),
      ),
      body: Column(
        children: [
          // Padding widget with Dropdown and Refine By button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 71, 66, 66), width: 1.0),
                color: const Color.fromARGB(0, 255, 255, 255),
              ),
              child: Row(
                children: [
                  // Dropdown container
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedSort,
                          items: <String>[
                            'Best Selling',
                            'Price: Low to High',
                            'Price: High to Low'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _sortItems(newValue); // Sort items when a new option is selected
                            }
                          },
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ),
                  // Refine By button
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.filter_list, color: Colors.black),
                          SizedBox(width: 8.0),
                          Text(
                            "Refine By",
                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Display items
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!)) // Show error message if fetching failed
                    : _items.isEmpty
                        ? Center(child: Text('No items found'))
                        : GridView.builder(
                            padding: EdgeInsets.all(16.0),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.55,
                            ),
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return ClothingCard(item: _items[index]);
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

Future<List<ClothingItem>> fetchClothingItems() async {
  final response = await http
      .get(Uri.parse('http://192.168.1.10:5002/api/auth/clothing-item'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => ClothingItem.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load clothing items');
  }
}
