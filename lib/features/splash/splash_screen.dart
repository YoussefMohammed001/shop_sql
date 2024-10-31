import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/core/helpers/navigators.dart';
import 'package:shop_sql/core/routing/routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2), () {
      print("hello splash");
      pushNamed(context, Routes.mainScreen); // back available
      pushNamedAndRemoveUntil(context, Routes.mainScreen); // back not available
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      bottom: false,
      child: Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Icon(Icons.shopping_bag_outlined,
      color: Colors.blueAccent,
      size: 50.sp,
        ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sho App",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
            ],
          )


      ],),
      ),
    );
  }
}
