import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/models/workout.dart';
import 'package:swole_app/providers/firestore_services_provider.dart';
import 'package:swole_app/services/workout_service.dart';

class AddWorkoutScreen extends ConsumerWidget {
  const AddWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WorkoutService workoutService = ref.read(workoutServiceProvider);

    void onPressed() {
      workoutService.create();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<QuerySnapshot<Workout>>(
                builder: ((context, snapshot) {
                  // loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // no data
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData == false &&
                      snapshot.hasError == false) {
                    return const Center(
                        child: Icon(
                      CupertinoIcons.nosign,
                      size: 64.0,
                      color: CupertinoColors.destructiveRed,
                    ));
                  }

                  // data
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData == true) {
                    return WorkoutList(snapshot: snapshot);
                  }

                  // error
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasError == true) {
                    return const Center(
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        size: 64.0,
                        color: CupertinoColors.destructiveRed,
                      ),
                    );
                  }
                }),
                stream: workoutService.$userWorkouts,
              ),
              CupertinoButton(child: const Text("Add"), onPressed: onPressed)
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

  final AsyncSnapshot<QuerySnapshot<Workout>?> snapshot;

  @override
  Widget build(BuildContext context) {
    var data = snapshot.data;

    if (data != null && data.size == 0) {
      return const Center(
        child: Text("No data"),
      );
    }

    return Expanded(
      child: ListView(
        children: List.from(
          data!.docs.map(
            (workout) => Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          workout
                                  .data()
                                  .dateCreated
                                  ?.toDate()
                                  .toLocal()
                                  .toString() ??
                              "",
                          style: ThemeData.light().textTheme.caption),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                WorkoutIconHelper.mapFrom(
                                    workout.data().type ?? ""),
                                style: const TextStyle(fontSize: 32),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  workout.data().type ?? "",
                                ),
                              ),
                            ],
                          ),
                          Text(
                            workout.data().time.toString() + " min",
                            style: ThemeData.light().textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
