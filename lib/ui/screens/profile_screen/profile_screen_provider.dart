import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sk/ui/screens/home_screen/home_screen.dart';
import 'package:sk/ui/screens/profile_screen/profile_screen.dart';
import '../../../../core/enums/view_state.dart';
import '../../../../core/locator.dart';
import '../../../../core/models/app_user.dart';
import '../../../../core/models/base_view_model.dart';
import '../../../../core/services/auth_Services.dart';
import '../../../../core/services/custom_auth_result.dart';
import '../../../../core/services/database_storage_services.dart';
import '../../../core/services/database_services.dart';
import '../../custom_widgets/custom_snacke_bar.dart';

class ProfileScreenProvider extends BaseViewModal {
  final _authServices = locator<AuthServices>();
  final locateUser = locator<AuthServices>();
  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();
  final databaseServices = DatabaseServices();

  XFile? image;
  File? userImage;
  String? imageUrl;

  String? editName;
  String? editAddress;
  String? editPhoneNo;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  DatabaseStorageServices databaseStorageServices = DatabaseStorageServices();


  ProfileScreenProvider() {
    appUser = locateUser.appUser;

    nameController = TextEditingController(text: locateUser.appUser.userName);
    addressController = TextEditingController(text: locateUser.appUser.address);
    phoneNoController = TextEditingController(text: locateUser.appUser.phoneNumber);

  }

  ///
  ///  Update User Detail =========================================>>>
  ///

  updateProfile(AppUser appUser) async {
    await databaseServices.updateUserProfile(appUser);
    print("profile updated successfully");

    Get.back();
  }


  ///
  ///  upload Image To Storage =========================================>>>
  ///
  uploadImageToStorage(AppUser appUser) async {
    setState(ViewState.busy);
    appUser= locateUser.appUser;

    if (userImage != null) {
      appUser.profileImage = await databaseStorageServices.uploadUserImage(
          userImage!, locateUser.appUser.appUserId.toString());
    }

    await updateProfile(appUser);

    setState(ViewState.idle);
  }

  ///
  ///  Image Packer =============================================>>>
  ///

  pickImageFromGallery() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage = File(image!.path);
      print("UserImagePath=>${userImage!.path}");
      notifyListeners();
    }
  }

}
