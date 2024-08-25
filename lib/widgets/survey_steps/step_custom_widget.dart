import 'package:flutter/material.dart';
import '../../models/survey_step.dart';

class StepCustomWidget extends StatelessWidget {
  final SurveyStep step;

  const StepCustomWidget({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return step.customWidget?.call(context, step) ??
        const Text('No custom widget');
  }
}
