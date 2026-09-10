import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outme_smart/views/home/widgets/home_bottom_nav.dart';

import '../../controllers/home_controller.dart';
import '../../core/constants/app_routes.dart';
import 'widgets/category_section.dart';
import 'widgets/home_banner.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/nearby_store_section.dart';
import 'widgets/section_header.dart';
import 'widgets/trending_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.fetchAllHomeData,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // ------------------------------------------------------
              // HEADER
              // ------------------------------------------------------
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),

              // ------------------------------------------------------
              // SEARCH
              // ------------------------------------------------------
              const SliverToBoxAdapter(
                child: HomeSearchBar(),
              ),

              // ------------------------------------------------------
              // BANNER
              // ------------------------------------------------------
              const SliverToBoxAdapter(
                child: HomeBanner(),
              ),

              // ------------------------------------------------------
              // TRENDING PRODUCTS
              // ------------------------------------------------------
              const SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Trending Nearby',
                ),
              ),

              SliverToBoxAdapter(
                child: TrendingSection(
                  controller: controller,
                ),
              ),

              // ------------------------------------------------------
              // CATEGORIES
              // ------------------------------------------------------
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Shop By Store Type',
                  showViewAll: true,
                  onViewAll: () {
                    Get.toNamed(AppRoutes.category);
                  },
                ),
              ),

              SliverToBoxAdapter(
                child: CategorySection(
                  controller: controller,
                ),
              ),

              // ------------------------------------------------------
              // NEARBY STORES
              // ------------------------------------------------------
              const SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Nearby Stores',
                  showViewAll: true,
                ),
              ),

              SliverToBoxAdapter(
                child: NearbyStoreSection(
                  controller: controller,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 25),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}