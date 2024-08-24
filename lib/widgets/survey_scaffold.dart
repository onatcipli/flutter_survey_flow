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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SurveyHeader(),
              const Expanded(
                child: SurveyStepBuilder(),
              ),
              FilledButton(
                onPressed: () {
                  surveyProvider.nextStep();
                },
                child: Text(
                  surveyProvider.isLastStep ? "Let's get started" : 'Next',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
