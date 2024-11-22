import 'package:flutter/material.dart';

class LeggingsChuridarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Leggings & Churidar"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        child: Container(
          decoration: BoxDecoration(
            
            border: Border.all(color: Colors.grey, width: 1.0),
            // borderRadius: BorderRadius.circular(8.0),
            color:const Color.fromARGB(0, 255, 255, 255)
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
                      value: "Best Selling",
                      items: <String>['Best Selling', 'Price: Low to High', 'Price: High to Low']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {},
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
                  child:const  Row(
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
    );
  }
}
