import 'package:flutter/material.dart';

class ShopByColors extends StatelessWidget {
  final List<ColorItem> colorItems1 = [
    ColorItem(name: "Reds", color: Color(0xFF8B0000)),
    ColorItem(name: "Rusts", color: Color(0xFFD2691E)),
    ColorItem(name: "Oranges", color: Color(0xFFFFA500)),
    ColorItem(name: "Mustards", color: Color(0xFFDAA520)),
    ColorItem(name: "Yellows", color: Color(0xFFFFFF00)),
    ColorItem(name: "Purples", color: Color(0xFF6A0DAD)),
    ColorItem(name: "Maroons", color: Color(0xFF800000)),
    ColorItem(name: "Corals", color: Color(0xFFFF6F61)),
    ColorItem(name: "Dark Pinks", color: Color(0xFFC71585)),
  ];

  final List<ColorItem> colorItems2 = [
    ColorItem(name: "Maroons", color: Color(0xFF800000)),
    ColorItem(name: "Corals", color: Color(0xFFFF6F61)),
    ColorItem(name: "Dark Pinks", color: Color(0xFFC71585)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Shop by Color'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColorSection(title: 'SOLID', colorItems: colorItems1),
            ColorSection(title: 'METALLIC / SHIMMER', colorItems: colorItems1),
            ColorSection(title: 'DENIM', colorItems: colorItems2),
          ],
        ),
      ),
    );
  }
}

class ColorSection extends StatefulWidget {
  final String title;
  final List<ColorItem> colorItems;

  ColorSection({required this.title, required this.colorItems});

  @override
  _ColorSectionState createState() => _ColorSectionState();
}

class _ColorSectionState extends State<ColorSection> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    int itemCount = showAll
        ? widget.colorItems.length
        : (widget.colorItems.length < 6 ? widget.colorItems.length : 6);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Divider(color: Colors.grey[300]),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: widget.colorItems[index].color,
                ),
                SizedBox(height: 8),
                Text(
                  widget.colorItems[index].name,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAll = !showAll;
              });
            },
            child: Text(
              showAll ? 'View Less' : 'View More',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class ColorItem {
  final String name;
  final Color color;

  ColorItem({required this.name, required this.color});
}
