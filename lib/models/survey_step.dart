import '../enums/survey_step_type.dart';

import 'survey_option.dart';

/// Model for a survey step, which could be a question or an informational screen.
class SurveyStep {
  final String id;
  final String title;
  final String? description;
  final SurveyStepType stepType;
  final List<SurveyOption>? options; // For multiple choice questions
  dynamic answer; // Generic answer type for storing user input
  final bool isRequired;

  SurveyStep({
    required this.id,
    required this.title,
    this.description,
    required this.stepType,
    this.options,
    this.answer,
    this.isRequired = false,
  }) : assert(
          stepType != SurveyStepType.multipleChoiceSingleSelect || (options != null && options.length >= 2),
          'Multiple choice questions must have at least two options.',
        );
}
