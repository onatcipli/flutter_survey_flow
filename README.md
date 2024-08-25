# Flutter Survey Flow

Flutter Survey Flow is a comprehensive package designed to facilitate the creation and management of surveys within Flutter applications. It provides a variety of survey steps, including multiple-choice, yes/no, date picker, time picker, slider, toggle switch, rating, and more. This package is ideal for applications that require user feedback, data collection, or any form of interactive questionnaire.

## Features

- **Multiple Choice (Single Select)**: Allows users to select one option from a list.
- **Multiple Choice (Multi Select)**: Allows users to select multiple options from a list.
- **Yes/No Questions**: Simple binary choice questions.
- **Date Picker**: Allows users to select a date.
- **Time Picker**: Allows users to select a time.
- **Slider**: Allows users to rate or select a value within a range.
- **Toggle Switch**: Allows users to toggle between two states.
- **Rating**: Allows users to rate on a scale.
- **Notification and Preparation Steps**: Custom steps for notifications and preparation.

## Getting Started

### Prerequisites

- Flutter SDK: `>=1.17.0`
- Dart SDK: `>=3.2.2 <4.0.0`

### Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_survey_flow: ^0.0.1
```

Then, run `flutter pub get` to install the package.

## Usage

### Basic Example

Here is a basic example of how to use the Flutter Survey Flow package in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_survey_flow/flutter_survey_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Survey Flow Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SurveyFlowScreen(),
    );
  }
}
```

### Advanced Example

Here is an advanced example of how to use the Flutter Survey Flow package in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_survey_flow/flutter_survey_flow.dart';

void main() {
  runApp(const MyApp());
}

/// MyApp is the root widget of the application.
/// It sets up the main theme and home screen of the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Survey Flow Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Survey Flow Demo Home Page'),
    );
  }
}

/// MyHomePage is a stateful widget that demonstrates the usage of the
/// Flutter Survey Flow package with various survey steps.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// Increments the counter and starts the survey.
  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    FlutterSurveyFlow.startSurvey(
      context: context,
      steps: [
        SurveyStep.multipleChoiceSingleSelect(
          id: '1',
          title: 'What is your favorite color?',
          description: 'Please select an option',
          options: [
            SurveyOption(
              id: '1',
              title: 'Red',
            ),
            SurveyOption(
              id: '2',
              title: 'Green',
            ),
            SurveyOption(
              id: '3',
              title: 'Blue',
            ),
            SurveyOption(
              id: '4',
              title: 'Yellow',
            ),
          ],
        ),
        SurveyStep<String>.yesNo(
          id: '2',
          title: 'Do you like Flutter?',
          description: 'Please select Yes or No',
        ),
        SurveyStep<DateTime>.datePicker(
          id: '3',
          title: 'What is your birthday?',
          description: 'Please choose your birth date from the date picker',
          answer: DateTime.now(),
        ),
        SurveyStep<TimeOfDay>.timePicker(
          id: '4',
          title: 'What time do you wake up?',
          description: 'Please choose your preferred time from the time picker',
          answer: TimeOfDay.now().replacing(minute: 0),
        ),
        SurveyStep<double>.slider(
          id: '5',
          title: 'How satisfied are you with this app?',
          description: 'Please rate your satisfaction on a scale from 0 to 100',
          answer: 50.0, // Default value
        ),
        SurveyStep<bool>.toggleSwitch(
          id: '6',
          title: 'Do you want to receive notifications?',
          description: 'Please select Yes or No',
          answer: true,
        ),
        SurveyStep<int>.rating(
          id: '7',
          title: 'Rate this app',
          description: 'Please rate your satisfaction on a scale from 1 to 5',
          answer: 5,
        ),
        SurveyStep<bool>.notification(
          id: '8',
          title: 'Thank you for taking the survey!',
          message: 'Your feedback is greatly appreciated.',
          answer: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Additional Information

- For more information about the package, please visit the [GitHub repository](https://github.com/your-github-username/flutter_survey_flow).
- To contribute to the package, please open a pull request on the [GitHub repository](https://github.com/your-github-username/flutter_survey_flow).
- To file an issue or report a bug, please open an issue on the [GitHub repository](https://github.com/your-github-username/flutter_survey_flow/issues).
- The package authors will respond to issues and pull requests as soon as possible.