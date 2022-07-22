import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/models/account_settings.dart';
import 'package:swole_app/screens/home/home_lang.dart';
import 'package:swole_app/services/account_settings_service.dart';
import 'package:swole_app/services/teams_service.dart';
import 'package:swole_app/utils/lang.dart';

class AccountSettingsButton extends ConsumerWidget {
  const AccountSettingsButton({
    Key? key,
    required this.accountSettingsService,
    required this.teamsService,
  }) : super(key: key);

  final AccountSettingsService accountSettingsService;
  final TeamsService teamsService;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Lang<HomeScreenLangKeys> lang = ref.read(homeScreenLangProvider);

    return StreamBuilder<AccountSettings?>(
        stream: accountSettingsService.$accountSettings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            var id = snapshot.data?.team?.id;
            if (id != null) {
              var test = teamsService
                  .getById(id)
                  .then((value) => print(value.data()?.memberships.toString()));
            }
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
