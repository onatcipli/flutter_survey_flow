import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// MultipleChoiceSingleSelectWidget serves as a widget to display a multiple choice
/// single select question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class MultipleChoiceSingleSelectWidget extends StatelessWidget {
  final SurveyStep step;

  const MultipleChoiceSingleSelectWidget({
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
        ...?step.options?.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedOption,
            onChanged: (value) {
              surveyProvider.updateAnswer(step.id, value);
            },
          );
        }).toList(),
      ],
    );
  }
}
