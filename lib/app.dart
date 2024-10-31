import 'package:flutter/material.dart';
import 'package:shop_sql/core/routing/route_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final appNavKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: appNavKey,

          title: 'el-balad',
          debugShowCheckedModeBanner: false,
     // Use saved theme mode
          onGenerateRoute: RouteServices.generateRoute,
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}