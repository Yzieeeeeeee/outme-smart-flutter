import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Delivery address and payment options go here.'),
        // No order-placement API in the provided collection — Place Order below is a local success state only.
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Get.defaultDialog(
              title: 'Order Placed!',
              middleText: 'Your order has been placed successfully.',
              onConfirm: () => Get.offAllNamed(AppRoutes.home),
              textConfirm: 'OK',
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
          child: const Text('Place Order', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}