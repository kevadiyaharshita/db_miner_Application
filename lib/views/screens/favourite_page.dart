import 'package:db_miner/modal/quotes_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/favourite_controller.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    FavouriteController favouriteController = Get.find<FavouriteController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Quotes"),
      ),
      body: Center(
        child: favouriteController.allFavouriteQuotes.isNotEmpty
            ? Obx(() {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 3 / 4),
                  itemCount: favouriteController.allFavouriteQuotes.length,
                  itemBuilder: (context, index) {
                    Quotes q = favouriteController.allFavouriteQuotes[index];
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
                                    favouriteController.deleteQuotes(id: q.id);
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.delete,
                                      color: Colors.primaries[index % 18]),
                                  label: Text(
                                    "Delete",
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
                );
              })
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 110,
                    ),
                  ),
                  Gap(20),
                  Text(
                    "No Favourites Yet!!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Gap(5),
                  Text(
                    "Like a quotes you see?save",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    "them here to your favourites.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ],
              ),
      ),
    );
  }
}
