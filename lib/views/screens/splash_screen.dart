import 'dart:async';

import 'package:db_miner/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 3), (timer) {
      Get.offNamed(MyRoutes.home_page);
      timer.cancel();
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/SP.gif'),
      ),
    );
  }
}
