import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../home/widgets/home_bottom_nav.dart';

class CartListScreen extends StatelessWidget {
  const CartListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();


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
                  if (controller.myCartsStatus.value == LoadStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.myCartsStatus.value == LoadStatus.error) {
                    return const Center(child: Text('Could not load your cart.'));
                  }
                  if (controller.myCartsStatus.value == LoadStatus.empty) {
                    return const Center(child: Text('Your cart is empty.'));
                  }
                  return ListView.builder(
                    itemCount: controller.myCarts.length,
                    itemBuilder: (context, index) {
                      final storeCart = controller.myCarts[index];
                      final storeId = storeCart['storeId']?.toString() ?? '';
                      final storeName = storeCart['storeName']?.toString() ?? 'Store';
                      final itemCount = storeCart['itemCount']?.toString() ?? '0';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(storeName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('$itemCount Items', style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => Get.toNamed(AppRoutes.storeCart, arguments: storeId),
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
                                child: const Text('View Cart', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 2),
    );
  }
}