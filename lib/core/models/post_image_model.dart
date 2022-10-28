import 'app_user.dart';

class PostImage {
  String? imgUrl;
  String? userId;
  String? postImageId;
  String? imageDescription;
  String? postImageDate;

  PostImage(
      {this.imgUrl,
        this.userId,
        this.postImageId,
        this.imageDescription,
        this.postImageDate,
      });

  PostImage.fromJson(json) {
    this.imgUrl = json['imgUrl'];
    this.userId = json['userId'];
    this.postImageId = json['postImageId'];
    this.imageDescription = json['imageDescription'];
    this.postImageDate = json['postImageDate'];
  }

  toJson() {
    return {
      'userId': this.userId,
      'postImageId': this.postImageId,
      'imgUrl': this.imgUrl,
      'imageDescription': this.imageDescription,
      'postImageDate': this.postImageDate,
    };
  }

}
