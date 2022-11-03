import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sk/ui/screens/auth_screens/signup_screen/signup_provider.dart';
import '../../../../core/contstant/color.dart';
import '../../../../core/enums/view_state.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../signin_screen/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SignUpProvider();
      },
      child: Consumer<SignUpProvider>(builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: primaryColor,

            ///
            ///   Body ==================>>>
            ///
            body: ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: primaryColor,
              ),
              inAsyncCall: model.state == ViewState.busy,
              child:  SingleChildScrollView(
                child: Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        child: Container(
                          child: Center(
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                    ),
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
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
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),

                                /// Name TextField ============>>>
                                CustomTextField(
                                  hintText: 'Full Name',
                                  textInputAction: TextInputAction.next,
                                  keyBoardType: TextInputType.name,
                                  onChanged: (value) {
                                    model.appUser.userName = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your Full Name";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),

                                /// Email TextField ============>>>
                                CustomTextField(
                                  hintText: 'Email',
                                  textInputAction: TextInputAction.next,
                                  keyBoardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    model.appUser.userEmail = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your Email";
                                    }
                                    if (!value.contains("@")) {
                                      return "Enter valid email";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),

                                /// Phone Number TextField ============>>>
                                CustomTextField(
                                  hintText: 'Phone Number',
                                  textInputAction: TextInputAction.next,
                                  keyBoardType: TextInputType.phone,
                                  onChanged: (value) {
                                    model.appUser.phoneNumber = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your Phone Number";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),

                                /// Address TextField ============>>>
                                CustomTextField(hintText: 'Address',
                                  textInputAction: TextInputAction.next,
                                  keyBoardType: TextInputType.streetAddress,
                                  onChanged: (value) {
                                    model.appUser.address = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your Address";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),

                                ///  Password TextField ============>>>
                                CustomTextField(
                                  hintText: 'Password',
                                  textInputAction: TextInputAction.next,
                                  obscureText: model.isVisiblePassword,
                                  keyBoardType: TextInputType.visiblePassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      model.visiblePassword();
                                    },
                                    icon: model.isVisiblePassword
                                        ? Icon(
                                      Icons.visibility_off,
                                      color: Color(0xFF568C48),
                                    )
                                        : Icon(
                                      Icons.visibility,
                                      color: Color(0xFF568C48),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    model.appUser.password = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password can't be empty";
                                    }
                                    if (value.length < 6) {
                                      return "Password length must be 6 characters";
                                    }
                                  },

                                ),
                                SizedBox(
                                  height: 12,
                                ),

                                /// Confirm Password ============>>>
                                CustomTextField(
                                  hintText: 'Confirm Password',
                                  textInputAction: TextInputAction.done,
                                  obscureText: model.isVisiblePassword,
                                  keyBoardType: TextInputType.visiblePassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      model.visiblePassword();
                                    },
                                    icon: model.isVisiblePassword
                                        ? Icon(
                                      Icons.visibility_off,
                                      color: Color(0xFF568C48),
                                    )
                                        : Icon(
                                      Icons.visibility,
                                      color: Color(0xFF568C48),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    model.appUser.confirmPassword = value;
                                  },
                                  validator: (value) {
                                    if (model.appUser.confirmPassword !=
                                        model.appUser.password) {
                                      return "Password does not matched";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                ///
                                /// Sign Up Button ============>>>
                                ///
                                InkWell(
                                  onTap: () async{
                                    await model.uploadImageToStorage(context);
                                  },
                                  child: CustomButton(text: 'SIGN UP'),
                                ),

                                ///
                                /// Already Have an Account =========>>>
                                ///
                                InkWell(
                                  onTap: () {
                                    Get.off(() => SignInScreen());
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Already have an account?',
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 15),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ' Sign In',
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 16),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
