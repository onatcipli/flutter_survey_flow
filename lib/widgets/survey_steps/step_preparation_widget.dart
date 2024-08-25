import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../flutter_survey_flow.dart';

class StepPreparationWidget extends StatelessWidget {
  final SurveyStep<dynamic> step;

  const StepPreparationWidget({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    final step = surveyProvider.currentStep;
    final options = step.options;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            "We're setting everything up for you",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        if (options != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  for (var option in options)
                    TypewriterAnimatedText(
                      option.title,
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      speed: const Duration(milliseconds: 200),
                    ),
                ],
                isRepeatingAnimation: true,
                totalRepeatCount: 20,
              ),
            ),
          ),
        // const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
