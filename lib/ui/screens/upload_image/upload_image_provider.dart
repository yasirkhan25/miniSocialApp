import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/locator.dart';
import '../../../core/models/base_view_model.dart';
import '../../../core/models/post_image_model.dart';
import '../../../core/services/auth_Services.dart';
import '../../../core/services/database_services.dart';
import '../../../core/services/database_storage_services.dart';

///
///      Real Time Picker MultiProvider ====================>>>
///

class UploadImageProvider extends BaseViewModal {
  File? image;
  DatabaseServices dataBaseServices = DatabaseServices();
  DatabaseStorageServices databaseStorageServices = DatabaseStorageServices();
  final currentAppUser = locator<AuthServices>().appUser;
  PostImage postImage = PostImage();

  DateTime now = DateTime.now();


  ///  File? image ======>>>
  ///
  ImagePicker imagePicker = ImagePicker();

  getImage() async {
    final img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (img != null) {
      image = File(img.path);
      notifyListeners();
    }
  }

  ///
  ///  Upload Image Function ===========>>>
  ///
  UploadImage() async {

    setState(ViewState.busy);

    postImage.userId = currentAppUser.appUserId;

    if (image != null) {
      postImage.imgUrl =
      await databaseStorageServices.uploadUserImages(image!);
    }
    postImage.postImageDate = now.toString();

    final result = await dataBaseServices.setPostImage(
        postImage, currentAppUser.appUserId!);
    if (result != true) {}

    setState(ViewState.idle);
  }
}
