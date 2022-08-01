import 'config.dart';

// Extensions to easily reach the size configuration class
extension SizeExtension on num {
  double get height => SizeConfig.height(this.toDouble());

  double get width => SizeConfig.width(this.toDouble());

  num get text => SizeConfig.textSize(this.toDouble());
}
