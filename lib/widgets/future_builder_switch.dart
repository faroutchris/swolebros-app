import 'package:flutter/material.dart';

/// To be used in FutureBuilder.builder.
/// Makes it a bit simpler to see which widget is rendered for different states

class FutureBuilderSwitch extends StatelessWidget {
  final Widget? data;

  final Widget? error;

  final Widget? loading;

  final Widget? noData;

  final AsyncSnapshot? snapshot;

  const FutureBuilderSwitch({
    Key? key,
    required this.snapshot,
    required this.data,
    required this.loading,
    required this.noData,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot != null &&
        snapshot?.connectionState == ConnectionState.done &&
        snapshot?.hasData == true) {
      return data!;
    } else if (snapshot != null &&
        snapshot?.connectionState == ConnectionState.done &&
        snapshot?.hasData == false) {
      return noData!;
    } else if (snapshot != null &&
        snapshot?.connectionState == ConnectionState.done &&
        snapshot?.hasError == true) {
      return error!;
    } else if (snapshot != null &&
        snapshot?.connectionState == ConnectionState.waiting) {
      return loading!;
    }
    return noData!;
  }
}
