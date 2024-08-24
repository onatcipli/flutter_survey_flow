import 'package:flutter/material.dart';
import 'package:flutter_survey_flow/providers/survey_provider.dart';
import 'package:flutter_survey_flow/widgets/survey_header.dart';
import 'package:flutter_survey_flow/widgets/survey_step_builder.dart';
import 'package:provider/provider.dart';

class SurveyScaffold extends StatelessWidget {
  const SurveyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: SurveyHeader(),
            ),
            const Expanded(
              child: SurveyStepBuilder(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: FilledButton(
                onPressed: surveyProvider.isCurrentStepRequired
                    ? (surveyProvider.isCurrentStepAnswered
                        ? () {
                            surveyProvider.nextStep();
                          }
                        : null)
                    : () {
                        surveyProvider.nextStep();
                      },
                child: Text(
                  surveyProvider.isLastStep ? "Let's get started" : 'Next',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
