


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searching_dataverse/src/features/common_widgets/continue_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child: const Center(child: Text('Dataverse lets you securely store and manage data that iss used by business applications. Data within Dataverse is stored within a set of tables.'))),
            // SizedBox(height: 30.h,),
            Spacer(),
            Center(
              child: ContinueButton(text: 'Access Dataverse Table', onPressed: (){

              }),
            ),
            SizedBox(height: 30.h,),

          ],
        ),
      ),
    );
  }
}
