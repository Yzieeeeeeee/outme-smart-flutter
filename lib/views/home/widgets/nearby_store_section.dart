import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../widgets/section_state_view.dart';
import '../../widgets/store_card.dart';

class NearbyStoreSection extends StatelessWidget {
  final HomeController controller;

  const NearbyStoreSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285,
      child: Obx(() {
        return SectionStateView(
          status: controller.nearbyStoresStatus.value,
          errorMessage: controller.nearbyStoresError.value,
          emptyMessage: 'No nearby stores found.',
          onRetry: controller.fetchNearbyStores,
          height: 285,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 8,
            ),
            itemCount: controller.nearbyStores.length,
            itemBuilder: (context, index) {
              final store = controller.nearbyStores[index];

              return StoreCard(
                store: store,
              );
            },
          ),
        );
      }),
    );
  }
}