import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_survey_flow/enums/survey_step_type.dart';
import 'package:flutter_survey_flow/models/survey_step.dart';
import 'package:flutter_survey_flow/providers/survey_provider.dart';
import 'package:flutter_survey_flow/widgets/survey_steps/step_yes_no_widget.dart';
import 'package:provider/provider.dart';

import '../models/survey_option.dart';
import 'survey_steps/step_multiple_choice_multi_select_widget.dart';
import 'survey_steps/step_multiple_choice_single_select_widget.dart';
import 'survey_steps/step_date_picker_widget.dart';
import 'survey_steps/step_notification_widget.dart';
import 'survey_steps/step_preparation_widget.dart';
import 'survey_steps/step_rating_widget.dart';
import 'survey_steps/step_slider_widget.dart';
import 'survey_steps/step_time_picker_widget.dart';
import 'survey_steps/step_toggle_switch_widget.dart';

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
                    return StepMultipleChoiceSingleSelectWidget(step: step);
                  case SurveyStepType.multipleChoiceMultiSelect:
                    if (step is SurveyStep<List<SurveyOption>>) {
                      return StepMultipleChoiceMultiSelectWidget(
                        step: step as SurveyStep<List<SurveyOption>>,
                      );
                    }
                  case SurveyStepType.yesNo:
                    return StepYesNoWidget(step: step);
                  case SurveyStepType.datePicker:
                    if (step is SurveyStep<DateTime>) {
                      return StepDatePickerWidget(
                          step: step as SurveyStep<DateTime>);
                    }
                  case SurveyStepType.timePicker:
                    if (step is SurveyStep<TimeOfDay>) {
                      return StepTimePickerWidget(
                          step: step as SurveyStep<TimeOfDay>);
                    }
                  case SurveyStepType.slider:
                    if (step is SurveyStep<double>) {
                      return StepSliderWidget(step: step as SurveyStep<double>);
                    }
                  case SurveyStepType.toggleSwitch:
                    if (step is SurveyStep<bool>) {
                      return StepToggleSwitchWidget(
                        step: step as SurveyStep<bool>,
                      );
                    }
                  case SurveyStepType.rating:
                    if (step is SurveyStep<int>) {
                      return StepRatingWidget(
                        step: step as SurveyStep<int>,
                      );
                    }
                  case SurveyStepType.notification:
                    if (step is SurveyStep<bool>) {
                      return StepNotificationWidget(
                        step: step,
                      );
                    }
                  case SurveyStepType.preparation:
                    return StepPreparationWidget(
                      step: step,
                    );
                  case SurveyStepType.successScreen:
                  // TODO: Handle this case.
                  case SurveyStepType.custom:
                  // TODO: Handle this case.
                  default:
                    return Container();
                }
                return Container();
              },
            ),
          ),
        ]
            .animate(interval: 100.milliseconds) // Staggered start
            .fadeIn(
              duration: 500.milliseconds,
              curve: Curves.easeInOut,
            )
            .slideY(
              duration: 500.milliseconds,
              curve: Curves.easeInOut,
              begin: 0.2,
              end: 0.0,
            )
            .scale(
              duration: 500.milliseconds,
              curve: Curves.easeInOut,
              begin: const Offset(0.95, 0.95),
              end: const Offset(1.0, 1.0),
            ),
      ),
    );
  }
}
