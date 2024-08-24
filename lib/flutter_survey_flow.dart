library flutter_survey_flow;

import 'package:flutter/material.dart';

import 'models/survey_step.dart';
import 'providers/survey_provider.dart';

export 'enums/survey_step_type.dart';
export 'models/survey_step.dart';
export 'models/survey_option.dart';
export 'providers/survey_provider.dart';
export 'widgets/survey_scaffold.dart';
export 'widgets/survey_step_builder.dart';

class FlutterSurveyFlow {
  /// Starts the survey by pushing the SurveyScaffold page onto the navigation stack.
  ///
  /// Parameters:
  /// * context: The BuildContext to use for navigation.
  /// * steps: The list of SurveyStep objects to be used in the survey.
  static SurveyProvider startSurvey({
    required BuildContext context,
    required List<SurveyStep> steps,
  }) {
    final surveyProvider = SurveyProvider(
      steps: steps,
      context: context,
    );
    surveyProvider.startSurvey();
    return surveyProvider;
  }
}
