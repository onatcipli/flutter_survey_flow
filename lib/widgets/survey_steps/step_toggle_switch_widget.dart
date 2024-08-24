import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// StepToggleSwitchWidget serves as a widget to display a toggle switch question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class StepToggleSwitchWidget extends StatelessWidget {
  final SurveyStep<bool> step;

  const StepToggleSwitchWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    bool isSelected = step.answer ?? false;

    return Center(
      child: SwitchListTile(
        title: Text(
          step.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: step.description != null
            ? Text(
                step.description!,
                style: Theme.of(context).textTheme.bodySmall,
              )
            : null,
        value: isSelected,
        onChanged: (bool newValue) {
          isSelected = newValue;
          surveyProvider.updateAnswer(step.id, isSelected);
        },
      ),
    );
  }
}
