import 'package:flutter/material.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';
import 'package:provider/provider.dart';

/// StepNotificationWidget serves as a widget to display a notification step in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class StepNotificationWidget extends StatelessWidget {
  final SurveyStep step;

  const StepNotificationWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    bool isSelected = step.answer ?? true;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.notifications_active,
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 20),
          Center(
            child: SwitchListTile(
              title: Text(
                "Turn on notifications",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                "Wavemix would like to send you notifications to help you sleep better.",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              value: isSelected,
              onChanged: (bool newValue) {
                isSelected = newValue;
                surveyProvider.updateAnswer(step.id, isSelected);
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "You can turn off any of the reminders in the settings anytime. We won't bother you too much.",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
