import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/nearby_store_model.dart';

class StoreCard extends StatelessWidget {
  final NearbyStoreModel store;
  final VoidCallback? onViewStore;

  const StoreCard({
    super.key,
    required this.store,
    this.onViewStore,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final cardWidth = width < 360
        ? 245.0
        : width < 600
        ? 260.0
        : 285.0;

    final imageUrl = store.imageUrl != null &&
        store.imageUrl!.isNotEmpty
        ? store.imageUrl
        : store.logoUrl != null &&
        store.logoUrl!.isNotEmpty
        ? store.logoUrl
        : null;

    return Container(
      width: cardWidth,
      height: 265,
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
          _buildImage(imageUrl),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              9,
              12,
              10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      store.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '(${store.ratingCount})',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const Spacer(),
                    _buildStoreType(),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: store.isOpen
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      store.isOpen ? 'Open' : 'Closed',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: store.isOpen
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 9),

                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: onViewStore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'View Store',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: imageUrl != null
          ? Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _placeholder();
        },
      )
          : _placeholder(),
    );
  }

  Widget _buildStoreType() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FAF5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'Store',
        style: TextStyle(
          fontSize: 9,
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFFEFEFEF),
      child: const Center(
        child: Icon(
          Icons.storefront_rounded,
          size: 52,
          color: Colors.grey,
        ),
      ),
    );
  }
}