import 'package:get/get.dart';
import 'package:waiter_app/database/model/table_model.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';
import 'package:waiter_app/database/services/table_service.dart';

class TableController extends GetxController {
  List<TableData> tableData = <TableData>[];
  var tableIndex = 0;
  var tableID = 0;
  var isLoading = false.obs;
  @override
  void onInit() {
    bookTable();
    super.onInit();
  }

  bookTable() async {
    var tableIDIndex = await UserSecureStorage.getTableID();
    if (tableIDIndex != null) {
      tableID = int.parse(tableIDIndex);
    } else {
      tableIDIndex = '0';
    }

    update();
    try {
      var table = await TableService.table();
      if (table != null) {
        tableData = <TableData>[];
        tableData.add(TableData(
            id: 0,
            name: 'Select Table',
            capacity: '',
            status: 0,
            restaurantId: 0));
        tableData.addAll(table.data!);
        isLoading.value = true;
        tableIndex = 0;
        tableIndex =
            tableData.indexWhere((i) => i.id == int.parse(tableIDIndex!));
        tableID = int.parse(tableIDIndex);
      }
      update();
    } finally {
      isLoading(false);
      update();
    }
  }
}
