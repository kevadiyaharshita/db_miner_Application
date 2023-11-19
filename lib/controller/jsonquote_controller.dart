import 'package:db_miner/helper/Jeson_helper.dart';
import 'package:db_miner/modal/quotes_modal.dart';
import 'package:get/get.dart';

class JsonQuotesController extends GetxController {
  RxList<Quotes> allQuotes = <Quotes>[].obs;
  RxList<Quotes> allSelectedCategoruQuotes = <Quotes>[].obs;
  RxList<String> allCategories = <String>[].obs;
  RxString selectedCategory = "All".obs;

  JsonQuotesController() {
    getAllQuotes();
  }

  changeSelectedCategory({required int index}) {
    selectedCategory(allCategories[index]);
    List<Quotes> tmpList = [];
    if (selectedCategory != 'All') {
      for (int i = 0; i < allQuotes.length; i++) {
        if (allQuotes[i].category == selectedCategory.toLowerCase()) {
          tmpList.add(allQuotes[i]);
        }
      }
      allSelectedCategoruQuotes(tmpList);
    } else {
      allSelectedCategoruQuotes(allQuotes);
    }
  }

  Future<List<Quotes>> getAllQuotes() async {
    List data = await JsonHelper.jesonhelper.getData();
    allQuotes(data.map((e) => Quotes.fromMap(data: e)).toList());
    allSelectedCategoruQuotes(allQuotes);
    print("AllLenght : ${allQuotes.length}");
    allCategories(allQuotes
        .map((element) => element.category.capitalizeFirst!)
        .toList()
        .toSet()
        .toList());
    allCategories.insert(0, "All");
    print("allCategories : $allCategories");
    return allQuotes;
  }
}
