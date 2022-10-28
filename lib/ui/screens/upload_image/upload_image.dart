import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sk/ui/screens/upload_image/upload_image_provider.dart';

import '../../../core/contstant/color.dart';
import '../../../core/enums/view_state.dart';
import '../../custom_widgets/custom_button.dart';
import '../home_screen/home_screen.dart';
import 'custom_image_form_field.dart';


class UploadImageScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();

  void initState() {
    var currentState;
    // (!this.currentState.value?.initialized ?? false)
    //     ? Container()
    //     : currentState;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UploadImageProvider(),
      child: Consumer<UploadImageProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: primaryColor,
              title: Text(
                "Upload Pictures",
                style: TextStyle( fontWeight: FontWeight.normal, fontSize: 18),
              ),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
            ),
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.busy,
              progressIndicator: CircularProgressIndicator(color: primaryColor),
              child: SingleChildScrollView(

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9ECF0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CustomImageFormField(
                          validator: (img) {
                            if (model.image == null)
                              return 'Pick a picture from gallery';
                            // else if (File != null) return 'Image Picked';
                          },
                          onChanged: (_file) {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),


                              Text(
                                "Post Description",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),

                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: TextFormField(
                                maxLines: 4,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Do Not Left The Title Field Empty";
                                  }
                                },
                                onChanged: (value) {
                                  model.postImage.imageDescription = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFE9ECF0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Post Description',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await model.UploadImage();

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HomeScreen(),
                                      ),
                                          (route) => false);
                                } else
                                  print('Something Went Wrong');
                              },
                              child: CustomButton(
                                text: "Upload Image",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
