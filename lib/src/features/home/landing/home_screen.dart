import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/app/widgets/show_loader.dart';
import 'package:searching_dataverse/src/features/home/landing/home_screen_view_model.dart';
import 'package:searching_dataverse/utils/extensions/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel get viewModel => sl();
  late ShowLoader showLoader;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      showLoader = ShowLoader(context);
    });

    viewModel.errorMessageNotifier = (message) => context.show(message: message);
    viewModel.toggleShowLoader = () => showLoader.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: viewModel,
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    child: Image.asset('assets/images/platform.png'),
                  ),
                ),
              ),
              // SizedBox(height: 30.h,),
              Flexible(
                  flex: 1,
                  child: Center(
                      key: Key('description_text'),
                      child: Padding(
                        padding: EdgeInsets.all(20.0.w),
                        child: Text('Dataverse lets you securely store and manage data that iss used by business applications. Data within Dataverse is stored within a set of tables.'),
                      ))),
              // SizedBox(height: 30.h,),
              Spacer(),
              Center(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    key: Key('access_button'),
                    onPressed: () async {
                      showLoader.toggle();
                      viewModel.getAccessToken();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      )),
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      foregroundColor: MaterialStateProperty.all(Theme.of(context).textTheme.bodyText1!.color),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Text(
                      'Access Dataverse',
                      style: TextStyle(color: Theme.of(context).canvasColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
