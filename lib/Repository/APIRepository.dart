import 'package:artivatic_flutterassignment/Models/ResponseModel.dart';
import 'package:artivatic_flutterassignment/NetworkHelpers/DioClient.dart';
import 'package:artivatic_flutterassignment/Utils/CommonUtils.dart';
import 'package:artivatic_flutterassignment/Utils/StringUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class APIRepository {
  Future<ResponseModel> CalAPI() async {
    ResponseModel finalresponseModel = ResponseModel();

    try {
      ResponseModel? responseModel = await DioClient.getinstance()
          ?.getHTTP('c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf');
      if (!StringUtil.isNullObject(responseModel) &&
          !StringUtil.isNull(responseModel?.title) &&
          !StringUtil.isNullList(responseModel?.rows)) {
        finalresponseModel = responseModel!;
      }
    } catch (e) {
      print(e);
    }

    return finalresponseModel;
  }
}
