import 'package:flutter/material.dart';

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

  final Widget Function(BuildContext context, SurveyStep<T> step)? customWidget;

  // loading state when beforeComplete is called
  bool isLoading = false;

  final Future<void> Function(SurveyStep<T>? step)? onInit;

  /// Callback before the step is completed, can be used for async operations.
  final Future<void> Function(dynamic answer)? beforeComplete;

  /// Callback when the step is completed.
  final void Function(dynamic answer)? onCompleted;

  SurveyStep({
    required this.id,
    required this.title,
    this.description,
    required this.stepType,
    this.options,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
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
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
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
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
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
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = options ??
            [
              SurveyOption(id: 'yes', title: 'Yes'),
              SurveyOption(id: 'no', title: 'No')
            ],
        stepType = SurveyStepType.yesNo,
        assert(options == null || options.length == 2,
            'Yes/No questions must have exactly two options.');

  /// Constructor for creating a date picker survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.datePicker({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.datePicker;

  /// Constructor for creating a time picker survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.timePicker({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.timePicker;

  /// Constructor for creating a slider survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.slider({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.slider;

  /// Constructor for creating a toggle switch survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.toggleSwitch({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.toggleSwitch;

  /// Constructor for creating a rating survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.rating({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.rating;

  /// Constructor for creating a notification survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.notification({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.notification;

  /// Constructor for creating a preparation survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * options: A list of SurveyOption objects representing the choices.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.preparation({
    required this.id,
    required this.title,
    this.description,
    this.options,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  }) : stepType = SurveyStepType.preparation;

  /// Constructor for creating a success screen survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.successScreen({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.successScreen;

  /// Constructor for creating a custom survey step.
  ///
  /// Parameters:
  /// * id: The unique identifier for the step.
  /// * title: The display title for the step.
  /// * description: An optional description for the step.
  /// * isRequired: A boolean indicating if the step is required.
  SurveyStep.custom({
    required this.id,
    required this.title,
    this.description,
    this.answer,
    this.isRequired = true,
    this.beforeComplete,
    this.onCompleted,
    this.onInit,
    this.customWidget,
  })  : options = null,
        stepType = SurveyStepType.custom;
}
