import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/trending_product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    // ------------------------------------------------------------
    // CHECK PRODUCT DATA
    // ------------------------------------------------------------
    if (args is! TrendingProductModel) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 50,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Product data not available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final TrendingProductModel product = args;

    // ------------------------------------------------------------
    // REAL API DATA
    // ------------------------------------------------------------
    final String name = product.name;
    final double price = product.pricing.price;
    final double mrp = product.pricing.mrp;
    final double discount = product.pricing.discountPercent;

    return Scaffold(
      backgroundColor: Colors.white,

      // ----------------------------------------------------------
      // MAIN CONTENT
      // ----------------------------------------------------------
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ------------------------------------------------------
            // BACK BUTTON
            // ------------------------------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),

            const SizedBox(height: 4),

            // ------------------------------------------------------
            // PRODUCT IMAGE
            // ------------------------------------------------------
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: double.infinity,
                height: 280,
                child: product.imageUrl != null &&
                    product.imageUrl!.isNotEmpty
                    ? Image.network(
                  product.imageUrl!,
                  fit: BoxFit.cover,

                  loadingBuilder:
                      (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      color: AppColors.lightGrey,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },

                  errorBuilder:
                      (context, error, stackTrace) {
                    return Container(
                      color: AppColors.lightGrey,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                )
                    : Container(
                  color: AppColors.lightGrey,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ------------------------------------------------------
            // PRODUCT NAME
            // ------------------------------------------------------
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // ------------------------------------------------------
            // STORE NAME
            // ------------------------------------------------------
            if (product.storeName != null &&
                product.storeName!.isNotEmpty)
              Text(
                product.storeName!,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),

            const SizedBox(height: 10),

            // ------------------------------------------------------
            // DELIVERY
            // ------------------------------------------------------
            const Text(
              'Available on fast delivery',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 14),

            // ------------------------------------------------------
            // PRICE + RATING
            // ------------------------------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '₹${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 10),

                if (mrp > price)
                  Text(
                    '₹${mrp.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                      decoration:
                      TextDecoration.lineThrough,
                    ),
                  ),

                const SizedBox(width: 10),

                if (discount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen
                          .withOpacity(0.1),
                      borderRadius:
                      BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${discount.toStringAsFixed(0)}% OFF',
                      style: const TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // ------------------------------------------------------
            // STOCK STATUS
            // ------------------------------------------------------
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    product.inStock
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: product.inStock
                        ? AppColors.primaryGreen
                        : Colors.red,
                    size: 18,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    product.inStock
                        ? 'In Stock'
                        : 'Out of Stock',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ------------------------------------------------------
            // DESCRIPTION
            // ------------------------------------------------------
            const Text(
              'Product Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'This product is available from ${product.storeName ?? 'the selected store'}.',
              style: TextStyle(
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // ------------------------------------------------------------
      // ADD TO CART
      // ------------------------------------------------------------
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            16,
          ),
          child: Row(
            children: [
              // DECREASE
              IconButton(
                onPressed: () {
                  setState(() {
                    if (qty > 1) {
                      qty--;
                    }
                  });
                },
                icon: const Icon(
                  Icons.remove_circle_outline,
                ),
              ),

              // QUANTITY
              Text(
                '$qty',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // INCREASE
              IconButton(
                onPressed: () {
                  setState(() {
                    qty++;
                  });
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: AppColors.primaryGreen,
                ),
              ),

              const SizedBox(width: 8),

              // ADD TO CART
              Expanded(
                child: ElevatedButton(
                  onPressed: product.inStock
                      ? () {
                    // Cart API can be connected here.
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    disabledBackgroundColor:
                    Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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