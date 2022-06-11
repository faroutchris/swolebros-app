import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/models/workout.dart';
import 'package:swole_app/providers/firestore_services_provider.dart';
import 'package:swole_app/services/workout_service.dart';
import 'package:swole_app/widgets/future_builder_switch.dart';

class AddWorkoutScreen extends ConsumerWidget {
  const AddWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WorkoutService workoutService = ref.read(workoutServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<List<Workout>?>(
                future: workoutService.getAll(),
                builder: (context, snapshot) {
                  return FutureBuilderSwitch(
                    snapshot: snapshot,
                    data: WorkoutList(snapshot: snapshot),
                    loading: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    noData: const Center(
                      child: Icon(
                        CupertinoIcons.wifi_slash,
                        size: 64.0,
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                    error: const Center(
                      child: Icon(
                        CupertinoIcons.wifi_slash,
                        size: 64.0,
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<List<Workout>?> snapshot;

  @override
  Widget build(BuildContext context) {
    var data = snapshot.data;
    return Column(
      children: List.from(
        data!.map(
          (s) => Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          WorkoutIconHelper.mapFrom(s.type ?? ""),
                          style: const TextStyle(fontSize: 24),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(s.type ?? ""),
                        ),
                      ],
                    ),
                    Text(s.time.toString() + " min"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
