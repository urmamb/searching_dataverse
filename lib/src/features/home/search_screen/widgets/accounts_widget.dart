import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/app/app_assets_path.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/search_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

import '../../../../../app/widgets/responsive.dart';

class AccountsWidget extends StatelessWidget {
  const AccountsWidget({
    Key? key,
    required this.kItemsPaddingUnit,
    required this.kSpacingUnit,
  }) : super(key: key);

  final int kItemsPaddingUnit;
  final int kSpacingUnit;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchScreenViewModel>();

    return ValueListenableBuilder<List<Account>>(
        valueListenable: viewModel.accounts,
        builder: (context, List<Account> value, child) {
          if (viewModel.isListView.value) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
              (_, __) {
                return AccountsOnDataversListItem(
                  kSpacingUnit: kSpacingUnit,
                  kItemsPaddingUnit: kItemsPaddingUnit,
                  account: viewModel.accounts.value[__],
                );
              },
              childCount: viewModel.accounts.value.length,
            ));
          }
          return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
                mainAxisSpacing: 20.h,
                childAspectRatio:  Responsive.isMobile(context) ? 1.5 : 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, __) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AccountsOnDataversGridItem(
                      kSpacingUnit: kSpacingUnit,
                      kItemsPaddingUnit: kItemsPaddingUnit,
                      account: viewModel.accounts.value[__],
                    ),
                  );
                },
                childCount: viewModel.accounts.value.length,
              ));
        });
  }
}

class AccountsOnDataversListItem extends StatelessWidget {
  final int kItemsPaddingUnit;
  final int kSpacingUnit;
  final Account account;

  const AccountsOnDataversListItem({Key? key, required this.kItemsPaddingUnit, required this.kSpacingUnit, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        padding: EdgeInsets.only(left: kItemsPaddingUnit.w, right: kItemsPaddingUnit.w, bottom: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: kSpacingUnit.w * 5,
            width: kSpacingUnit.w * 5,
            child: Stack(
              children: [Positioned.fill(child: SvgPicture.asset(USER_SVG))],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: kItemsPaddingUnit.w * 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: kItemsPaddingUnit.h * 0.2),
                    child: Text(
                      account.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 14),
                    ),
                  ),
                  Text('${account.address1_city}, ${account.address1_country}', style: Theme.of(context).textTheme.caption),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AccountsOnDataversGridItem extends StatelessWidget {
  final int kItemsPaddingUnit;
  final int kSpacingUnit;
  final Account account;

  const AccountsOnDataversGridItem({Key? key, required this.kItemsPaddingUnit, required this.kSpacingUnit, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.read<SearchScreenViewModel>().routeToBusinessDetailScreen(
        //   businessId: account.accountid,
        // );
      },
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(10.r)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: kSpacingUnit.w * 5,
            width: kSpacingUnit.w * 5,
            child: Stack(
              children: [Positioned.fill(child: SvgPicture.asset(USER_SVG))],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: kItemsPaddingUnit.h * 0.2),
                  child: Text(
                    account.name,
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 14),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '${account.address1_city}, ${account.address1_country}',
                  style: Theme.of(context).textTheme.caption,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
