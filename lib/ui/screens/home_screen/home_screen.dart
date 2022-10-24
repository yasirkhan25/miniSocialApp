import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sk/ui/screens/categories_scroller/categories_scroller.dart';
import '../../../core/contstant/color.dart';
import '../../../core/contstant/contstant.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../profile_screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = KIDS_DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              color: primaryColor,
              width: double.infinity,
              child: Image.asset(
                "${post["image"]}",
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {

      double value = controller.offset/1119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

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



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.25;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: primaryColor,
          title: Text(
            "Baby Pictures",
            style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          leading: GestureDetector(
            onTap: () => _key.currentState!.openDrawer(),
            child: Icon(Icons.menu,size: 25,),
          ),
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.person_outline_outlined),
              onPressed: () {Get.to(() => ProfileScreen());},
            )
          ],
        ),
        key: _key,
        drawer: CustomDrawer(),
        body:
        WillPopScope(
            onWillPop: () async {
            return await showExitPopup(context);
            },
            child:
            Container(
            height: size.height,
            child: Column(
              children: <Widget>[
                 SizedBox(
                  height: 10,
                ),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: closeTopContainer?0:1,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: size.width,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer?0:categoryHeight,
                      child: categoriesScroller),
                ),
                Expanded(
                    child: ListView.builder(
                        controller: controller,
                        itemCount: itemsData.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          double scale = 1.0;
                          if (topContainer > 0.5) {
                            scale = index + 0.5 - topContainer;
                            if (scale < 0) {
                              scale = 0;
                            } else if (scale > 1) {
                              scale = 1;
                            }
                          }
                          return Opacity(
                            opacity: scale,
                            child: Transform(
                              transform:  Matrix4.identity()..scale(scale,scale),
                              alignment: Alignment.bottomCenter,
                              child: Align(
                                  heightFactor: 0.7,
                                  alignment: Alignment.topCenter,
                                  child: itemsData[index]),
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

