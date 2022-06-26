import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/src/features/common_widgets/continue_button.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/search_screen_view_model.dart';

class FilterAccountsBottomSheet {
  BuildContext context;

  SearchScreenViewModel get viewModel => sl();

  final GlobalKey<FormState> formKey = GlobalKey();

  FilterAccountsBottomSheet(this.context);

  Future<void> show() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(builder: (_, myState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.only(bottom: MediaQuery.of(_).viewInsets.bottom + 5.h, left: 16.w, right: 16.w),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: Theme.of(_).colorScheme.error,
                            size: 20.0.w,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Filter Accounts',
                          style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Flexible(
                      flex: 5,
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Filter by Account State',
                                  style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).textTheme.caption!.color!.withOpacity(0.2)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Active/Inactive)'),
                                    Switch(
                                      value: viewModel.isStateActive == 0 ? false : true,
                                      onChanged: (value) {
                                        myState(() {
                                          viewModel.isStateActive = value ? 1 : 0;
                                          print(viewModel.isStateActive);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Filter by State/Province',
                                  style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).textTheme.caption!.color!.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                          SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.5,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                var foundState = viewModel.selectedStatesList.value.where((e) => e.stateCode == viewModel.states[index].stateCode);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        myState(() {
                                          viewModel.onTapState(viewModel.states[index]);
                                        });
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.r),
                                        )),
                                        backgroundColor: foundState.isNotEmpty ? MaterialStateProperty.all(Theme.of(context).primaryColor) : MaterialStateProperty.all(Colors.black12),
                                        foregroundColor: MaterialStateProperty.all(Theme.of(context).textTheme.bodyText1!.color),
                                        elevation: MaterialStateProperty.all(0),
                                      ),
                                      child: Text(
                                        viewModel.states[index].stateName,
                                        style: TextStyle(color: foundState.isNotEmpty ? Theme.of(context).canvasColor : Theme.of(context).textTheme.headline6!.color),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              childCount: viewModel.states.length,
                            ),
                          ),
                          SliverPadding(
                            padding: EdgeInsets.only(bottom: 80.h),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            myState(() {
                              viewModel.selectedStatesList.value.clear();
                              viewModel.isStateActive = 0;
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            )),
                            backgroundColor: MaterialStateProperty.all(Colors.black12),
                            foregroundColor: MaterialStateProperty.all(Theme.of(context).textTheme.bodyText1!.color),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: const Text(
                            'Reset Filter',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          key: ValueKey('apply_button'),
                          onPressed: () async {
                            await viewModel.filterAccounts();
                            Navigator.of(context).pop();
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
                            'Apply Filter',
                            style: TextStyle(color: Theme.of(context).canvasColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
