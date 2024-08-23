import 'package:flutter/material.dart';
import 'package:flutter_survey_flow/widgets/survey_step_widget.dart';
import 'package:provider/provider.dart';

import '../providers/survey_provider.dart';

class SurveyStepBuilder extends StatelessWidget {
  const SurveyStepBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    return PageView.builder(
      controller: surveyProvider.stepPageController,
      itemBuilder: (BuildContext context, int index) {
        return SurveyStepWidget(step: surveyProvider.steps[index]);
      },
    );
  }
}
