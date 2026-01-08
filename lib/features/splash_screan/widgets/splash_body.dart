import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sim_management_task/core/utils/app_animations.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key, required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        SizedBox(
          height: MediaQuery.of(context).size.width,
          child: LottieBuilder.asset(
            AppAnimations.splashAnimationDuration,
            fit: BoxFit.fill,
          ),
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInCirc,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.welcome,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 50,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
