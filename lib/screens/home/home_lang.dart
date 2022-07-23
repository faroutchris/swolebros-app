import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/utils/lang.dart';

enum HomeScreenLangKeys {
  joinTeam,
  addWorkout,
  loginError,
  signIn,
  signOut,
  signOutSnack,
  isOnboarded,
  isNotOnboarded,
}

var homeScreenLang = {
  HomeScreenLangKeys.joinTeam: "Join team",
  HomeScreenLangKeys.addWorkout: "Add workout 💪",
  HomeScreenLangKeys.loginError:
      "We had trouble signing you in.\nTry again later or contact support.",
  HomeScreenLangKeys.signIn: "Sign in",
  HomeScreenLangKeys.signOut: "Sign out",
  HomeScreenLangKeys.signOutSnack: "You've signed out of your account",
  HomeScreenLangKeys.isOnboarded: "Is Onboarded",
  HomeScreenLangKeys.isNotOnboarded: "Not Onboarded",
};

final homeScreenLangProvider = Provider((_) => Lang(homeScreenLang));
