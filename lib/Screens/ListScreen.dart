import 'package:artivatic_flutterassignment/Controllers/ListController.dart';
import 'package:artivatic_flutterassignment/Utils/StringUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Initialized Getx Controller
  final ListController controller = Get.put<ListController>(ListController());
  // Text Editing controller to clear the text in search box on refresh
  var SearchtextEditController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.onInit(); // to call API in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('${controller.responseModel.value.title}'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                SearchtextEditController.clear();
                controller.callAPI();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: SearchtextEditController,
              onChanged: (value) => controller.filterlist(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.filteredDatalist.length,
                    itemBuilder: (context, index) {
                      // If all values of item in list are null don't show anything.
                      if (StringUtil.isNull(
                              controller.filteredDatalist[index].title) &&
                          StringUtil.isNull(
                              controller.filteredDatalist[index].description) &&
                          StringUtil.isNull(
                              controller.filteredDatalist[index].imageHref)) {
                        return SizedBox();
                      } else {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: Material(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${controller.filteredDatalist[index].imageHref}',
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "assets/image_not_available.png",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '${controller.filteredDatalist[index].title}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      '${controller.filteredDatalist[index].description}')
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
