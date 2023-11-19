import 'package:db_miner/helper/Jeson_helper.dart';
import 'package:get/get.dart';

import '../modal/quotes_modal.dart';

class FavouriteController extends GetxController {
  RxList<Quotes> allFavouriteQuotes = <Quotes>[].obs;

  FavouriteController() {
    init();
  }

  init() async {
    allFavouriteQuotes(await (JsonHelper.jesonhelper.getAllFavQuotes()));
  }

  insertQuotes({required Quotes quotes}) async {
    int res = await (JsonHelper.jesonhelper.insertFavQuotes(quotes: quotes));
    init();
  }

  deleteQuotes({required int id}) async {
    int res = await (JsonHelper.jesonhelper.deleteFavQuotes(id: id));
    init();
  }
}
