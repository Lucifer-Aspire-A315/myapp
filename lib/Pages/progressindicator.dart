import 'package:flutter/material.dart';

class StepProgressIndicator extends StatefulWidget {
  final int currentStep;

  const StepProgressIndicator({required this.currentStep});

  @override
  _StepProgressIndicatorState createState() => _StepProgressIndicatorState();
}

class _StepProgressIndicatorState extends State<StepProgressIndicator> {
  late List<bool> isLineAnimated;

  @override
  void initState() {
    super.initState();
    // Initialize animation state for each line
    isLineAnimated = List.generate(2, (index) => false); // 2 lines for 3 steps
  }

  @override
  void didUpdateWidget(covariant StepProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentStep > oldWidget.currentStep) {
      if (widget.currentStep - 2 >= 0 &&
          widget.currentStep - 2 < isLineAnimated.length) {
        setState(() {
          isLineAnimated[widget.currentStep - 2] = true;
          print("Animating line for step: ${widget.currentStep - 2}");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildStep(
            title: 'Cart',
            isActive: widget.currentStep >= 1,
            isCompleted: widget.currentStep > 1,
          ),
          buildLine(isActive: widget.currentStep >= 2, lineIndex: 0),
          buildStep(
            title: 'Address',
            isActive: widget.currentStep >= 2,
            isCompleted: widget.currentStep > 2,
          ),
          buildLine(isActive: widget.currentStep >= 3, lineIndex: 1),
          buildStep(
            title: 'Payment',
            isActive: widget.currentStep == 3,
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  Widget buildStep({
    required String title,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        CircleAvatar(
          radius: 10,
          backgroundColor: isCompleted
              ? Colors.green
              : (isActive
                  ? const Color.fromARGB(255, 241, 54, 7)
                  : Colors.grey),
          child: isCompleted
              ? Icon(Icons.check, size: 16, color: Colors.white)
              : CircleAvatar(
                  radius: 5,
                  backgroundColor: isActive ? Colors.white : Colors.grey,
                ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.teal : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildLine({required bool isActive, required int lineIndex}) {
    return Expanded(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: isLineAnimated[lineIndex]
              ? 1
              : 0, // Animate only for the correct line
        ),
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Container(
            height: 2,
            color: Colors.grey[300],
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value,
              child: Container(
                height: 2,
                color: const Color.fromARGB(255, 3, 253, 228),
              ),
            ),
          );
        },
      ),
    );
  }
}
