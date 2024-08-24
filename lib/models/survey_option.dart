import 'package:flutter/widgets.dart';

/// Model for a survey option, which could be a selectable choice in a survey step.
class SurveyOption {
  final String id; // Unique identifier for the option
  final String title; // Display title for the option
  final String? description; // Optional description for the option
  final IconData? icon; // Optional icon for the option
  TextAlign? textAlign;

  /// Constructor for SurveyOption.
  ///
  /// Parameters:
  /// * id: The unique identifier for the option.
  /// * title: The display title for the option.
  /// * description: An optional description for the option.
  /// * icon: An optional icon for the option.
  SurveyOption({
    required this.id,
    required this.title,
    this.description,
    this.icon,
    this.textAlign = TextAlign.start,
  }) {
    if (description == null && icon == null) {
      textAlign = TextAlign.center;
    }
  }
}
