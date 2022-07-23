import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/models/account.dart';
import 'package:swole_app/screens/home/home_lang.dart';
import 'package:swole_app/services/account_service.dart';
import 'package:swole_app/services/teams_service.dart';
import 'package:swole_app/utils/lang.dart';

class AccountSettingsButton extends ConsumerWidget {
  const AccountSettingsButton({
    Key? key,
    required this.accountSettingsService,
    required this.teamsService,
  }) : super(key: key);

  final AccountService accountSettingsService;
  final TeamsService teamsService;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Lang<HomeScreenLangKeys> lang = ref.read(homeScreenLangProvider);

    return StreamBuilder<Account?>(
        stream: accountSettingsService.$account,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return CupertinoButton(
                color: CupertinoColors.black,
                child: Text(lang.mapFrom((snapshot.data)?.isOnboarded == true
                    ? HomeScreenLangKeys.isOnboarded
                    : HomeScreenLangKeys.isNotOnboarded)),
                onPressed: () => accountSettingsService.toggleOnboarding());
          } else {
            return const Text("No data");
          }
        });
  }
}
