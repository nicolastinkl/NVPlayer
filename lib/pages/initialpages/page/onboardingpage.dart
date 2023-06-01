import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/initialpages/page/genres_selection_page.dart';
import 'package:movie_app/pages/initialpages/page/onboardingpage_controller.dart';
import 'package:movie_app/pages/main/main_page.dart';
import 'package:movie_app/resources/app_theme.dart';

import 'package:movie_app/utils/strings.dart';

import 'package:movie_app/resources/app_typography.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:get/get.dart';

///
/// [OnBoardingPage.]
/// welcome
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, March 28th, 2023]
/// [@see		StatelessWidget]
/// [@global]
///
class OnBoardingPage extends GetView<onboardingpage_controller> {
  const OnBoardingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const OnBoardingPage());
  }

  void navigateToMainPage(BuildContext context) {
    Navigator.of(context).push(MainPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<onboardingpage_controller>(
      init: onboardingpage_controller(),
      id: "welcome",
      builder: (_) {
        return Scaffold(
          // appBar: AppBar(title: const Text("newsplash")),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (controller.launchADS.value!.show == 1) {
        print("======= ${controller.launchADS.value!.adimageurl}");

/***
 *  FadeInImage.memoryNetwork(
                    image: '${controller.launchADS.value.adimageurl}',
                    placeholder: kTransparentImage,
                  ),

 */

        String str = controller.remainingSeconds.value <= 1
            ? context.l10n.clickenter
            : '${context.l10n.daojishi} ${controller.remainingSeconds}s';

        return Scaffold(
          body: Center(
            child: Stack(
              children: [
                // 使用 transparent_image 包来处理图片加载过程中的各种情况
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: '${controller.launchADS.value!.adimageurl}',
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(
                    child: Text(str),
                    onPressed: () => {
                      controller.remainingSeconds.value <= 1
                          ? navigateToMainPage(context)
                          : controller.startTimer()
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(bottom: 30),
              alignment: Alignment.bottomCenter,
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'images/bc-videologo.png',
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                  // Text(
                  //   "91制片厂",
                  //   style: TextStyles.bigTitle.copyWith(letterSpacing: 2),
                  // )
                ],
              ),
            ),
          ),
        ],
      );
    }));
  }

  @override
  Widget buildold(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://api.dcgvc.com/flutter/bg_0.jpeg'),
            fit: BoxFit.fitHeight,
          ),
          //  DecorationImage(
          //   image: AssetImage('assets/images/on-boarding.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                isRepeatingAnimation: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    entering,
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                welcomeContent,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
                width: double.infinity,
              ),
              //_submitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    var button = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(GenresSelectionPage.route());
        },
        style: AppTheme.raisedButtonStyle,
        child: const Text(getStarted),
      ),
    );
    return Container(
      color: Colors.transparent,
      child: button,
    );
  }
}
