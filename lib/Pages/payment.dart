import 'package:flutter/material.dart';
import 'package:myapp/Pages/gocolors1.dart';
import 'package:myapp/Pages/progressindicator.dart';
import 'package:myapp/models/status.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final pageStatus = Provider.of<PageStatusProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Decrement step and navigate back
            Provider.of<PageStatusProvider>(context, listen: false)
                .updateStep(2); // Decrement step by 1
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          StepProgressIndicator(currentStep: pageStatus.currentStep),
          Container(
            child: Center(
              child: Text("This is Payment Page"),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Provider.of<PageStatusProvider>(context, listen: false)
              .updateStep(1); // Navigate to Address step
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => Home(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                final tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        },
        child: const Text('Continue Payment'),
      ),
    );
  }
}
