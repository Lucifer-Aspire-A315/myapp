import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;

  const StepProgressIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildStep(
            title: 'Cart',
            isActive: currentStep >= 1,
            isCompleted: currentStep > 1,
          ),
          buildLine(isActive: currentStep >= 2),
          buildStep(
            title: 'Address',
            isActive: currentStep >= 2,
            isCompleted: currentStep > 2,
          ),
          buildLine(isActive: currentStep == 3),
          buildStep(
            title: 'Payment',
            isActive: currentStep == 3,
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
        CircleAvatar(
          radius: 10,
          backgroundColor: isCompleted
              ? Colors.green
              : (isActive ? Colors.teal : Colors.grey),
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

  Widget buildLine({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.teal : Colors.grey[300],
      ),
    );
  }
}
