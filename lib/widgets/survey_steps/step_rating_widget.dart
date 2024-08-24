import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/survey_step.dart';
import '../../providers/survey_provider.dart';

/// StepRatingWidget serves as a widget to display a rating question in the survey.
///
/// Attributes:
/// * step: Used for holding the current survey step data.
class StepRatingWidget extends StatelessWidget {
  final SurveyStep<int> step;

  const StepRatingWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    int selectedRating = step.answer ?? 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final ratingValue = index + 1;
              return IconButton(
                icon: Icon(
                  Icons.star,
                  color: selectedRating >= ratingValue
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.3),
                ),
                onPressed: () {
                  surveyProvider.updateAnswer(step.id, ratingValue);
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
