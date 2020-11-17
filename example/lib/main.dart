import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
      ),
      home: MyHomePage(title: 'Date Time Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.blue;
  String _d1, _d2;
  String _t1, _t2;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: _color,
        accentColor: _color,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Text(
                    'Color Pallet',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 24.0),
                  _colorPallet(),
                  SizedBox(height: 24.0),
                  Divider(),
                  SizedBox(height: 24.0),
                  _dateTimePicker(),
                  SizedBox(height: 24.0),
                  Divider(),
                  SizedBox(height: 24.0),
                  _datePicker(),
                  SizedBox(height: 24.0),
                  Divider(),
                  SizedBox(height: 24.0),
                  _timePicker(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _dateTimePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Date & Time Picker',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8.0),
        Text(
          'Date: $_d1  Time: $_t1',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 16.0),
        DateTimePicker(
          onDateChanged: (date) {
            setState(() {
              _d1 = DateFormat('dd MMM, yyyy').format(date);
            });
          },
          onTimeChanged: (time) {
            setState(() {
              _t1 = DateFormat('hh:mm:ss aa').format(time);
            });
          },
        )
      ],
    );
  }

  _datePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Date Picker',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8.0),
        Text(
          'Date: $_d2',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 16.0),
        DateTimePicker(
          type: DateTimePickerType.Date,
          onDateChanged: (date) {
            setState(() {
              _d2 = DateFormat('dd MMM, yyyy').format(date);
            });
          },
        )
      ],
    );
  }

  _timePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Time Picker',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8.0),
        Text(
          'Time: $_t2',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 16.0),
        DateTimePicker(
          type: DateTimePickerType.Time,
          timeInterval: Duration(minutes: 30),
          onTimeChanged: (time) {
            setState(() {
              _t2 = DateFormat('hh:mm:ss aa').format(time);
            });
          },
        )
      ],
    );
  }

  _colorPallet() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _color = Colors.amber;
            });
          },
          child: Container(
            width: 24.0,
            height: 24.0,
            color: Colors.amber,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _color = Colors.green;
            });
          },
          child: Container(
            width: 24.0,
            height: 24.0,
            color: Colors.green,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _color = Colors.blue;
            });
          },
          child: Container(
            width: 24.0,
            height: 24.0,
            color: Colors.blue,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _color = Colors.deepPurple;
            });
          },
          child: Container(
            width: 24.0,
            height: 24.0,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
