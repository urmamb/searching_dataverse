
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AccountLoadingOption extends StatelessWidget {
  const AccountLoadingOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.h),
                  child: Shimmer(
                    color: Theme.of(context).iconTheme.color!,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 40.h,
                      ),
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
