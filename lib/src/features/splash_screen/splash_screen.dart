import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/utils/constants/app_strings.dart';
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

    // viewModel.errorMessages = (value) => scaffoldKey.currentContext!.show(message: value);
    // viewModel.showPermissionDialog = () => showLocationPermissionDialog();
    // viewModel.startConfiguration = () => viewModel.getAllConfigurations();

    viewModel.showInternetSnackBar = () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(NO_INTERNET),
        duration: Duration(hours: 1),
        action: SnackBarAction(
          onPressed: () {
            ScaffoldMessenger.of(navigatorKeyGlobal.currentState!.overlay!.context).hideCurrentSnackBar();

            viewModel.getAllConfigurations();
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

  // void showLocationPermissionDialog() async {
  //   var dialog = ShowPermissionDialog(context);
  //   await dialog.show();
  //   await viewModel.getEssentialPermissions();
  // }
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
        Positioned(left: 0, right: 0, top: 0, child: CasheroAnimatedLogo()),
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
                  'cap_from',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                  textScaleFactor: 0.9,
                ),
                SizedBox(height: 7.h), // used for space
                AnimatedOpacity(
                    opacity: widget.animatedOpacity, duration: Duration(seconds: 2), child: Text('romans_8:28', textAlign: TextAlign.end, style: Theme.of(context).textTheme.headline6)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CasheroAnimatedLogo extends StatefulWidget {
  const CasheroAnimatedLogo({Key? key}) : super(key: key);

  @override
  _CasheroAnimatedLogoState createState() => _CasheroAnimatedLogoState();
}

class _CasheroAnimatedLogoState extends State<CasheroAnimatedLogo> with TickerProviderStateMixin {
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
  bool showLeftCash = true;

  late AnimationController rightAnimationController;
  double rightPositionedValue = -400;
  bool showRightHero = true;

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
        duration: Duration(milliseconds: 600),
        lowerBound: 0,
        upperBound: MediaQuery.of(context).size.width * 0.3,
      );

      leftAnimationController.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {

          leftPositionedValue = MediaQuery.of(context).size.width * 0.35;
          setState(() {});

          await Future.delayed(Duration(seconds: 1));
          showLeftCash = false;
          unawaited(rightAnimationController.forward());
        }
      });


      rightAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
        lowerBound: 0,
        upperBound: MediaQuery.of(context).size.width * 0.3,
      );

      rightAnimationController.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          showRightHero = false;

          setState(() {});
          await Future.delayed(Duration(milliseconds: 200));
          showMainAnimation = true;
          setState(() {});

          // await Future.delayed(Duration(milliseconds: 200));
          // unawaited(context.read<SplashScreenViewModel>().getEssentialPermissions());

        }
      });

      rightAnimationController.addListener(() {
        rightPositionedValue = rightAnimationController.value;
        setState(() {});
      });


      await Future.delayed(Duration(milliseconds: 100));

      unawaited(leftAnimationController.forward());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: Stack(

        children: [
          if (showLeftCash) AnimatedPositioned(bottom: 0, left: leftPositionedValue, duration: Duration(seconds: 1),
          child: Container(width: 130.w, height: 120.h, child: SvgPicture.asset('assets/svg/splash/cash.svg'))),
          if (showRightHero) Positioned(bottom: 0, right: rightPositionedValue, child: Container(width: 130.w, height: 120.h, child: SvgPicture.asset('assets/svg/splash/hero.svg'))),
          if (showMainAnimation) Positioned(left: 0, bottom: 0, right: 0, child: Center(child: Container(width: 220.w, height: 120.h, child: SvgPicture.asset('assets/svg/splash/entire_logo.svg')))),

        ],
      ),
    );
  }
}
