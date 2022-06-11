import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/custom_exception.dart';
import 'package:swole_app/providers/auth_service_provider.dart';
import 'package:swole_app/services/auth_service.dart';
import 'package:swole_app/widgets/btn.dart';
import 'package:swole_app/widgets/onboarding/layered_illustration.dart';

class PageViewController extends StateNotifier<double> {
  PageController scrollController = PageController();

  PageViewController() : super(0) {
    scrollController.addListener(() {
      state = scrollController.offset;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

final pageViewControllerProvider =
    StateNotifierProvider<PageViewController, double>(
        (_) => PageViewController());

class Onboarding extends HookConsumerWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageViewController pageView = ref.read(pageViewControllerProvider.notifier);

    void handleSlide(int slide) {
      pageView.scrollController.animateToPage(slide,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuad);
    }

    return Stack(
      children: [
        PageView(
          controller: pageView.scrollController,
          physics: const BouncingScrollPhysics(),
          children: [
            SlideOne(handleSlide: () => handleSlide(1)),
            SlideTwo(handleSlide: () => handleSlide(0)),
          ],
        ),
        IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: LayeredIllustration(
              index: 0,
              children: [
                LayeredIllustrationImage(
                  image: Image.asset(
                    'assets/arm-slice2.png',
                    height: 300,
                  ),
                  top: 30,
                  left: 70,
                  offsetMultiple: 2.5,
                ),
                LayeredIllustrationImage(
                  image: Image.asset(
                    'assets/arm-slice1.png',
                    height: 240,
                  ),
                  top: 30,
                  left: 70,
                  offsetMultiple: 1.75,
                ),
              ],
            ),
          ),
        ),
        IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: LayeredIllustration(
              index: 1,
              children: [
                LayeredIllustrationImage(
                  image: Image.asset(
                    'assets/arm-slice2.png',
                    height: 300,
                  ),
                  top: 30,
                  left: 70,
                  offsetMultiple: 2.5,
                ),
                LayeredIllustrationImage(
                  image: Image.asset(
                    'assets/arm-slice1.png',
                    height: 240,
                  ),
                  top: 30,
                  left: 70,
                  offsetMultiple: 1.75,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SlideOne extends StatelessWidget {
  const SlideOne({
    Key? key,
    required this.handleSlide,
  }) : super(key: key);

  final void Function() handleSlide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Text(
            "Looks like you're new!",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 60.0),
          child: Text(
            "Build a bro is an awesome way for your and your friends, family and co-workers to keep on top of your fitness goals",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Btn(label: "Next", onPressed: handleSlide),
        ),
      ],
    );
  }
}

class SlideTwo extends HookConsumerWidget {
  const SlideTwo({
    Key? key,
    required this.handleSlide,
  }) : super(key: key);

  final void Function() handleSlide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = useTextEditingController();
    AuthService _authService = ref.read(authServiceProvider);

    void handleNext() async {
      try {
        // await accountController.updateDisplayName(name: nameController.text);
        // // await accountController.isOnboarded(true);
        // await accountController.setIsOnboarded();
        _authService.signIn();
        handleSlide();
      } on CustomException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? "Something went wrong"),
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 15),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Text(
            "What should we call you?",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 20.0),
          child: Text(
            "You can change your name at any time in settings",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 60.0),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Type here",
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Btn(label: "Next", onPressed: handleNext),
        ),
      ],
    );
  }
}
