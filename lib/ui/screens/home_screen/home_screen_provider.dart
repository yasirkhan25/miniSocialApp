import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/enums/view_state.dart';
import '../../../core/locator.dart';
import '../../../core/models/base_view_model.dart';
import '../../../core/models/post_image_model.dart';
import '../../../core/services/auth_Services.dart';
import '../../../core/services/database_services.dart';


class HomeScreenProvider extends BaseViewModal {

  DatabaseServices databaseServices = DatabaseServices();
  final locateUser = locator<AuthServices>();

  List<PostImage> postImages = [];

  Stream<QuerySnapshot>? postImagesStream;

  HomeScreenProvider() {
    getImagesData();
  }

  ///
  ///  Get Post Data Function  =========>>>
  ///
  getImagesData() async {
    setState(ViewState.busy);

    postImagesStream = databaseServices.getPostImage();
    postImagesStream!.listen((event) {
      postImages = [];

      if (event.docs.length > 0) {
        event.docs.forEach((element) async {
          postImages.add(PostImage.fromJson(element));
          notifyListeners();
        });
        postImages.reversed;
      }
    });
    setState(ViewState.idle);
  }

  ///
  ///  Image Delete Function =====================>>>
  ///
  deletePostImage(String id) async {
    setState(ViewState.busy);
    await databaseServices.deletePostImage(id, locateUser.appUser.appUserId!);

    setState(ViewState.idle);


    print(' Successfully Deleted ....!');
  }


  ///
  ///  Like, DisLike Function =========>>>
  ///
  bool like = false;
  setLike() {

  like = !like;

  notifyListeners();

}
}
