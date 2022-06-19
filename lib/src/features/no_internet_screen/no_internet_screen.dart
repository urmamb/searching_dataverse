import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:searching_dataverse/app/app_assets_path.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/common_widgets/continue_button.dart';
import 'package:searching_dataverse/src/features/no_internet_screen/check_internet_connection.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';

class NoInternetScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: NoInternetScreenContent(),
        ),
      ),
    );
  }
}

class NoInternetScreenContent extends StatefulWidget {
  const NoInternetScreenContent({Key? key}) : super(key: key);

  @override
  State<NoInternetScreenContent> createState() => _NoInternetScreenContentState();
}

class _NoInternetScreenContentState extends State<NoInternetScreenContent> {
  CheckInternetConnection get checkConnection => sl.get<CheckInternetConnection>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 4,
          // fit: FlexFit.tight,
          child: Center(
            child: Container(
              height: 500.h,
              child:Lottie.asset(
                NO_INTERNET_CONNECTION_LOTTIE,
                height: 500.h,
                key: ValueKey('lottie Image'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Flexible(
            flex: 1,
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: 15.h),
                child: Text('No internet connection',
                    style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500)),
              ),
            )),
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
            child: Center(
                child: Text('No internet connection at the moment please try again later',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2)),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Spacer(),
        Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
              child: ContinueButton(
                text: 'Try again',
                onPressed: () {
                  onPressedTryAgain();
                },
              ),
            )),
      ]),
    );
  }

  void onPressedTryAgain() async{
    var checkConnectionEither = await checkConnection.call(NoParams());

    if(checkConnectionEither.isLeft()){
      return;
    }

    var connected = checkConnectionEither.getOrElse(() => false);
    if(connected){
      var appState = GetIt.I.get<AppState>();
      appState.moveToBackScreen();
    }
  }
}
