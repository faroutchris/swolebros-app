import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/constants/routes.dart';
import 'package:swole_app/flavor_config.dart';
import 'package:swole_app/providers/auth_service_provider.dart';
import 'package:swole_app/providers/firestore_services_provider.dart';
import 'package:swole_app/screens/home/account_settings_button.dart';
import 'package:swole_app/screens/home/home_controller.dart';
import 'package:swole_app/services/account_settings_service.dart';
import 'package:swole_app/services/auth_service.dart';
import 'package:swole_app/screens/home/home_lang.dart';
import 'package:swole_app/utils/lang.dart';

import '../../custom_exception.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void addWorkout(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoute.addWorkout.value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Lang<HomeScreenLangKeys> lang = ref.read(homeScreenLangProvider);

    AuthService authService = ref.read(authServiceProvider);
    AccountSettingsService accountSettingsService =
        ref.read(accountSettingsServiceProvider);

    HomeController homeController = ref.read(homeControllerProvider.notifier);
    AsyncValue<HomeState> state = ref.watch(homeControllerProvider);

    useEffect(() {
      accountSettingsService.initializeAccountSettings();

      return null;
    }, [authService.user]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            initialData: authService.user,
            stream: authService.userStream,
            builder: (context, snapshot) {
              if ((state.value?.isSigningIn ?? false) ||
                  (state.value?.isSigningOut ?? false)) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text(lang.mapFrom(HomeScreenLangKeys.loginError)),
                    ),
                  );
                });
                return const Center(
                  child: Icon(
                    CupertinoIcons.wifi_slash,
                    size: 64.0,
                    color: CupertinoColors.destructiveRed,
                  ),
                );
              }

              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(Flavor.name),
                    const Spacer(),
                    CupertinoButton(
                        color: CupertinoColors.black,
                        child:
                            Text(lang.mapFrom(HomeScreenLangKeys.addWorkout)),
                        onPressed: () => addWorkout(context)),
                    const Spacer(),
                    CupertinoButton(
                        color: CupertinoColors.black,
                        child: Text(lang.mapFrom(HomeScreenLangKeys.signOut)),
                        onPressed: () => homeController.signOut(context)),
                    const Spacer(),
                    AccountSettingsButton(
                      accountSettingsService: accountSettingsService,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => FirebaseCrashlytics.instance.recordError(
                          const CustomException(message: "Custom error"),
                          StackTrace.empty),
                      child: const Text("Throw Test Exception"),
                    ),
                  ],
                );
              } else {
                // Sign in page / onboarding
                return Center(
                  child: CupertinoButton(
                      color: CupertinoColors.black,
                      child: Text(lang.mapFrom(HomeScreenLangKeys.signIn)),
                      onPressed: () => homeController.signIn(context)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
