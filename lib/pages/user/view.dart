import 'package:movie_app/common/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final iconsLabel = [
    "模块1",
    "模块2",
    "模块3",
    "模块4",
    "模块5",
    "模块6",
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildIcon = GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.0 //显示区域宽高相等
            ),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/my$index.png",
                  height: ScreenUtil().setWidth(100),
                ),
                Text(iconsLabel[index])
              ],
            ),
          );
        });
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil().setWidth(216),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/topbg.png"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 40),
              child: Text(
                "我的",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(136)),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(40),
                  horizontal: ScreenUtil().setHeight(20)),
              width: MediaQuery.of(context).size.width -
                  ScreenUtil().setHeight(40),
              height: ScreenUtil().setWidth(160),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFB8D9FF),
                    blurRadius: 9.0,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    //圆形头像
                    child: new Image.network(
                      'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "大橘",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xFFff454545),
                    ),
                  ),
                  Spacer(
                    flex: 20,
                  ),
                  Text(
                    "综合得分",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFff454545),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "91",
                    style: TextStyle(
                      fontSize: 42.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFffD0021B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(alignment: Alignment.center, child: buildIcon)
      ]),
    );
  }
}
