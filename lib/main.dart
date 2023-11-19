import 'package:db_miner/controller/favourite_controller.dart';
import 'package:db_miner/controller/jsonquote_controller.dart';
import 'package:db_miner/controller/theme_controller.dart';
import 'package:db_miner/utils/my_routes.dart';
import 'package:db_miner/views/screens/favourite_page.dart';
import 'package:db_miner/views/screens/home_page.dart';
import 'package:db_miner/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/Jeson_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await JsonHelper.jesonhelper.getData();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await JsonHelper.jesonhelper.init();
  ThemeController themeController =
      Get.put(ThemeController(preferences: preferences));
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    JsonQuotesController jsonquoyeController = Get.put(JsonQuotesController());
    FavouriteController favouriteController = Get.put(FavouriteController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashScreen(),
      getPages: [
        GetPage(
          name: MyRoutes.home_page,
          page: () => HomePage(),
        ),
        GetPage(
          name: MyRoutes.favourite_page,
          page: () => FavouritePage(),
        ),
        GetPage(
          name: MyRoutes.splash_screen,
          page: () => SplashScreen(),
        )
      ],
    );
  }
}
