import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/survey_step.dart';
import '../widgets/survey_scaffold.dart';

class SurveyConfiguration {
  /// If true, the survey will automatically pass to the next step when the current step is answered.
  final bool autoPassToNextStep;
  final Duration autoPassToNextStepDelay;

  final bool enableSwipeNavigation;

  const SurveyConfiguration({
    this.autoPassToNextStep = false,
    this.autoPassToNextStepDelay = const Duration(milliseconds: 600),
    this.enableSwipeNavigation = false,
  });
}

class SurveyProvider with ChangeNotifier {
  final SurveyConfiguration configuration;
  final BuildContext context;
  PageController stepPageController = PageController();
  List<SurveyStep> steps = [];
  int currentStepIndex = 0;

  /// Returns the current step in the survey.
  SurveyStep get currentStep => steps[currentStepIndex];

  /// Returns the previous step in the survey, or null if the current step is the first step.
  SurveyStep? get previousStepItem {
    return isFirstStep ? null : steps[currentStepIndex - 1];
  }

  /// Returns the next step in the survey, or null if the current step is the last step.
  SurveyStep? get nextStepItem {
    return isLastStep ? null : steps[currentStepIndex + 1];
  }

  /// Checks if the current step is the first step in the survey.
  ///
  /// Returns:
  /// * A boolean value indicating if the current step is the first step.
  bool get isFirstStep {
    return currentStepIndex == 0;
  }

  /// Checks if the current step is the last step in the survey.
  ///
  /// Returns:
  /// * A boolean value indicating if the current step is the last step.
  bool get isLastStep {
    return currentStepIndex == steps.length - 1;
  }

  /// Checks if the current step has an answer.
  ///
  /// Returns:
  /// * A boolean value indicating if the current step has an answer.
  bool get isCurrentStepAnswered {
    return currentStep.answer != null;
  }

  /// Checks if the current step is required.
  ///
  /// Returns:
  /// * A boolean value indicating if the current step is required.
  bool get isCurrentStepRequired {
    return currentStep.isRequired;
  }

  /// Calculates the percentage of the survey that has been completed.
  ///
  /// Returns:
  /// * A double value representing the completion percentage between 0.0 and 1.0.
  double get completionPercentage {
    if (steps.isEmpty) {
      return 0.0;
    }
    final int totalSteps = steps.length * 2;
    final int answeredSteps = steps.where((step) => step.answer != null).length;
    final double percentage =
        (answeredSteps + currentStepIndex + 1) / totalSteps;
    return percentage.clamp(0.0, 1.0);
  }

  SurveyProvider({
    required this.context,
    this.configuration = const SurveyConfiguration(),
    required this.steps,
  }) {
    updateStepsListener();
  }

  /// Updates the listener for the step page controller.
  void updateStepsListener() {
    if (configuration.enableSwipeNavigation) {
      stepPageController.addListener(() {
        currentStepIndex = stepPageController.page!.round().clamp(
              0,
              steps.length - 1,
            );
        notifyListeners();
      });
    }
  }

  /// Starts the survey by pushing the SurveyScaffold page onto the navigation stack.
  void startSurvey() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: this,
          child: const SurveyScaffold(),
        ),
      ),
    );
  }

  /// Updates the answer for a specific survey step.
  ///
  /// Parameters:
  /// * stepId: The ID of the step to update.
  /// * answer: The new answer to set for the step.
  Future<void> updateAnswer(String stepId, dynamic answer) async {
    final step = steps.firstWhere((step) => step.id == stepId);
    step.answer = answer;
    notifyListeners();
    if (configuration.autoPassToNextStep && !isLastStep) {
      await Future.delayed(configuration.autoPassToNextStepDelay);
      nextStep();
    }
  }

  /// Navigates to a specific step in the survey.
  ///
  /// Parameters:
  /// * stepIndex: The index of the step to navigate to.
  void navigateToStep(int stepIndex) {
    if (stepIndex >= 0 && stepIndex < steps.length) {
      currentStepIndex = stepIndex;
      stepPageController.jumpToPage(stepIndex);
      notifyListeners();
    }
  }

  /// Moves to the next step in the survey and completes the survey if it's the last step.
  void nextStep() {
    if (currentStepIndex < steps.length - 1) {
      currentStepIndex++;
      _nextPage();
      notifyListeners();
    } else {
      completeSurvey();
    }
  }

  /// Completes the survey and returns the steps.
  ///
  /// Returns:
  /// * A list of SurveyStep objects representing the completed steps.
  List<SurveyStep> completeSurvey() {
    Navigator.of(context).pop();
    return steps;
  }

  /// Moves to the previous step in the survey or cancels the survey if it's the first step.
  void previousStep() {
    if (currentStepIndex > 0) {
      currentStepIndex--;
      _previousPage();
      notifyListeners();
    } else {
      cancelSurvey();
    }
  }

  /// Cancels the survey and resets all steps.
  void cancelSurvey() {
    currentStepIndex = 0;
    stepPageController.jumpToPage(0);
    notifyListeners();
    Navigator.of(context).pop();
  }

  /// Moves the PageView to the next page.
  void _nextPage() {
    stepPageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Moves the PageView to the previous page.
  void _previousPage() {
    stepPageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
