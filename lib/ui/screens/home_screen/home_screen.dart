import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/contstant/color.dart';
import 'package:intl/intl.dart';
import '../custom_drawer/custom_drawer.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override

  ///
  ///  Exit App PopUp Show Dialog =====================>>>
  ///
  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ) ??
        false;
  }

  ///
  ///  Exit App PopUp Show Dialog =====================>>>
  ///
  Future<bool> showDeletePopup(BuildContext context, model, index) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Post'),
            content: Text('Do you want to Delete your Post?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                onPressed: () {
                  model.deletePostImage(model.postImages[index].postImageId!);
                  Navigator.of(context).pop(false);
                },
                child: Text('Yes',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeScreenProvider();
      },
      child: SafeArea(
        child: Consumer<HomeScreenProvider>(builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: primaryColor,
              title: Text(
                "Timeline Screen",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              leading: GestureDetector(
                onTap: () => _key.currentState!.openDrawer(),
                child: Icon(
                  Icons.menu,
                  size: 25,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.person_outline_outlined),
                  onPressed: () {
                    Get.to(() => ProfileScreen());
                  },
                )
              ],
            ),
            key: _key,
            drawer: CustomDrawer(),
            body: WillPopScope(
              onWillPop: () async {
                return await showExitPopup(context);
              },
              child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: model.postImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => ProfileScreen());
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: model.locateUser.appUser
                                              .profileImage !=
                                          null
                                      ? NetworkImage(
                                          "${model.locateUser.appUser.profileImage}")
                                      : AssetImage(
                                              'assets/images/babykids18.jpg')
                                          as ImageProvider,
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => ProfileScreen());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${model.locateUser.appUser.userName.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "${DateFormat('dd MMM yyyy').format(DateTime.parse(model.postImages[index].postImageDate!))}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              GestureDetector(
                                  onTap: () {
                                    showDeletePopup(context, model, index);
                                  },
                                  child: Icon(Icons.more_horiz_outlined)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            model.postImages[index].imageDescription.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            // onLongPress: (){
                            //   showDeletePopup(context, model, index);
                            //   // model.deletePostImage(model.postImages[index].postImageId!);
                            // },
                            child: Image.network(
                              model.postImages[index].imgUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  model.setLike();
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      model.like == false
                                          ? Icon(Icons.favorite_outline)
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                      SizedBox(width: 5),
                                      Text("Like"),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.mode_comment_outlined,
                              ),
                              SizedBox(width: 5),
                              Text("Comment"),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.share,
                              ),
                              SizedBox(width: 5),
                              Text("Share"),
                            ],
                          ),
                          SizedBox(height: 15),
                          Divider(
                            thickness: 1.5,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}
