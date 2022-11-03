import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sk/ui/screens/profile_screen/profile_screen_provider.dart';
import '../../../core/contstant/color.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/locator.dart';
import '../../../core/services/auth_Services.dart';
import '../../custom_widgets/custom_button.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final locateUser = locator<AuthServices>();

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create: (context) {
      return ProfileScreenProvider();
    },
    child: Consumer<ProfileScreenProvider>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor ,
          title: Text('Profile'),
          centerTitle: true,
          elevation: 0,

        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              Center(
                child:
                CircleAvatar(
                  radius: 50,
                  backgroundImage: locateUser.appUser.profileImage != null
                      ? NetworkImage("${locateUser.appUser.profileImage}")
                      : AssetImage('assets/images/dp20.jpg')
                  as ImageProvider,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: Text("${locateUser.appUser.userName.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),)),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 10,
                      // spreadRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(15),
                  ),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [

                    ///
                    /// Profile body =========>>>
                    ///
                    SizedBox(
                      height: 30,
                    ),

                    ///
                    /// User Name ============>>>
                    ///
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: 20,
                        ),
                        Text("${locateUser.appUser.userName.toString()}"),
                      ],
                    ),
                    Divider(thickness: 1.5),
                    SizedBox(
                      height: 10,
                    ),

                    ///
                    /// Email Address ============>>>
                    ///
                    Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(
                          width: 20,
                        ),
                        Text("${locateUser.appUser.userEmail.toString()}"),
                      ],
                    ),
                    Divider(thickness: 1.5),
                    SizedBox(
                      height: 10,
                    ),

                    ///
                    /// User Address ============>>>
                    ///
                    Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(
                          width: 20,
                        ),
                        Text("${locateUser.appUser.address.toString()}"),
                      ],
                    ),
                    Divider(thickness: 1.5),
                    SizedBox(
                      height: 10,
                    ),

                    ///
                    /// Phone Number ============>>>
                    ///
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${locateUser.appUser.phoneNumber.toString()}",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(thickness: 1.5),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: (){
                          Get.to(() => EditProfileScreen());
                        },
                        child: CustomButton(text: "Edit Profile",))
                  ],
                ),
              ),

            ],
          ),
        )
      );}
    ));
  }
}
