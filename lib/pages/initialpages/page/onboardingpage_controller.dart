import 'package:get/get.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/public.dart';

import 'package:movie_app/http/api_response.dart';
import 'package:movie_app/models/MainJson.dart';
import 'package:movie_app/models/LaunchadsJson.dart';
import 'package:movie_app/http/http_exceptions.dart';
import 'package:movie_app/pages/initialpages/page/genres_selection_page.dart';
import 'package:movie_app/pages/main/main_page.dart';

class onboardingpage_controller extends GetxController {
  //welcome_controller();

  Rx<LaunchadsJson?> launchADS = LaunchadsJson().obs;

  RxInt remainingSeconds = 5.obs;
  RxString entername = "".obs;

  _initData() async {
    //update(["newsplash"]);

    //启动时
    // App启动时读取Sp数据，需要异步等待Sp初始化完成。
    initHttp();
    SpUtil.getInstance().then((value) => checkLogin());
  }

  initHttp() async {
    getToken(data: {'appId': Apis.appid});

    getLaunchAds(data: {'appId': Apis.appid}).then((value) {
      switch (value.status) {
        case Status.COMPLETED:
          // 更新UI
          // startTimer();
          startCountdown();
          //launchADS = value.data;
          launchADS.value = value.data;
          break;
        case Status.ERROR:
          // 处理错误
          print("请求出错：${value.exception}");
          break;
      }
    });
  }

  Future<ApiResponse<String>> getToken({Map<String, dynamic>? data}) async {
    try {
      //post 请求
      final response = await HttpUtils.get(Apis.token, params: data);

      final newRespnse = response;
      // jsonDecode(response);
      if (newRespnse['code'] as int == 200) {
//      var mainjson = MainJson.fromJson(newRespnse);
        const token = "";
        // newRespnse['data']['token']?.toString();
        print("TOKEN: $token");
        if (StringUtils.isNullOrEmpty(token)) {
          SpUtil.putString(token, "TOKEN");
          return ApiResponse.completed(token);
        }
        return ApiResponse.error(DioHttpException(0, "TOKEN NULL"));
      } else {
        return ApiResponse.error(DioHttpException(0, newRespnse['message']));
        // return ApiResponse.error(ex);
        // HttpException(
        //   0,
        //   response['errmsg'],
        // ),
        //);
      }
    } on DioError catch (e) {
      // print('DioError: ' + e.error);
      return ApiResponse.error(e.error);
    }
  }

  Future<ApiResponse<LaunchadsJson>> getLaunchAds(
      {Map<String, dynamic>? data}) async {
    try {
      //post 请求
      final response = await HttpUtils.get(Apis.getLaunchAds, params: data);

      // final newRespnse = jsonDecode(response);
      final newRespnse = response;
      if (newRespnse['code'] as int == 200) {
        LaunchadsJson adsjson = LaunchadsJson.fromJson(newRespnse['data']);
        return ApiResponse.completed(adsjson);
      } else {
        return ApiResponse.error(DioHttpException(0, newRespnse['message']));
      }
    } on DioError catch (e) {
      // print('DioError: ' + e.error);
      return ApiResponse.error(e.error);
    }
  }

  void startTimer() {
    Timer(const Duration(seconds: 1), () {
      if (remainingSeconds > 1) {
        remainingSeconds--;
        startTimer();
      } else {
        goToHome();
      }
    });
  }

  void startCountdown() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (remainingSeconds.value == 1) {
        timer.cancel();
        goToHome();
        entername.value = "";
      } else {
        remainingSeconds.value--;
      }
    });
  }

  void goToHome() async {
    // Get.toNamed(RouteConfig.mainpage);
    //Get.to(MaterialPageRoute(builder: (context) => const MainPage()));
    // BuildContext? context = Get.context;
    // Navigator.of(context!).push(MainPage.route());
    // print("object");
  }

  checkLogin() async {
    var loginParams = SpUtil.getObject("SP_LOGIN_PARAMS");

    if (loginParams == null) {
      // 跳转登录页
      print(" 显示广告界面");

      // Get.toNamed(RouteConfig.maintabs);
    } else {
      // 隐式登录
      /// 登录成功，跳转首页
      print(" 登录成功，跳转首页");
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();

    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
