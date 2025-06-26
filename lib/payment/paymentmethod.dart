import 'package:flutter/material.dart';
import 'package:juices/payment/payment_details.dart';

class PaymentMethodScreen extends StatelessWidget {
  final List<Map<String, String>> paymentMethods = [
    {
      'name': 'Credit Card / Visa',
      'image': 'assets/logo/credit_card.png',
      'method': 'Credit Card',
    },
    {
      'name': 'Vodafone Cash',
      'image': 'assets/logo/vodafone_cash.png',
      'method': 'Vodafone Cash',
    },
    {
      'name': 'Instapay',
      'image': 'assets/logo/instapay.png',
      'method': 'Instapay',
    },
    {
      'name': 'Cash on Delivery',
      'image': 'assets/logo/cash.png',
      'method': 'Cash',
    },
  ];

  @override
  Widget build(BuildContext context) {
    void navigateToDetails(String method) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentDetailsScreen(paymentMethod: method),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Payment Method" ,style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E3932),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final payment = paymentMethods[index];
          return GestureDetector(
            onTap: () => navigateToDetails(payment['method']!),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: Image.asset(
                  payment['image']!,
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  payment['name']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
