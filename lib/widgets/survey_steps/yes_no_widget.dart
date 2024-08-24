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
    final options = step.options;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: options!.map((option) {
        final isSelected = selectedOption == option.id;
        final backgroundColor = isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(.8)
            : Theme.of(context).colorScheme.onBackground.withOpacity(.08);
        final textColor = isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onBackground;
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          color: backgroundColor,
          child: ListTile(
            title: Text(
              option.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textColor,
                  ),
            ),
            selected: isSelected,
            onTap: () {
              surveyProvider.updateAnswer(step.id, option.id);
            },
          ),
        );
      }).toList(),
    );
  }
}