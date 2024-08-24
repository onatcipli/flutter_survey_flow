import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// MultipleChoiceSingleSelectWidget serves as a widget to display a multiple choice
/// single select question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class StepMultipleChoiceSingleSelectWidget extends StatelessWidget {
  final SurveyStep step;

  const StepMultipleChoiceSingleSelectWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    final selectedOption = step.answer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...?step.options?.map((option) {
          final isSelected = selectedOption == option;
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
                textAlign: option.textAlign,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                    ),
              ),
              subtitle: option.description != null
                  ? Text(
                      option.description!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: textColor,
                          ),
                    )
                  : null,
              leading: option.icon != null
                  ? Icon(
                      option.icon,
                      color: textColor,
                    )
                  : null,
              selected: isSelected,
              onTap: () {
                surveyProvider.updateAnswer(step.id, option);
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}
