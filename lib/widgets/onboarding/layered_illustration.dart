import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/utils/interpolation.dart';
import 'package:swole_app/widgets/onboarding/onboarding.dart';

class LayeredIllustrationImage {
  const LayeredIllustrationImage(
      {this.top = 0,
      this.left = 0,
      required this.image,
      required this.offsetMultiple});

  final double left;
  final double top;
  final double offsetMultiple;
  final Image image;
}

class LayeredIllustration extends ConsumerWidget {
  final bool fadeOut;

  const LayeredIllustration(
      {Key? key,
      required this.index,
      required this.children,
      this.fadeOut = false})
      : super(key: key);

  final List<LayeredIllustrationImage> children;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double pageOffset = ref.watch(pageViewControllerProvider);
    double width = MediaQuery.of(context).size.width;
    double opacity = 1;

    if (fadeOut) {
      opacity = interpolate(pageOffset,
          input: [(index - 1) * width, index * width, (index + 1) * width],
          output: [0, 1, 0],
          extrapolation: Extrapolation.clamp);
    }

    return Opacity(
      opacity: opacity,
      child: Stack(
        children: children
            .map((child) => Positioned(
                  top: child.top,
                  left: child.left -
                      (child.offsetMultiple * (pageOffset - (width * index))),
                  child: child.image,
                ))
            .toList(),
      ),
    );
  }
}
