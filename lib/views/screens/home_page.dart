import 'package:db_miner/controller/favourite_controller.dart';
import 'package:db_miner/controller/jsonquote_controller.dart';
import 'package:db_miner/controller/theme_controller.dart';
import 'package:db_miner/helper/Jeson_helper.dart';
import 'package:db_miner/modal/quotes_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/my_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    JsonQuotesController quotesController = Get.find<JsonQuotesController>();
    FavouriteController favouriteController = Get.find<FavouriteController>();
    ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () {
                themeController.changeTheme();
                themeController.getTheme
                    ? Get.changeTheme(ThemeData.dark(useMaterial3: true))
                    : Get.changeTheme(ThemeData.light(useMaterial3: true));
              },
              icon: themeController.getTheme
                  ? Icon(Icons.light_mode_outlined)
                  : Icon(Icons.light_mode_rounded),
            );
          }),
          IconButton(
              onPressed: () {
                Get.toNamed(MyRoutes.favourite_page);
              },
              icon: Icon(Icons.favorite_border))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    quotesController.allCategories.length,
                    (index) => GestureDetector(
                      onTap: () {
                        quotesController.changeSelectedCategory(index: index);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.fromLTRB(0, 5, 10, 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.primaries[index % 18]),
                          color: quotesController.selectedCategory ==
                                  quotesController.allCategories[index]
                              ? Colors.primaries[index % 18]
                              : null,
                        ),
                        child: Text(
                          quotesController.allCategories[index],
                          style: TextStyle(
                            color: quotesController.selectedCategory ==
                                    quotesController.allCategories[index]
                                ? Colors.white
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            Obx(() {
              return Expanded(
                child: GridView.builder(
                  itemCount: quotesController.allSelectedCategoruQuotes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 4),
                  itemBuilder: (context, index) {
                    Quotes q =
                        quotesController.allSelectedCategoruQuotes[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.primaries[index % 18],
                              title: Center(
                                  child: Text(
                                "Quotes",
                                style: TextStyle(color: Colors.white),
                              )),
                              content: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '"${q.quote}"',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Gap(10),
                                  Text(
                                    'Auther - ${q.author}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Gap(5),
                                  Text(
                                    q.category.capitalizeFirst!,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    favouriteController.insertQuotes(quotes: q);
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.favorite_border,
                                      color: Colors.primaries[index % 18]),
                                  label: Text(
                                    "Favourite",
                                    style: TextStyle(
                                        color: Colors.primaries[index % 18]),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.primaries[index % 18]),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.primaries[index % 18],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              q.quote,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Spacer(),
                            Divider(
                              color: Colors.white,
                            ),
                            Text(
                              '- ${q.author}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              '- ${q.category.capitalizeFirst!}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
