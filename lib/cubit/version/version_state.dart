part of 'version_cubit.dart';

@immutable
sealed class VersionState {}

final class VersionInitial extends VersionState {}

final class VersionLoading extends VersionState {}

final class VersionCheck extends VersionState {
  final bool newversion;
  final String currentversion;

  VersionCheck(this.newversion, this.currentversion);
}

final class VersionAppLists extends VersionState {
  final List<PbfVersionModel> apps;

  VersionAppLists(this.apps);
}

final class VersionError extends VersionState {
  final String error;
  final String detail;

  VersionError(this.error, this.detail);
}
