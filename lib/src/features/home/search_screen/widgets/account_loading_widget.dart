
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../../app/widgets/responsive.dart';

class AccountLoadingOption extends StatelessWidget {
  const AccountLoadingOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.isMobile(context) ? 40.h : 50),
                  child: Shimmer(
                    color: Theme.of(context).iconTheme.color!,
                    child: Container(
                      height: Responsive.isMobile(context) ? 40.h : 10.w,
                      width: Responsive.isMobile(context) ? 40.h : 10.w,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Shimmer(
                            color: Theme.of(context).iconTheme.color!,
                            child: Container(
                              height: 20.h,
                              width: 70.h,
                            ),
                          ),
                          const Spacer(),
                          Shimmer(
                            color: Theme.of(context).iconTheme.color!,
                            child: SizedBox(
                              height: 18.h,
                              width: 48.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Shimmer(
                            color: Theme.of(context).iconTheme.color!,
                            child: SizedBox(
                              height: 18.h,
                              width: 48.h,
                            ),
                          ),
                          const Spacer(),
                          Shimmer(
                            color: Theme.of(context).iconTheme.color!,
                            child: SizedBox(
                              height: 18.h,
                              width: 70.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
