import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// StepDatePickerWidget serves as a widget to display a date picker question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class StepDatePickerWidget extends StatelessWidget {
  final SurveyStep<DateTime> step;

  const StepDatePickerWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    DateTime selectedDate = step.answer ?? DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                  surveyProvider.updateAnswer(step.id, selectedDate);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
