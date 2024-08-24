import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_option.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// MultipleChoiceMultiSelectWidget serves as a widget to display a multiple choice
/// multi select question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class MultipleChoiceMultiSelectWidget extends StatelessWidget {
  final SurveyStep<List<SurveyOption>> step;

  const MultipleChoiceMultiSelectWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    List<SurveyOption> selectedOptions = step.answer ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...?step.options?.map((option) {
          final isSelected = selectedOptions.any((opt) => opt.id == option.id);
          final backgroundColor = isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(.8)
              : Theme.of(context).colorScheme.onBackground.withOpacity(.08);
          final textColor = isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onBackground;
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              color: backgroundColor,
              child: ListTile(
                trailing: isSelected
                    ? Icon(
                        Icons.check_box,
                        color: textColor,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: textColor,
                      ),
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
                  if (isSelected) {
                    selectedOptions.removeWhere((opt) => opt.id == option.id);
                  } else {
                    selectedOptions.add(option);
                  }
                  surveyProvider.updateAnswer(step.id, selectedOptions);
                },
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}