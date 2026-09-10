import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class ShopDetailScreen extends StatelessWidget {
  const ShopDetailScreen({super.key});

  // Mock data — no store-detail/product-catalog API in the provided collection.
  final List<Map<String, String>> mockProducts = const [
    {'name': 'Carrot Vegetable', 'price': '₹45.50'},
    {'name': 'Carrot Vegetable', 'price': '₹45.50'},
    {'name': 'Carrot Vegetable', 'price': '₹45.50'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
                const Text('GEORGE STORE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 140,
              decoration: BoxDecoration(color: AppColors.primaryGreen, borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text('Because Families Deserve Better!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Special Offers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mockProducts.length,
                itemBuilder: (context, index) {
                  final product = mockProducts[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.productDetail, arguments: product),
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 70, color: AppColors.lightGrey),
                          const SizedBox(height: 6),
                          Text(product['name']!, style: const TextStyle(fontSize: 12)),
                          Text(product['price']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}