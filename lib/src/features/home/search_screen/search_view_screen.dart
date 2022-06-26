import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/app/app_assets_path.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/search_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';
import 'package:searching_dataverse/src/features/home/search_screen/widgets/account_loading_widget.dart';
import 'package:searching_dataverse/src/features/home/search_screen/widgets/accounts_widget.dart';
import 'package:searching_dataverse/src/features/home/search_screen/widgets/filter_bottom_sheet.dart';
import 'package:searching_dataverse/utils/extensions/extensions.dart';

class SearchViewScreen extends StatefulWidget {
  const SearchViewScreen({Key? key}) : super(key: key);

  @override
  State<SearchViewScreen> createState() => _SearchViewScreenState();
}

class _SearchViewScreenState extends State<SearchViewScreen> {
  SearchScreenViewModel get viewModel => sl();

  @override
  void initState() {
    super.initState();

    viewModel.errorMessageNotifier = (value) => context.show(message: value);
    viewModel.searchController.text = '';
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ChangeNotifierProvider<SearchScreenViewModel>.value(
        value: viewModel,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100.h),
              child: buildBackButton(),
            ),
            body: ValueListenableBuilder(
                valueListenable: viewModel.loadingNotifier,
                builder: (_, bool value, Widget? child) {
                  if (value) {
                    return ListView.builder(
                        itemCount: 7,
                        itemBuilder: (_, __) {
                          return const AccountLoadingOption();
                        });
                  }
                  return const SearchViewScreenContent(
                    key: ValueKey('BusinessPaymentTabViewList'),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkResponse(
          onTap: () {
            viewModel.moveBack();
          },
          child: Container(
            margin: EdgeInsets.only(left: 12.w),
            height: 60.h,
            width: 50.h,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back,
              size: 20.w,
            ),
          ),
        ),
        InkResponse(
          onTap: () {
            viewModel.logout();
          },
          child: Container(
            margin: EdgeInsets.only(left: 12.w),
            height: 60.h,
            width: 50.h,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.logout,
              size: 20.w,
            ),
          ),
        ),
        InkResponse(
          onTap: () {
            viewModel.switchView();
          },
          child: Container(
            margin: EdgeInsets.only(left: 12.w),
            height: 60.h,
            width: 50.h,
            alignment: Alignment.centerLeft,
            child: ValueListenableBuilder<bool>(
                valueListenable: viewModel.isListView,
                builder: (context, value, child) {
                  return Icon(
                    value ? Icons.grid_view_rounded : Icons.list,
                    size: 20.w,
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class SearchViewScreenContent extends StatefulWidget {
  const SearchViewScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  _SearchViewScreenContentState createState() => _SearchViewScreenContentState();
}

class _SearchViewScreenContentState extends State<SearchViewScreenContent> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SearchScreenViewModel>().searchAccount();
    context.read<SearchScreenViewModel>().searchController.addListener(context.read<SearchScreenViewModel>().changeSearchString);
    context.read<SearchScreenViewModel>().selectedStatesList.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Card(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ListTile(
                    title: TextField(
                      controller: context.read<SearchScreenViewModel>().searchController,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        hintText: 'Search account',
                        hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.sp, color: Theme.of(context).primaryColor.withOpacity(0.2)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: ValueListenableBuilder<List<Account>>(
              valueListenable: context.read<SearchScreenViewModel>().accountsOnDataversList,
              builder: (context, value, child) {
                if (value.isEmpty) {
                  if (context.read<SearchScreenViewModel>().searchController.text.isNotEmpty) {
                    return Container(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(height: 10.h * 2),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'Accounts on dataverse',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 10.h * 9),
                      Center(
                        child: SvgPicture.asset(DATAVERSE_SVG),
                      ),
                      SizedBox(height: 10.h * 2),
                      Center(
                          child: Text(
                        'No result found',
                        style: Theme.of(context).textTheme.headline2,
                      ))
                    ]));
                  }
                  return const SizedBox();
                }

                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 10.h * 2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Accounts on dataverse',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.normal),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final filterBottomSheet = FilterAccountsBottomSheet(context);
                            filterBottomSheet.show();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Theme.of(context).textTheme.bodyText1!.color),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.filter_alt_rounded,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Filter'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h * 2),
                ]);
              }),
        ),
        const AccountsWidget(kItemsPaddingUnit: 20, kSpacingUnit: 10),
        SliverToBoxAdapter(
          child: ValueListenableBuilder<List<Account>>(
            builder: (context, value, child) {
              if (value.isEmpty) {
                return const SizedBox();
              }

              return Divider(
                height: 25.h,
              );
            },
            valueListenable: context.read<SearchScreenViewModel>().accountsOnDataversList,
          ),
        ),
      ],
    );
  }
}
