import 'package:get/get.dart';
import '../core/constants/app_routes.dart';
import '../views/splash/splash_screen.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../views/auth/send_otp_screen.dart';
import '../views/auth/verify_otp_screen.dart';
import '../views/home/homescreen.dart';
import '../views/category/category_screen.dart';
import '../views/shop/shop_detail_screen.dart';
import '../views/product/product_detail_screen.dart';
import '../views/cart/cart_list_screen.dart';
import '../views/cart/cart_details_screen.dart';
import '../views/checkout/checkout_screen.dart';
import '../views/profile/profile_screen.dart';
import 'auth_binding.dart';
import 'home_binding.dart';
import 'cart_binding.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.sendOtp, page: () => SendOtpScreen(), binding: AuthBinding()),
    GetPage(name: AppRoutes.verifyOtp, page: () => const VerifyOtpScreen(), binding: AuthBinding()),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen(), binding: HomeBinding()),
    GetPage(name: AppRoutes.category, page: () => const CategoryScreen(), binding: HomeBinding()),
    GetPage(name: AppRoutes.shopDetail, page: () => const ShopDetailScreen()),
    GetPage(name: AppRoutes.productDetail, page: () => const ProductDetailScreen()),
    GetPage(name: AppRoutes.cart, page: () => const CartListScreen(), binding: CartBinding()),
    GetPage(name: AppRoutes.storeCart, page: () => const CartDetailScreen(), binding: CartBinding()),
    GetPage(name: AppRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen(), binding: AuthBinding()),
  ];
}