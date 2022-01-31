import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';

class Environment {
  final BuildConfig buildConfig;
  final BuildType buildType;

  static late Environment _environment;

  Environment._({
    required this.buildConfig,
    required this.buildType,
  });

  static void init(
    BuildConfig buildConfig,
    BuildType buildType,
  ) {
    _environment = Environment._(
      buildConfig: buildConfig,
      buildType: buildType,
    );
  }

  static Environment instance() => _environment;
}
