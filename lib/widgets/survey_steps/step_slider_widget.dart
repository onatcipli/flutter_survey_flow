import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// StepSliderWidget serves as a widget to display a slider question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class StepSliderWidget extends StatelessWidget {
  final SurveyStep<double> step;

  const StepSliderWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    double selectedValue = step.answer ?? 30.0;

    return Center(
      child: Slider(
        value: selectedValue,
        min: 0.0,
        max: 100.0,
        divisions: 10,
        label: selectedValue.round().toString(),
        onChanged: (double newValue) {
          selectedValue = newValue;
          surveyProvider.updateAnswer(step.id, selectedValue);
        },
      ),
    );
  }
}
