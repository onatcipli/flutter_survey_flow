import '../enums/survey_step_type.dart';

import 'survey_option.dart';

/// Model for a survey step, which could be a question or an informational screen.
class SurveyStep<T> {
  final String id;
  final String title;
  final String? description;
  final SurveyStepType stepType;
  List<SurveyOption>? options; // For multiple choice questions
  T? answer; // Generic answer type for storing user input
  final bool isRequired;

  SurveyStep({
    required this.id,
    required this.title,
    this.description,
    required this.stepType,
    this.options,
    this.answer,
    this.isRequired = true,
  }) : assert(
          stepType != SurveyStepType.multipleChoiceSingleSelect ||
              (options != null && options.length >= 2),
          'Multiple choice questions must have at least two options.',
        );

  /// Constructor for creating a multiple choice single select survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * options: A list of SurveyOption objects representing the choices.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.multipleChoiceSingleSelect({
    required this.id,
    required this.title,
    this.description,
    required List<SurveyOption> this.options,
    this.answer,
    this.isRequired = true,
  })  : stepType = SurveyStepType.multipleChoiceSingleSelect,
        assert(options.length >= 2,
            'Multiple choice questions must have at least two options.');

  /// Constructor for creating a multiple choice multi select survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * options: A list of SurveyOption objects representing the choices.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.multipleChoiceMultiSelect({
    required this.id,
    required this.title,
    this.description,
    required List<SurveyOption> this.options,
    this.answer,
    this.isRequired = true,
  })  : stepType = SurveyStepType.multipleChoiceMultiSelect,
        assert(options.length >= 2,
            'Multiple choice questions must have at least two options.');

  /// Constructor for creating a yes/no survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * options: A list of SurveyOption objects representing the choices.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.yesNo({
    required this.id,
    required this.title,
    this.description,
    List<SurveyOption>? options,
    this.answer,
    this.isRequired = true,
  })  : options = options ??
            [
              SurveyOption(id: 'yes', title: 'Yes'),
              SurveyOption(id: 'no', title: 'No')
            ],
        stepType = SurveyStepType.yesNo,
        assert(options == null || options.length == 2,
            'Yes/No questions must have exactly two options.');
}
