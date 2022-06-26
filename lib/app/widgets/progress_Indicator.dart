import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:searching_dataverse/app/app_assets_path.dart';

Container dataverseProgressIndicator({required DownloadProgress downloadProgress, required double height, required Color color}) =>
    Container(height: height.h, width: height.h, child: Center(child: CircularProgressIndicator.adaptive(value: downloadProgress.progress,
      valueColor: AlwaysStoppedAnimation<Color>(color),

    )));

Container dataverseErrorWidget(context, url, error) => Container(
    height: 100.h,
    width: 100.h,
    child: SvgPicture.asset(
      USER_SVG,
      fit: BoxFit.cover,
    ));
