import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/models/team.dart';
import 'package:swole_app/providers/firestore_services_provider.dart';
import 'package:swole_app/services/account_service.dart';
import 'package:swole_app/services/teams_service.dart';
import 'package:swole_app/widgets/future_builder_switch.dart';

import '../../models/account.dart';

class JoinTeamScreen extends ConsumerWidget {
  const JoinTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TeamsService teamsService = ref.read(teamsServiceProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<Team>>(
            future: teamsService.getAll(),
            builder: (context, snapshot) {
              return FutureBuilderSwitch(
                snapshot: snapshot,
                loading: const Center(
                  child: CircularProgressIndicator(),
                ),
                data: TeamList(list: snapshot.data),
                error: const Text("Error"),
                noData: const Text("No teams"),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TeamList extends ConsumerWidget {
  final List<Team>? list;

  const TeamList({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AccountService accountService = ref.read(accountServiceProvider);

    if (list != null) {
      return ListView(
        children: list!.map(
          (team) {
            return Column(
              children: [
                Text(team.name ?? ""),
                ...team.members!
                    .map(
                      (member) => FutureBuilder<DocumentSnapshot<Account?>>(
                        future: accountService.getById(member.account?.id),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            return Text(
                                snapshot.data?.data()?.isOnboarded.toString() ??
                                    "");
                          }
                          return Container();
                        }),
                      ),
                    )
                    .toList()
              ],
            );
          },
        ).toList(),
      );
    }
    return Text("YO");
  }
}
