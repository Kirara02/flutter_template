import 'package:flutter/material.dart';

extension WidgetSpacingExt on num {
  /// Vertical spacing
  SizedBox get vSpace => SizedBox(height: toDouble());

  /// Horizontal spacing
  SizedBox get hSpace => SizedBox(width: toDouble());
}

extension WidgetExt on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);
  Widget paddingSymmetric({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );
  Widget paddingOnly({
    double l = 0,
    double t = 0,
    double r = 0,
    double b = 0,
  }) => Padding(
    padding: EdgeInsets.only(left: l, top: t, right: r, bottom: b),
    child: this,
  );

  Widget get center => Center(child: this);
  Widget get expanded => Expanded(child: this);
  Widget onTap(VoidCallback? onTap) =>
      GestureDetector(onTap: onTap, child: this);
}
