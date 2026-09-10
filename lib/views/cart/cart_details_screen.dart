import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class CartDetailScreen extends StatelessWidget {
  const CartDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    final String storeId = Get.arguments ?? '';
    controller.fetchStoreCart(storeId);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.cartDetailStatus.value == LoadStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.cartDetailStatus.value == LoadStatus.error) {
                    return const Center(child: Text('Could not load cart.'));
                  }
                  if (controller.cartDetailStatus.value == LoadStatus.empty) {
                    return const Center(child: Text('No items in this cart.'));
                  }
                  return ListView(
                    children: [
                      ...controller.cartItems.map((item) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Container(width: 50, height: 50, color: AppColors.lightGrey),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('₹${item.price}'),
                                ],
                              ),
                            ),
                            Text('Qty: ${item.qty}'),
                          ],
                        ),
                      )),
                      if (controller.summary.value != null) _buildSummary(controller),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(CartController controller) {
    final s = controller.summary.value!;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _row('Item Total', s.itemTotal),
          _row('Delivery Fee', s.deliveryFee),
          _row('Platform Fee', s.platformFee),
          _row('Discount', -s.discount),
          const Divider(),
          _row('Total Payable', s.totalPayable, bold: true),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.checkout),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Checkout', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text('₹${value.toStringAsFixed(0)}', style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}