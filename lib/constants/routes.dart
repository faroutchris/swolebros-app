enum AppRoute { root, addWorkout, joinTeam }

extension AppRouteExtension on AppRoute {
  static const Map<AppRoute, String> values = {
    AppRoute.root: "/",
    AppRoute.addWorkout: "/add-workout",
    AppRoute.joinTeam: "join-team",
  };

  String get value => values[this]!;
}
