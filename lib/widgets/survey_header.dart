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
        IconButton(
          onPressed: () {
            surveyProvider.previousStep();
          },
          icon: surveyProvider.isFirstStep
              ? const Icon(Icons.close)
              : const Icon(Icons.arrow_back_ios),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: surveyProvider.completionPercentage,
          ),
        ),
      ],
    );
  }
}
