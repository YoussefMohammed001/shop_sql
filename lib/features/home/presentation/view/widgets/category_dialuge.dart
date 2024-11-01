import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

CategoryDialoge(
    {
      required BuildContext context,
    required VoidCallback onPress,
    required TextEditingController categoryController,
    required GlobalKey<FormState> formKey,
    required String title,
    required String buttonTitle
    }) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title:  Text(title),
            content: SizedBox(
              height: 110.h,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Category",
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      onPressed: onPress,
                      child:  Text(buttonTitle),
                    )
                  ],
                ),
              ),
            ));
      });
}
