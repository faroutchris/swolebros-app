import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/providers/auth_service_provider.dart';
import 'package:swole_app/screens/home/home_lang.dart';
import 'package:swole_app/services/auth_service.dart';
import 'package:swole_app/utils/lang.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, AsyncValue<HomeState>>(
  (ref) => HomeController(
      authService: ref.read(authServiceProvider),
      lang: ref.read(homeScreenLangProvider)),
);

class HomeState {
  bool isSigningIn;
  bool isSigningOut;
  HomeState({
    this.isSigningIn = false,
    this.isSigningOut = false,
  });

  HomeState copyWith({bool? isSigningIn, bool? isSigningOut}) {
    return HomeState(
      isSigningIn: isSigningIn ?? this.isSigningIn,
      isSigningOut: isSigningOut ?? this.isSigningOut,
    );
  }
}

class HomeController extends StateNotifier<AsyncValue<HomeState>> {
  AuthService authService;
  Lang<HomeScreenLangKeys> lang;

  HomeController({required this.authService, required this.lang})
      : super(AsyncValue.data(HomeState()));

  void signOut(BuildContext context) async {
    state = AsyncData(HomeState(isSigningOut: true));

    await authService.signOut().then((_) {
      state = AsyncData(HomeState());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang.mapFrom(HomeScreenLangKeys.signOutSnack)),
        ),
      );
    });
  }

  void signIn() async {
    state = AsyncData(HomeState(isSigningIn: true));

    await authService.signIn().then((_) {
      state = AsyncData(HomeState());
    });
  }
}
