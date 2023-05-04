import 'package:get/get.dart';
import 'package:waiter_app/database/model/category_model.dart';
import 'package:waiter_app/database/services/category_services.dart';

class CategoryController extends GetxController {
  List<CategoryData> categoryData = <CategoryData>[];
  var isLoading = false.obs;

  @override
  void onInit() {
    category();
    super.onInit();
  }

  category() async {
    try {
      var category = await CategoryService.category();
      if (category != null) {
        categoryData = <CategoryData>[];
        categoryData.addAll(category);
        isLoading.value = true;
      }
      update();
    } finally {
      isLoading(false);
      update();
    }
  }
}
