import 'package:flutter/material.dart';

import 'color_resource.dart';

extension GradientExtension on Widget {
  LinearGradient getLinearGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      colors: [
        ColorResource.colorFFA553,
        ColorResource.colorEE8C34,
        ColorResource.colorEA5434,
      ],
    );
  }
}
