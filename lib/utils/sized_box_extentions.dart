import 'package:flutter/material.dart';

extension SizeBoxExtension on num {
  // Creates a SizedBox with fixed width
  SizedBox get width => SizedBox(width: toDouble());

  // Creates a SizedBox with fixed height
  SizedBox get height => SizedBox(height: toDouble());

  // Creates a SizedBox with both width and height
  SizedBox get size => SizedBox(width: toDouble(), height: toDouble());
}
