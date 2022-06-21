import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/src/features/common_widgets/continue_button.dart';
import 'package:searching_dataverse/src/features/home/home_screen_view_model.dart';
import 'package:searching_dataverse/utils/extensions/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel get viewModel => sl();

  @override
  void initState() {
    super.initState();
    viewModel.errorMessageNotifier = (message) => context.show(message: message);
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
                    // width: MediaQuery.of(context).size.width,
                    child: Image.asset('images/platform.png'),
                  ),
                ),
              ),
              // SizedBox(height: 30.h,),
              Flexible(
                  flex: 1,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(20.0.w),
                    child: Text('Dataverse lets you securely store and manage data that iss used by business applications. Data within Dataverse is stored within a set of tables.'),
                  ))),
              // SizedBox(height: 30.h,),
              Spacer(),
              Center(
                child: ContinueButton(text: 'Access Dataverse Table', onPressed: () {
                  viewModel.getAccessToken();

                }),
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
