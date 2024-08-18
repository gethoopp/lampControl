import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:lamp_control/cubit/dynamic_theme_cubit.dart';
import 'package:lamp_control/view/home/homepage.dart';


import 'controller/routes.dart';


import 'bloc/control_light_bloc.dart';
import 'view/intro/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    FlutterBluePlus.setLogLevel(LogLevel.debug, color: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ControlLightBloc()..add(RequestBluetoothPermission()),
        ),
        BlocProvider(
          create: (context) => ControlLightBloc()..add(StartConnect()),
        ),
        BlocProvider(
          create: (context) => DynamicThemeCubit(),
        )
      ],
      child: BlocBuilder<DynamicThemeCubit, ThemeData>(
        builder: (context, theme) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            getPages: appRoute(),
            title: 'Smart Lights Control',
            theme: theme,
            home: const AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark),
                child: Homepage()),
          );
        },
      ),
    );
  }
}
