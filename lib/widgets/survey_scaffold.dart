import 'package:flutter/material.dart';
import 'package:flutter_survey_flow/providers/survey_provider.dart';
import 'package:flutter_survey_flow/widgets/survey_header.dart';
import 'package:flutter_survey_flow/widgets/survey_step_builder.dart';
import 'package:provider/provider.dart';

class SurveyScaffold extends StatelessWidget {
  const SurveyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: SurveyHeader(),
            ),
            Expanded(
              child: SurveyStepBuilder(),
            ),
            SurveyFooter()
          ],
        ),
      ),
    );
  }
}

class SurveyFooter extends StatelessWidget {
  const SurveyFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 60,
        child: surveyProvider.isCurrentStepLoading
            ? const Center(child: CircularProgressIndicator())
            : FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
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
      ),
    );
  }
}
