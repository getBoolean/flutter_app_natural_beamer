import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppThemeState extends StateNotifier<bool> {
  AppThemeState(): super(false);

  void setLightTheme() => state = false;
  void setDarkTheme() => state = true;
}

// Theme
final appThemeStateNotifier = StateNotifierProvider<AppThemeState, bool>((ref) => AppThemeState());