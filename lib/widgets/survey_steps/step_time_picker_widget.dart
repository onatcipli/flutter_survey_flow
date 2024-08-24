import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// StepTimePickerWidget serves as a widget to display a time picker question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class StepTimePickerWidget extends StatelessWidget {
  final SurveyStep<TimeOfDay> step;

  const StepTimePickerWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    TimeOfDay selectedTime = step.answer ?? TimeOfDay.now().replacing(minute: 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                minuteInterval: 15,
                initialDateTime: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  selectedTime.hour,
                  selectedTime.minute,
                ),
                onDateTimeChanged: (DateTime newDateTime) {
                  selectedTime = TimeOfDay(
                    hour: newDateTime.hour,
                    minute: newDateTime.minute,
                  );
                  surveyProvider.updateAnswer(step.id, selectedTime);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
