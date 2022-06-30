import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/app/app_assets_path.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/app/widgets/responsive.dart';
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
              preferredSize: Size(MediaQuery.of(context).size.width, 80),
              child: buildBackButton(),
            ),
            body: ValueListenableBuilder(
                valueListenable: viewModel.loadingNotifier,
                builder: (_, bool value, Widget? child) {
                  if (value) {
                    return ListView.builder(
                        key: const Key('account_loading'),
                        itemCount: 7,
                        itemBuilder: (_, index) {
                          return const AccountLoadingOption();
                        });
                  }
                  return const SearchViewScreenContent(
                    key: Key('search_view_screen_contents'),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: InkResponse(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,

              key: const Key('back_button'),
              onTap: () {
                viewModel.moveBack();
              },
              child: Container(
                margin: EdgeInsets.only(left: 12.w),
                height: 60.h,
                width: 50.h,
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: Responsive.isMobile(context) ? 20.w : 5.w,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkResponse(
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  viewModel.logout();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 12.w),
                  height: 60.h,
                  width: 50.h,
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Icon(
                      Icons.logout,
                      size: Responsive.isMobile(context) ? 20.w : 5.w,
                    ),
                  ),
                ),
              ),
              InkResponse(
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,

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
                        return Center(
                          child: Icon(
                            value ? Icons.grid_view_rounded : Icons.list,
                            size: Responsive.isMobile(context) ? 20.w : 5.w,
                          ),
                        );
                      }),
                ),
              ),
            ],
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Responsive.isMobile(context) ? 1.sw : 0.4.sw,
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Card(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ListTile(
                    title: Container(
                      height: Responsive.isMobile(context) ? null : 50,
                      child: TextField(
                        controller: context.read<SearchScreenViewModel>().searchController,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          hintText: 'Search account',
                          hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14, color: Theme.of(context).primaryColor.withOpacity(0.2)),
                          border: InputBorder.none,
                        ),
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
                        width: Responsive.isMobile(context) ? null : 0.5.sw,
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

                return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SizedBox(height: 10.h * 2),
                  Container(
                    width: Responsive.isMobile(context) ? null : 0.7.sw,
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
        AccountsWidget(key: Key('accounts_widget'), kItemsPaddingUnit: Responsive.isMobile(context) ? 20 : 5, kSpacingUnit: Responsive.isMobile(context) ? 10 : 2),
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
