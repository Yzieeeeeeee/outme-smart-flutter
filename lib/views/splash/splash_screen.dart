import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:outme_smart/core/constants/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super .initState();
    navigateAfterDelay();
  }

  Future<void> navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offNamed(AppRoutes.onboarding);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/splash.png",width: 130,),
      ),
    );
  }
}
