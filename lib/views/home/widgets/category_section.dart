import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../widgets/section_state_view.dart';
import '../../widgets/store_category_card.dart';

class CategorySection extends StatelessWidget {
  final HomeController controller;

  const CategorySection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SectionStateView(
        status: controller.categoriesStatus.value,
        errorMessage: controller.categoriesError.value,
        emptyMessage: 'No store categories found.',
        onRetry: controller.fetchCategories,
        height: 155,
        child: SizedBox(
          height: 155,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 20,
              right: 8,
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              return StoreCategoryCard(
                category: category,
              );
            },
          ),
        ),
      );
    });
  }
}