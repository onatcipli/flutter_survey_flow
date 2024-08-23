import 'package:flutter/material.dart';

import '../models/survey_step.dart';

class SurveyProvider with ChangeNotifier {
  BuildContext context;
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

  /// Calculates the percentage of the survey that has been completed.
  ///
  /// Returns:
  /// * A double value representing the completion percentage between 0.0 and 1.0.
  double get completionPercentage {
    if (steps.isEmpty) {
      return 0.0;
    }
    double percentage = (currentStepIndex + 1) / steps.length;
    return percentage.clamp(0.0, 1.0);
  }

  SurveyProvider({
    required this.context,
    required this.steps,
  });

  /// Updates the answer for a specific survey step.
  ///
  /// Parameters:
  /// * stepId: The ID of the step to update.
  /// * answer: The new answer to set for the step.
  void updateAnswer(String stepId, dynamic answer) {
    final step = steps.firstWhere((step) => step.id == stepId);
    step.answer = answer;
    notifyListeners();
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
    steps = [];
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
