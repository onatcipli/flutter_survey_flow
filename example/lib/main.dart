import 'package:flutter/material.dart';
import 'package:flutter_survey_flow/flutter_survey_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    FlutterSurveyFlow.startSurvey(
      context: context,
      steps: [
        SurveyStep.multipleChoiceSingleSelect(
          id: '1',
          title: 'What is your name?',
          description: 'Please select an option',
          options: [
            SurveyOption(
              id: '1',
              title: 'Option 1',
              description: 'Option 1 description',
              icon: Icons.search,
            ),
            SurveyOption(
              id: '2',
              title: 'Option 2',
              description: 'Option 2 description',
              icon: Icons.person,
            ),
            SurveyOption(
              id: '3',
              title: 'Option 3',
              description: 'Option 3 description',
              icon: Icons.alarm,
            ),
          ],
        ),
        SurveyStep(
          id: '2',
          title: 'What is your name?',
          description: 'Please type your name we will use it to identify you',
          stepType: SurveyStepType.multipleChoiceSingleSelect,
          options: [
            SurveyOption(
              id: '1',
              title: 'Option 1',
            ),
            SurveyOption(
              id: '2',
              title: 'Option 2',
            ),
            SurveyOption(
              id: '3',
              title: 'Option 3',
            ),
          ],
        ),
        SurveyStep<String>.yesNo(
          id: '3',
          title: 'Do you agree with the terms and conditions?',
          description: 'Please select Yes or No',
        ),
        SurveyStep<List<SurveyOption>>.multipleChoiceMultiSelect(
          id: '4',
          title: 'Select your favorite fruits',
          description: 'You can select multiple options',
          options: [
            SurveyOption(
              id: '1',
              title: 'Apple',
              description: 'A sweet red fruit',
              icon: Icons.apple,
            ),
            SurveyOption(
              id: '2',
              title: 'Banana',
              description: 'A long yellow fruit',
            ),
            SurveyOption(
              id: '3',
              title: 'Cherry',
              description: 'A small red fruit',
            ),
            SurveyOption(
              id: '4',
              title: 'Date',
              description: 'A sweet brown fruit',
              icon: Icons.date_range,
            ),
          ],
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
