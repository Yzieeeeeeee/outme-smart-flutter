import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/trending_product_model.dart';

class ProductCard extends StatelessWidget {
  final TrendingProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final cardWidth = width < 360
        ? 148.0
        : width < 600
        ? 160.0
        : 175.0;

    final price = product.pricing.price;
    final mrp = product.pricing.mrp;
    final discount = product.pricing.discountPercent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 225,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.045),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                8,
                10,
                8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    'Per 1 KG (Pcs)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  if (product.storeName != null &&
                      product.storeName!.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      product.storeName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],

                  const SizedBox(height: 3),

                  Text(
                    '₹${price.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  if (mrp > price && discount > 0)
                    Row(
                      children: [
                        Text(
                          '₹${mrp.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                            decoration:
                            TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${discount.toStringAsFixed(0)}% OFF',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 4),

                  Text(
                    product.inStock
                        ? 'In stock'
                        : 'Out of stock',
                    style: TextStyle(
                      fontSize: 9,
                      color: product.inStock
                          ? AppColors.primaryGreen
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 105,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: product.imageUrl != null &&
                product.imageUrl!.isNotEmpty
                ? Image.network(
              product.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return _placeholder();
              },
            )
                : _placeholder(),
          ),

          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                shape: BoxShape.circle,
              ),
              child: Icon(
                product.isFavorited
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                size: 17,
                color: Colors.black,
              ),
            ),
          ),

          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 42,
          color: Colors.grey,
        ),
      ),
    );
  }
}