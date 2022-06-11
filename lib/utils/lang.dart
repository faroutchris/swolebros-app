import 'package:flutter/foundation.dart';

class Lang<T> {
  final Map<T, String> _map;

  Lang(this._map);

  String mapFrom(T key, [List<String>? inputs]) {
    var string = _map[key];
    var pattern = RegExp(r'\{\{(.*?)\}\}');

    if (string == null) {
      return "LangKey: {$key} not found";
    }

    void stringReplacer(input) {
      string = string!.replaceFirst(pattern, input);
    }

    if (inputs != null) {
      inputs.forEach(stringReplacer);
    }

    if (kDebugMode) {
      var unsatisfied = pattern.stringMatch(string!) != null;
      if (unsatisfied) {
        print(
            "This LangKey doesn't satisfy all placeholder values: \"$string\"");
      }
    }

    return string!;
  }
}
