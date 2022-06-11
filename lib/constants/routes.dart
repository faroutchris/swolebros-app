enum AppRoute { root, addWorkout }

extension AppRouteExtension on AppRoute {
  static const Map<AppRoute, String> values = {
    AppRoute.root: "/",
    AppRoute.addWorkout: "/add-workout"
  };

  String get value => values[this]!;
}
