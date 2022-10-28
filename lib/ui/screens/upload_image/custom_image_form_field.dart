import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sk/ui/screens/upload_image/upload_image_provider.dart';
import '../../../core/contstant/color.dart';

class CustomImageFormField extends StatelessWidget {
  CustomImageFormField({
    required this.validator,
    required this.onChanged,
  });
  final String? Function(File?) validator;
  final Function(File) onChanged;
  File? image;
  @override
  Widget build(BuildContext context) {
    return Consumer<UploadImageProvider>(
      builder: (context, model, child) {
        return FormField<File>(
          validator: validator,
          builder: (formFieldState) {
            return Column(
              children: [
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () async {

                  },
                  //    child: Text(''),
                  child: Container(
                    width: double.infinity,
                    child: model.image == null
                        ? InkWell(
                      onTap: () {
                        model.getImage();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text("Select your Photo from Gallery"),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: Colors.white, width: 0.5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "browse Photo",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: FileImage(model.image!),
                        ),
                      ),
                    ),
                  ),
                ),
                if (formFieldState.hasError)
                  Text(
                    formFieldState.errorText!,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      color: Colors.red[700],
                    ),
                  )
              ],
            );
          },
        );
      },
    );
  }
}
