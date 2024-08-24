/// Represents the different types of steps available in the survey or questionnaire flow.
enum SurveyStepType {
  /// A single choice question where only one option can be selected.
  multipleChoiceSingleSelect,

  /// A multiple choice question where multiple options can be selected.
  multipleChoiceMultiSelect,

  /// A simple yes/no question.
  yesNo,

  /// A date picker question that allows the user to select a specific date.
  datePicker,

  /// A time picker question that allows the user to select a specific time.
  timePicker,

  /// A slider input question that allows the user to select a value within a range.
  slider,

  /// A toggle switch question for enabling/disabling an option.
  toggleSwitch,

  /// A rating question (e.g., star rating or numeric rating).
  rating,

  /// A notification step to inform the user of important details or instructions.
  notification,

  /// A preparation step to inform the user we are preparing the application for personalization.
  preparation,

  /// A screen to display when the survey or questionnaire is successfully completed.
  successScreen,

  /// A custom step that allows the user to input their own response.
  custom,
}