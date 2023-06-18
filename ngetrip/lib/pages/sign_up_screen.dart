import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngetrip/controllers/main_controller.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/models/user_model.dart';
import 'package:ngetrip/core/themes.dart';
import 'package:ngetrip/pages/mapscreen.dart';
import 'package:ngetrip/pages/sign_in_screen.dart';
import 'package:ngetrip/widgets/dropdown.dart';
import 'package:ngetrip/widgets/linear_gradient_mask.dart';
import 'package:ngetrip/widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  String? selectedGender;
  File? image;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    username.dispose();
    bio.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _input({
      required String label,
      required TextEditingController controller,
      bool obscureText = false,
      bool isValidate = false,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textBold14,
            ),
            SizedBox(
              width: 200,
              height: 14,
              child: AppTextField(
                controller: controller,
                obscureText: obscureText,
                label: label,
                isValidate: isValidate,
              ),
            ),
          ],
        ),
      );
    }

    Widget _dropdown({required String label}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textBold14,
            ),
            SizedBox(
              width: 200,
              height: 16,
              child: GenderDropdown(
                value: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -(Get.height * 0.05),
              left: -(Get.height * 0.21),
              child: Container(
                width: Get.height * 0.338,
                height: Get.height * 0.338,
                decoration: BoxDecoration(
                  color: AppColor.lightPrimaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: Get.height * 0.08,
              right: -(Get.height * 0.1),
              child: Container(
                width: Get.height * 0.338,
                height: Get.height * 0.338,
                decoration: BoxDecoration(
                  color: AppColor.lightPrimaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -(Get.height * 0.06),
              right: -(Get.height * 0.1),
              child: Container(
                width: Get.height * 0.338,
                height: Get.height * 0.338,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LogoWidget(),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () async {
                          var file = await Get.find<MainController>()
                              .picker
                              .pickImage(source: ImageSource.gallery);

                          if (file != null) {
                            setState(() {
                              image = File(file.path);
                            });
                          }
                        },
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: Get.width * 0.2,
                                height: Get.width * 0.2,
                                decoration: BoxDecoration(
                                  color: AppColor.greyFont,
                                  shape: BoxShape.circle,
                                  image: image != null
                                      ? DecorationImage(
                                          image: FileImage(image!))
                                      : null,
                                ),
                              ),
                              Text(
                                'Change Profile Image',
                                style: text14.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _input(label: 'Name', controller: name, isValidate: true),
                      _input(
                          label: 'Username',
                          controller: username,
                          isValidate: true),
                      _input(label: 'Bio', controller: bio),
                      _input(
                          label: 'Email', controller: email, isValidate: true),
                      _input(
                          label: 'Phone', controller: phone, isValidate: true),
                      _dropdown(label: 'Gender'),
                      _input(
                        label: 'Password',
                        controller: password,
                        obscureText: true,
                        isValidate: true,
                      ),
                      _input(
                        label: 'Confirm',
                        controller: confirm,
                        obscureText: true,
                        isValidate: true,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              var validate = _formKey.currentState?.validate();
                              if (validate ?? false) {
                                var temp = UserModel(
                                  bio: bio.text,
                                  email: email.text,
                                  gender: selectedGender,
                                  name: name.text,
                                  password: password.text,
                                  username: username.text,
                                  phone: phone.text,
                                );
                                var success = await Get.find<MainController>()
                                    .signUp(user: temp, image: image);
                                if (success) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const MapScreen()));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColor.secondaryBackgroundApp,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: AppColor.blackFont,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: textBold18,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColor.secondaryBackgroundApp,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: AppColor.blackFont,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: textBold18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
