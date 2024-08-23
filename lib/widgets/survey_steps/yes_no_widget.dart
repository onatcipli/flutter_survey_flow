import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// YesNoWidget serves as a widget to display a yes/no question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class YesNoWidget extends StatelessWidget {
  final SurveyStep step;

  const YesNoWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    final selectedOption = step.answer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          title: const Text('Yes'),
          value: 'yes',
          groupValue: selectedOption,
          onChanged: (value) {
            surveyProvider.updateAnswer(step.id, value);
          },
        ),
        RadioListTile(
          title: const Text('No'),
          value: 'no',
          groupValue: selectedOption,
          onChanged: (value) {
            surveyProvider.updateAnswer(step.id, value);
          },
        ),
      ],
    );
  }
}
