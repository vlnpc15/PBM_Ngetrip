import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngetrip/controllers/main_controller.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/themes.dart';
import 'package:ngetrip/pages/mapscreen.dart';
import 'package:ngetrip/widgets/linear_gradient_mask.dart';
import 'package:ngetrip/widgets/textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
            bottom: Get.height * 0.06,
            right: -(Get.height * 0.25),
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
                    Center(
                      child: Container(
                        width: Get.width * 0.2,
                        height: Get.width * 0.2,
                        decoration: BoxDecoration(
                          color: AppColor.greyFont,
                          shape: BoxShape.circle,
                          image: null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _input(
                        label: 'Email', controller: username, isValidate: true),
                    _input(
                      label: 'Password',
                      controller: password,
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
                              var success =
                                  await Get.find<MainController>().signIn(
                                email: username.text,
                                password: password.text,
                              );
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
                            'Sign In',
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
    );
  }
}
