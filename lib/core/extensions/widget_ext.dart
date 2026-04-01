import 'package:flutter/material.dart';

extension WidgetSpacingExt on num {
  /// Vertical spacing: [SizedBox] with given height.
  SizedBox get vSpace => SizedBox(height: toDouble());

  /// Horizontal spacing: [SizedBox] with given width.
  SizedBox get hSpace => SizedBox(width: toDouble());
}

extension WidgetExt on Widget {
  /// Wraps the widget in [Padding] with [value] on all sides.
  Widget padAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Wraps the widget in [Padding] with [horizontal] and [vertical] values.
  Widget padSymmetric({double horizontal = 0, double vertical = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
    child: this,
  );

  /// Wraps the widget in [Padding] with individual [left, top, right, bottom] values.
  Widget padOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  /// Wraps the widget in a [Center] widget.
  Widget get center => Center(child: this);

  /// Wraps the widget in an [Expanded] widget with given [flex].
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Wraps the widget in a [SizedBox] to take up [double.infinity] width.
  Widget get fullWidth => SizedBox(width: double.infinity, child: this);

  /// Wraps the widget in [Opacity] with given [opacity].
  Widget withOpacity(double opacity) => Opacity(opacity: opacity, child: this);

  /// Wraps the widget in a [Visibility] widget toggled by [isVisible].
  Widget visible(bool isVisible) => Visibility(visible: isVisible, child: this);

  /// Wraps the widget in a [SliverToBoxAdapter] for use in [CustomScrollView].
  Widget get sliver => SliverToBoxAdapter(child: this);

  /// Wraps the widget in a [GestureDetector] with given [onTap] callback.
  Widget onTap(VoidCallback? onTap) =>
      GestureDetector(onTap: onTap, child: this);
}
