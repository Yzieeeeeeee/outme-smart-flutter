import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../core/constants/app_routes.dart';
import '../../widgets/product_card.dart';
import '../../widgets/section_state_view.dart';

class TrendingSection extends StatelessWidget {
  final HomeController controller;

  const TrendingSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 245,
      child: Obx(() {
        return SectionStateView(
          status: controller.trendingStatus.value,
          errorMessage: controller.trendingError.value,
          emptyMessage: 'No trending products found.',
          onRetry: controller.fetchTrendingProducts,
          height: 245,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            itemCount: controller.trendingProducts.length,
            itemBuilder: (context, index) {
              final product =
              controller.trendingProducts[index];

              return ProductCard(
                product: product,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.productDetail,
                    arguments: product,
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}