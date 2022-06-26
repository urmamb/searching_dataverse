import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/logout_user.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/state_list.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';

class SearchScreenViewModel with ChangeNotifier {
  final AppState _appState;
  final GetAccounts _getAccounts;
  final LogOutUser _logOutUser;

  SearchScreenViewModel({
    required AppState appState,
    required GetAccounts getAccounts,
    required LogOutUser logOutUser,
  })  : _appState = appState,
        _getAccounts = getAccounts,
        _logOutUser = logOutUser;

  ValueChanged<String>? errorMessageNotifier;
  String _searchString = '';
  ValueNotifier<List<Account>> accountsOnDataversList = ValueNotifier([]);
  ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isListView = ValueNotifier(true);
  TextEditingController searchController = TextEditingController();
  int isStateActive = 0;
  var lastSearchQuery = '';
  ValueNotifier<List<UsState>> selectedStatesList = ValueNotifier([]);

  List<Account> get accountData => accountsOnDataversList.value;

  ValueNotifier<UnmodifiableListView<Account>> get accounts => ValueNotifier(_searchString.isEmpty && selectedStatesList.value.isEmpty
      ? UnmodifiableListView(accountData)
      : selectedStatesList.value.isEmpty
          ? UnmodifiableListView(
              accountData.where((account) => account.name.toLowerCase().contains(_searchString.toLowerCase()) || account.accountnumber.contains(_searchString.toLowerCase())).toList())
          : UnmodifiableListView(
              accountData.where((account) => selectedStatesList.value.any((state) => (state.stateCode == account.address1_stateorprovince && account.statecode == isStateActive))).toList()));

  List<UsState> get states => List.from(jsonDecode(allStates)).map((e) => UsState.fromJson(e)).toList();

  filterAccounts() {
    notifyListeners();
  }

  Future<void> init() async {
    loadingNotifier.value = true;
    accountsOnDataversList.value = [];
    searchController.clear();
    await fetchAccountsTable();
    loadingNotifier.value = false;
  }

  void changeSearchString() {
    _searchString = searchController.text;
    notifyListeners();
  }

  set accountData(List<Account> value) {
    accountsOnDataversList.value = value;
    notifyListeners();
  }

  Future<bool> fetchAccountsTable() async {
    var accountListEither = await _getAccounts(NoParams());

    if (accountListEither.isLeft()) {
      handleError(accountListEither);
      return false;
    }

    accountData = accountListEither.getOrElse(() => []);
    accountData = accountData.toSet().toList();

    loadingNotifier.value = false;
    return true;
  }

  void handleError(Either<Failure, dynamic> failureEither) {
    loadingNotifier.value = false;
    failureEither.fold((l) => errorMessageNotifier?.call(l.message), (r) => null);
  }

  void searchAccount() {
    if (searchController.text.isEmpty) {
      fetchAccountsTable();
      return;
    }
  }

  void onTapState(UsState state) {
    var foundState = selectedStatesList.value.where((e) => e.stateCode == state.stateCode);
    if (foundState.isEmpty) {
      selectedStatesList.value = [...selectedStatesList.value, state];
    } else if (foundState.isNotEmpty) {
      var oldList = selectedStatesList.value;
      oldList.removeWhere((item) => item.stateCode == state.stateCode);
      selectedStatesList.value = [...oldList];
    }
    notifyListeners();
  }

  void moveBack() {
    _appState.moveToBackScreen();
  }

  Future<void> logout() async {
    var logOutUserEither = await _logOutUser.call(NoParams());

    if (logOutUserEither.isLeft()) {
      handleError(logOutUserEither);
      return;
    }

    moveBack();
  }

  void switchView() {
    if (isListView.value) {
      isListView.value = false;
    } else {
      isListView.value = true;
    }
    notifyListeners();
  }
}
