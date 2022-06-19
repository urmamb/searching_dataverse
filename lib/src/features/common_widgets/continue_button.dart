import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ValueNotifier<bool>? loadingNotifier;
  final ValueNotifier<bool> _isEnabledNotifier;
  final EdgeInsets _padding;

  ContinueButton({Key? key, required this.text, required this.onPressed, this.loadingNotifier, ValueNotifier<bool>? isEnabledNotifier, EdgeInsets? padding})
      : _isEnabledNotifier = isEnabledNotifier ?? ValueNotifier(true),
        _padding = padding ?? EdgeInsets.zero,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingNotifier == null) {
      return Container(
        height: 48.h,
        padding: _padding,
        child: ElevatedButton(
          child: Text(
            text,
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
        ),
      );
    }

    return Container(
      padding: _padding,
      child: ValueListenableBuilder<bool>(
          valueListenable: _isEnabledNotifier,
          builder: (context, isEnabled, child) {
            return ValueListenableBuilder<bool>(
                valueListenable: loadingNotifier!,
                builder: (context, isLoading, child) {
                  return ElevatedButton(
                    child: (isLoading)
                        ? CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).scaffoldBackgroundColor))
                        : Text(
                            text,
                          ),
                    onPressed: shouldButtonBeEnabled(isEnabled, isLoading) ? onPressed : () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                  );
                });
          }),
    );
  }

  bool shouldButtonBeEnabled(bool isEnabled, bool isLoading) => isEnabled && !isLoading;
}
