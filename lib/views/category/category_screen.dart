import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/section_state_view.dart';
import '../home/widgets/home_bottom_nav.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final HomeController controller = Get.find<HomeController>();

  final TextEditingController searchController =
  TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    // Load categories if they are not already loaded.
    if (controller.categories.isEmpty) {
      controller.fetchCategories();
    }
  }

  // ---------------------------------------------------------------------------
  // SEARCH
  // ---------------------------------------------------------------------------

  void _onSearchChanged(String value) {
    setState(() {});

    _debounce?.cancel();

    final query = value.trim();

    if (query.isEmpty) {
      controller.fetchCategories();
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () {
        controller.searchCategories(query);
      },
    );
  }

  void _clearSearch() {
    _debounce?.cancel();

    searchController.clear();

    setState(() {});

    controller.fetchCategories();
  }

  void _retry() {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      controller.fetchCategories();
    } else {
      controller.searchCategories(query);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildCategoryGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 1),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: Get.back,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Browse products from your favorite local stores.',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SEARCH BAR
  // ---------------------------------------------------------------------------

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE7E7E7),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            size: 21,
            color: AppColors.grey,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Search by category',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          if (searchController.text.isNotEmpty)
            GestureDetector(
              onTap: _clearSearch,
              child: const Icon(
                Icons.close_rounded,
                size: 19,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CATEGORY GRID
  // ---------------------------------------------------------------------------

  Widget _buildCategoryGrid() {
    return Expanded(
      child: Obx(
            () => SectionStateView(
          status: controller.categoriesStatus.value,
          errorMessage: controller.categoriesError.value,
          emptyMessage: 'No categories found.',
          onRetry: _retry,
          height: double.infinity,
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            physics: const BouncingScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              return _CategoryCard(
                name: category.name,
                imageUrl: category.imageUrl,
                requiresDrugLicense:
                category.requiresDrugLicense,
              );
            },
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// CATEGORY CARD
// =============================================================================

class _CategoryCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool requiresDrugLicense;

  const _CategoryCard({
    required this.name,
    required this.imageUrl,
    required this.requiresDrugLicense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE7E7E7),
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
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _placeholder();
                },
              )
                  : _placeholder(),
            ),
          ),

          const SizedBox(height: 9),

          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            requiresDrugLicense
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