import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/themes.dart';
import 'package:ngetrip/pages/mapscreen.dart';
import 'package:ngetrip/pages/sign_in_screen.dart';
import 'package:ngetrip/pages/sign_up_screen.dart';
import 'package:ngetrip/widgets/linear_gradient_mask.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('state: ${Get.height * 0.21}');
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundApp,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Positioned(
            top: Get.height * 0.17,
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
            top: Get.height * 0.8,
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
            top: Get.height * 0.6,
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
          Positioned(
            top: 0,
            left: -(Get.height * 0.136),
            child: Container(
              width: Get.height * 0.338,
              height: Get.height * 0.338,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              height: Get.height / 2,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(vertical: 23, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LogoWidget(),
                  SizedBox(
                    height: Get.height * 0.002,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SignUpScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: Get.width * 0.24,
                      ),
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
                      style: textBold18.copyWith(fontSize: 25),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SignInScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: Get.width * 0.24,
                      ),
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
                      style: textBold18.copyWith(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
