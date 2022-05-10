import 'package:artivatic_flutterassignment/Models/ResponseModel.dart';
import 'package:artivatic_flutterassignment/Repository/APIRepository.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  var datalist = <Rows>[].obs;
  var responseModel = ResponseModel().obs;
  var filteredDatalist = <Rows>[].obs;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    callAPI();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void filterlist(String title) {
    List<Rows> results = [];
    if (title.isEmpty) {
      results = datalist;
    } else {
      results = datalist
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(title.toLowerCase()))
          .toList();
    }
    filteredDatalist.value = results;
  }

  void callAPI() async {
    await APIRepository().CalAPI().then((value) {
      datalist.value = value.rows!;
      filteredDatalist.value = value.rows!;
      responseModel.value = value;
    });
  }
}
