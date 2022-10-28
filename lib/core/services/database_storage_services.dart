import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseStorageServices {

  FirebaseStorage _storage = FirebaseStorage.instance;


  ///
  ///  Upload User Profile Image Query ==========>>>
  ///
  Future<String?> uploadUserProfileImage(File image, String uuid) async {
    try {
      var reference = _storage.ref().child("UserProfilesImages/$uuid");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot =
          await uploadImage.whenComplete(() => print('Profile Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Exception@uploadUserProfileImage=> $e");
      return null;
    }
  }


  ///
  ///  Upload User Timeline Images Query ==========>>>
  ///
  Future<String?> uploadUserImages(File image) async {
    try {
      var reference = _storage
          .ref()
          .child("userPostImages/${DateTime.now().microsecondsSinceEpoch}");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot =
          await uploadImage.whenComplete(() => print('Timeline Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }
}
