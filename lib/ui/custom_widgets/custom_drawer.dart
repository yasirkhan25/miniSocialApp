
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sk/ui/screens/auth_screens/signin_screen/signin_screen.dart';
import '../../core/contstant/color.dart';
import '../../core/locator.dart';
import '../../core/services/auth_Services.dart';
import '../screens/profile_screen/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final locateUser = locator<AuthServices>();

  ///
  ///  Sign Out Function =====================>>>
  ///
  void logout() async {
    await FirebaseAuth.instance.signOut();

    Get.offAll(() => SignInScreen(),predicate: (route)=>false);
    print(' Successfully Sign Out ....!');
  }

  ///
  ///  Exit App PopUp Show Dialog =====================>>>
  ///
  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout App'),
        content: Text('Do you want to Logout an App?'),
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
              logout();
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
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.0),
        bottomRight: Radius.circular(10.0),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: locateUser.appUser.profileImage != null
                          ? NetworkImage("${locateUser.appUser.profileImage}")
                          : AssetImage('assets/images/babykids15.jpg')
                      as ImageProvider,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${locateUser.appUser.userName.toString()}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),

                  /// Profile Button ============>>>
                  ///
                  InkWell(
                    onTap: (){
                      Get.to(() => ProfileScreen());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.person_outline_outlined, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'PROFILE',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(Icons.arrow_forward_ios_outlined, size: 20),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  /// Log Out Button ============>>>
                  ///
                  InkWell(
                  onTap: ()  {
                   showExitPopup(context);
                    },
                  child: Row(
                    children: [
                      Icon(Icons.login_outlined, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'LOG OUT',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward_ios_outlined, size: 20),
                    ],
                  ),
              )],
              ),
            )
          ],
        ),
      ),
    );
  }
}
