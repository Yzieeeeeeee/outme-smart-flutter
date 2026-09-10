import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/store_category_model.dart';

class CategoryCard extends StatelessWidget {
  final StoreCategoryModel category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: _CategoryImage(
                imageUrl: category.imageUrl,
              ),
            ),
          ),

          const SizedBox(height: 9),

          Text(
            category.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            category.requiresDrugLicense
                ? 'License required'
                : 'Shop products',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  final String imageUrl;

  const _CategoryImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _placeholder();
    }

    return Image.network(
      imageUrl,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (
          context,
          child,
          loadingProgress,
          ) {
        if (loadingProgress == null) {
          return child;
        }

        return Container(
          color: const Color(0xFFF2F2F2),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (
          context,
          error,
          stackTrace,
          ) {
        return _placeholder();
      },
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: const Center(
        child: Icon(
          Icons.storefront_outlined,
          size: 40,
          color: AppColors.grey,
        ),
      ),
    );
  }
}