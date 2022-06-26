import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/utils/constants/app_strings.dart';
import 'package:searching_dataverse/utils/extensions/extensions.dart';
import 'splash_screen_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool bioAutEnabled = false;

  SplashScreenViewModel get viewModel => sl();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  double animatedOpacity = 1;

  @override
  void initState() {
    super.initState();

    viewModel.errorMessages = (value) => scaffoldKey.currentContext!.show(message: value);
    // viewModel.showPermissionDialog = () => showLocationPermissionDialog();
    // viewModel.startConfiguration = () => viewModel.moveToHomeScreen();

    viewModel.showInternetSnackBar = () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(NO_INTERNET),
        duration: const Duration(hours: 1),
        action: SnackBarAction(
          onPressed: () {
            ScaffoldMessenger.of(navigatorKeyGlobal.currentState!.overlay!.context).hideCurrentSnackBar();

            viewModel.checkInternetConnection();
          },
          label: 'Retry',
        ),
      ));
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ChangeNotifierProvider.value(
          value: viewModel,
          builder: (context, snapshot) {
            return SplashScreenContent(animatedOpacity: animatedOpacity);
          }),
    );
  }
}

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({
    Key? key,
    required this.animatedOpacity,
  }) : super(key: key);

  final double animatedOpacity;

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(left: 0, right: 0, top: 0, bottom: 0, child: Container()),
        const  Positioned(left: 0, right: 0, top: 0, child: MyAppAnimatedLogo()),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 35.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 7.h), // used for space
                Text(
                  'Searching Dataverse',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                  // textScaleFactor: 0.9,
                ),
                SizedBox(height: 7.h), // used for space
                AnimatedOpacity(
                    opacity: widget.animatedOpacity, duration: const Duration(seconds: 2), child: Text('Technical assessment', textAlign: TextAlign.end, style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12.sp))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyAppAnimatedLogo extends StatefulWidget {
  const MyAppAnimatedLogo({Key? key}) : super(key: key);

  @override
  _MyAppAnimatedLogoState createState() => _MyAppAnimatedLogoState();
}

class _MyAppAnimatedLogoState extends State<MyAppAnimatedLogo> with TickerProviderStateMixin {
  late AnimationController firstBounceDown;
  late AnimationController secondBounceUp;
  late AnimationController secondBounceDown;
  late AnimationController thirdBounceUp;
  late AnimationController thirdBounceDown;

  double marginTop = 0;

  int firstBounceDurationInMilliSeconds = 600;
  int secondBounceDurationInMilliSeconds = 400;
  int thirdBounceDurationInMilliSeconds = 100;

  double firstBounceHeight = 0;
  double secondBounceHeight = 0;
  double thirdBounceHeight = 0;

  late AnimationController leftAnimationController;
  double leftPositionedValue = -500;
  bool showLeftMove = true;

  late AnimationController rightAnimationController;
  double rightPositionedValue = -400;
  bool showRightMove = true;

  bool showMainAnimation = false;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() async {
      firstBounceHeight = MediaQuery.of(context).size.height * 0.45;
      secondBounceHeight = MediaQuery.of(context).size.height * 0.1;
      thirdBounceHeight = MediaQuery.of(context).size.height * 0.01;

      leftAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
        lowerBound: 0,
        upperBound: MediaQuery.of(context).size.width * 0.3,
      );

      leftAnimationController.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {

          leftPositionedValue = MediaQuery.of(context).size.width * 0.35;
          setState(() {});

          await Future.delayed(const Duration(seconds: 1));
          showLeftMove = false;
          unawaited(rightAnimationController.forward());
        }
      });


      rightAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
        lowerBound: 0,
        upperBound: MediaQuery.of(context).size.width * 0.3,
      );

      rightAnimationController.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          showRightMove = false;

          setState(() {});
          await Future.delayed(const Duration(milliseconds: 200));
          showMainAnimation = true;
          setState(() {});
        }
      });

      rightAnimationController.addListener(() {
        rightPositionedValue = rightAnimationController.value;
        setState(() {});
      });

      await Future.delayed(const Duration(milliseconds: 100));
      unawaited(leftAnimationController.forward());

      await Future.delayed(const Duration(seconds: 3), (){
        context.read<SplashScreenViewModel>().moveToHomeScreen();
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      child: Stack(

        children: [
          if (showLeftMove) AnimatedPositioned(bottom: 0, left: leftPositionedValue, duration: const Duration(seconds: 1),
          child: SizedBox(width: 130.w, height: 120.h, child: SvgPicture.asset('assets/svg/dataverse_scalable.svg'))),
          if (showRightMove) Positioned(bottom: 0, right: rightPositionedValue, child: SizedBox(width: 130.w, height: 120.h, child: SvgPicture.asset('assets/svg/dataverse_scalable.svg'))),
          if (showMainAnimation) Positioned(left: 0, bottom: 0, right: 0, child: Center(child: SizedBox(width: 220.w, height: 120.h, child: SvgPicture.asset('assets/svg/dataverse_scalable.svg')))),

        ],
      ),
    );
  }
}
