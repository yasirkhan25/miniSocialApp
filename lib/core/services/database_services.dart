import 'package:cloud_firestore/cloud_firestore.dart';
import '../locator.dart';
import '../models/app_user.dart';
import '../models/post_image_model.dart';
import 'auth_Services.dart';

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;


  ///
  /// Add user ============>>>
  ///
  registerUser(AppUser appUser) {
    try {
      firebaseFireStore
          .collection("AppUser")
          .doc(appUser.appUserId)
          .set(appUser.toJson());
    } catch (e) {
      print('Exception $e');
    }
  }

  ///
  /// Get user ============>>>
  ///
  Future<AppUser> getUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot =
          await firebaseFireStore.collection('AppUser').doc(id).get();
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getUser $e');
      return AppUser();
    }
  }

  ///
  /// get all App Users ============>>>
  ///
  Future<List<AppUser>> getAppUsers() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('AppUser')
          .where('appUserId', isNotEqualTo: locator<AuthServices>().appUser.appUserId)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }


  ///
  /// get all app users
  ///
  Future<List<AppUser>> getTopThreeUsers() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot = await firebaseFireStore
          .collection('AppUser')
          .orderBy('zaps', descending: true)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  ///
  ///  Upload User Profile ============>>>
  ///

  updateUserProfile(AppUser appUser) async {
    try {
      await firebaseFireStore
          .collection('AppUser')
          .doc(appUser.appUserId)
          .update(appUser.toJson());
    } catch (e) {
      print('Exception@UpdateUserProfile=>$e');
    }
  }


  ///
  ///  Set Post Image Data Collection ========>>>
  ///
  setPostImage(PostImage postImage, String UserId) async {
    try {
      var id = DateTime.now().microsecondsSinceEpoch.toString();
      postImage.postImageId = id;

      await firebaseFireStore
          .collection('PostImage')
          .doc(UserId)
          .collection('AllPostImages')
          .doc(id)
          .set(postImage.toJson());
      return true;
    } catch (e) {
      print("Exception@MakingPostImage=>$e");
    }
  }

  ///
  ///  Delete Post Image Data Collection ========>>>
  ///
  deletePostImage(String id, String UserId) async {
    try {

      await firebaseFireStore
          .collection('PostImage')
          .doc(UserId)
          .collection('AllPostImages')
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      print("Exception@DeletePostImage=>$e");
    }
  }


  ///
  /// Get Post Image Data Collection ========>>>
  ///
  Stream<QuerySnapshot>? getPostImage() {
    try {
      Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
          .collection('PostImage')
          .doc(locator<AuthServices>().appUser.appUserId)
          .collection('AllPostImages').orderBy('postImageDate',descending: true)
          .snapshots();
      return snapshots;
    } catch (e) {
      print('Exception @DatabaseService/GetPostImage$e');
    }
  }

  //
  // ///
  // /// Get All Post Image Data Collection ========>>>
  // ///
  // Stream<QuerySnapshot>? getAllPostImages() {
  //   try {
  //     Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
  //         .collectionGroup('AllPostImages')
  //         .snapshots();
  //     return snapshots;
  //   } catch (e) {
  //     print('Exception @DatabaseService/GetAllPostImages $e');
  //   }
  // }

}
