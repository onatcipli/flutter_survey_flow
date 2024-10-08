import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/survey_provider.dart';

class SurveyHeader extends StatelessWidget {
  const SurveyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton.filled(
            onPressed: surveyProvider.isCurrentStepLoading
                ? null
                : () {
                    surveyProvider.previousStep();
                  },
            icon: surveyProvider.isFirstStep
                ? const Icon(Icons.close)
                : const Icon(Icons.arrow_back),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
            value: surveyProvider.completionPercentage,
          ),
        ),
      ],
    );
  }
}
