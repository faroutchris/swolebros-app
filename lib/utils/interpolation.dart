enum Extrapolation { identity, clamp, extend }

double _getVal(
    {required Extrapolation extrapolation,
    required int coef,
    required double val,
    required double leftEdgeOutput,
    required double rightEdgeOutput,
    required double x}) {
  switch (extrapolation) {
    case Extrapolation.identity:
      return x;
    case Extrapolation.clamp:
      if (coef * val < coef * leftEdgeOutput) {
        return leftEdgeOutput;
      }
      return rightEdgeOutput;
    case Extrapolation.extend:
      return val;
  }
}

double interpolate(double x,
    {required List<double> input,
    required List<double> output,
    Extrapolation extrapolation = Extrapolation.identity}) {
  //
  int length = input.length;

  double leftEdgeInput = input[0];
  double rightEdgeInput = input[1];
  double leftEdgeOutput = output[0];
  double rightEdgeOutput = output[1];

  if (length > 2) {
    if (x > input[length - 1]) {
      //
      leftEdgeInput = input[length - 2];
      rightEdgeInput = input[length - 1];
      leftEdgeOutput = output[length - 2];
      rightEdgeOutput = output[length - 1];
    } else {
      for (var i = 1; i < length; ++i) {
        if (x <= input[i]) {
          leftEdgeInput = input[i - 1];
          rightEdgeInput = input[i];
          leftEdgeOutput = output[i - 1];
          rightEdgeOutput = output[i];
          break;
        }
      }
    }
  }

  if (rightEdgeOutput - leftEdgeOutput == 0) {
    return leftEdgeOutput;
  }

  double progress = (x - leftEdgeInput) / (rightEdgeInput - leftEdgeInput);
  double val = leftEdgeOutput + progress * (rightEdgeOutput - leftEdgeOutput);
  int coef = rightEdgeOutput >= leftEdgeOutput ? 1 : -1;

  if (coef * val < coef * leftEdgeOutput) {
    return _getVal(
        extrapolation: extrapolation,
        coef: coef,
        val: val,
        leftEdgeOutput: leftEdgeOutput,
        rightEdgeOutput: rightEdgeOutput,
        x: x);
  } else if (coef * val > coef * rightEdgeOutput) {
    return _getVal(
        extrapolation: extrapolation,
        coef: coef,
        val: val,
        leftEdgeOutput: leftEdgeOutput,
        rightEdgeOutput: rightEdgeOutput,
        x: x);
  }

  return val;
}
