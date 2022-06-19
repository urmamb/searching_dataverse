import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../app_state.dart';
import '../ui_pages.dart';

/// This wraps several items that allow the router to handle a page action.
class PageAction extends Equatable {
  final PageState state;
  final PageConfiguration? page;
  final Widget? widget;
  final Map<String, dynamic>? arguments;

  PageAction(
      {this.state = PageState.none, this.page, this.widget, this.arguments});

  @override
  List<Object?> get props => [state, page, widget, arguments];
}
