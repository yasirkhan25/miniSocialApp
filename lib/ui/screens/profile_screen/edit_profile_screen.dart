import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sk/ui/screens/profile_screen/profile_screen_provider.dart';
import '../../../core/contstant/color.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/locator.dart';
import '../../../core/services/auth_Services.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
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
          title: Text('Edit Profile'),
          centerTitle: true,
          elevation: 0,

        ),
        body:  ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
          color: primaryColor,
        ),
          inAsyncCall: model.state == ViewState.busy,
          child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 45,
                        backgroundImage: model
                            .userImage !=
                            null
                            ? FileImage(
                            model.userImage!)
                            : model.locateUser.appUser
                            .profileImage !=
                            null
                            ? NetworkImage(model
                            .locateUser
                            .appUser
                            .profileImage!)
                            : AssetImage(
                            'assets/images/dp20.jpg')
                        as ImageProvider,
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(right: 8, bottom: 28),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.only(),
                          tapTargetSize:
                          MaterialTapTargetSize
                              .shrinkWrap,
                        ),
                        onPressed: () {
                          model.pickImageFromGallery();
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(child: Text("${locateUser.appUser.userName.toString()}",
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),)),
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
                      /// Edit Profile body =========>>>
                      ///
                      SizedBox(
                        height: 30,
                      ),

                      ///
                      /// Edit User Name ============>>>
                      ///
                      CustomTextField(
                        hintText: "Enter Name",
                        textInputAction: TextInputAction.next,
                        keyBoardType: TextInputType.name,
                       // suffixIcon: IconButton(Icons.edit,size: 20,),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            model.appUser.userName = value;
                          }
                        },
                        controller: model.nameController,
                      ),

                      Divider(thickness: 1.5),
                      SizedBox(
                        height: 10,
                      ),


                      ///
                      /// User Address ============>>>
                      ///
                      CustomTextField(
                        hintText: "Enter Address",
                        textInputAction: TextInputAction.next,
                        keyBoardType: TextInputType.streetAddress,
                       // sufFixIcon: Icon(Icons.edit,size: 20,),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            model.appUser.address = value;
                          }
                        },
                        controller: model.addressController,
                      ),
                      Divider(thickness: 1.5),
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      /// Phone Number ============>>>
                      ///
                      CustomTextField(
                        hintText: "Enter Phone Number",
                        textInputAction: TextInputAction.next,
                        keyBoardType: TextInputType.phone,
                        //sufFixIcon: Icon(Icons.edit,size: 20,),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            model.appUser.phoneNumber = value;
                          }
                        },
                        controller: model.phoneNoController,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Divider(thickness: 1.5),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: ()async{
                            await model.uploadImageToStorage(model.appUser);
                          },
                          child: CustomButton(text: "Update Profile",))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),);
    }
    ),
    );
  }
}
