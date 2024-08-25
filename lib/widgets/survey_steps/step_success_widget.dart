import 'package:flutter/material.dart';

import '../../models/survey_step.dart';

class StepSuccessWidget extends StatelessWidget {
  final SurveyStep step;

  const StepSuccessWidget({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    // final surveyProvider = context.watch<SurveyProvider>();

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 100.0,
          ),
          SizedBox(height: 20.0),
          Text(
            'Success!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'The app is prepared for you. Enjoy your experience!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
