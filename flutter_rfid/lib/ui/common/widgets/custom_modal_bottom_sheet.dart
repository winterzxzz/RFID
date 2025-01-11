import 'package:flutter/material.dart';

void showCustomModalBottomSheet(BuildContext context, Widget child,
    {bool isScrollControlled = true, bool useRootNavigator = true}) {
  showModalBottomSheet(
      context: context,
      showDragHandle: true,
      useRootNavigator: useRootNavigator,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      isScrollControlled: isScrollControlled, // Allows full control over height
      builder: (context) => child);
}
