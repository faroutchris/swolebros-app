import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/utils/lang.dart';

enum HomeScreenLangKeys {
  addWorkout,
  loginError,
  signIn,
  signOut,
  signOutSnack,
  isOnboarded,
  isNotOnboarded,
}

var homeScreenLang = {
  HomeScreenLangKeys.addWorkout: "Add workout 💪",
  HomeScreenLangKeys.loginError: "We had trouble signing in to your account",
  HomeScreenLangKeys.signIn: "Sign in",
  HomeScreenLangKeys.signOut: "Sign out",
  HomeScreenLangKeys.signOutSnack: "You've signed out of your account",
  HomeScreenLangKeys.isOnboarded: "Is Onboarded",
  HomeScreenLangKeys.isNotOnboarded: "Not Onboarded",
};

final homeScreenLangProvider = Provider((_) => Lang(homeScreenLang));
