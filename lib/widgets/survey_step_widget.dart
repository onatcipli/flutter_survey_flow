import 'package:flutter/material.dart';
import 'package:flutter_survey_flow/enums/survey_step_type.dart';
import 'package:flutter_survey_flow/models/survey_step.dart';
import 'package:flutter_survey_flow/providers/survey_provider.dart';
import 'package:flutter_survey_flow/widgets/survey_steps/yes_no_widget.dart';
import 'package:provider/provider.dart';

import '../models/survey_option.dart';
import 'survey_steps/multiple_choice_multi_select_widget.dart';
import 'survey_steps/multiple_choice_single_select_widget.dart';

class SurveyStepWidget extends StatelessWidget {
  final SurveyStep step;
  const SurveyStepWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    final currentStep = surveyProvider.currentStep;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              step.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (step.description != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                step.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          Expanded(
            child: Builder(
              builder: (context) {
                switch (currentStep.stepType) {
                  case SurveyStepType.multipleChoiceSingleSelect:
                    return MultipleChoiceSingleSelectWidget(step: step);
                  case SurveyStepType.multipleChoiceMultiSelect:
                    if (step is SurveyStep<List<SurveyOption>>) {
                      return MultipleChoiceMultiSelectWidget(
                        step: step as SurveyStep<List<SurveyOption>>,
                      );
                    }
                    return Container();
                  case SurveyStepType.yesNo:
                    return YesNoWidget(step: step);
                  case SurveyStepType.datePicker:
                  // TODO: Handle this case.
                  case SurveyStepType.timePicker:
                  // TODO: Handle this case.
                  case SurveyStepType.slider:
                  // TODO: Handle this case.
                  case SurveyStepType.toggleSwitch:
                  // TODO: Handle this case.
                  case SurveyStepType.rating:
                  // TODO: Handle this case.
                  case SurveyStepType.notification:
                  // TODO: Handle this case.
                  case SurveyStepType.successScreen:
                  // TODO: Handle this case.
                  case SurveyStepType.custom:
                  // TODO: Handle this case.
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
