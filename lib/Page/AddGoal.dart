import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/Goal.dart';


class AddGoal extends StatefulWidget {
  final bool state;
  final Goal goal;
  final Function(Goal) onAddGoal;

  AddGoal({required this.state, required this.goal, required this.onAddGoal});

  @override
  State<StatefulWidget> createState() {
    return _AddGoalState(this.state, this.goal, this.onAddGoal);
  }
}

class _AddGoalState extends State<AddGoal> {
  final bool state;
  final Goal goal;
  final Function(Goal) onAddGoal;

  _AddGoalState(this.state, this.goal, this.onAddGoal);

  DateTime dateTime = DateTime.now();
  late TextEditingController name;
  late TextEditingController money;

  BoxDecoration buttonDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.blueAccent,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(
          2.0,
          2.0,
        ),
      )
    ],
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Color(0xFF78CBE6), Color(0xFFBEEEC4)], // Updated hex color values
    ),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  );

  BoxDecoration buttonDecorationDark = BoxDecoration(
    border: Border.all(
      color: Colors.blueAccent,
    ),
    color: Color(0xFF219ebc), // Updated hex color value
    boxShadow: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(
          2.0,
          2.0,
        ),
      )
    ],
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  );

  @override
  void initState() {
    super.initState();
    if (!state) {
      dateTime = DateTime.parse(goal.date);
    }

    name = TextEditingController(text: goal.name);
    money = TextEditingController(text: goal.goal.toString() == '0.0' ? '' : goal.goal.toString());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> date = GlobalKey<ScaffoldState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text(title(state)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                controller: name,
                onChanged: (value) {
                  goal.name = value;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Goal Name',
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(Icons.emoji_events_outlined),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: money,
                onChanged: (value) {
                  goal.goal = double.parse(value);
                },
                maxLength: 10,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Goal Amount',
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(CupertinoIcons.money_dollar),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
                    ),
                    CupertinoButton(
                      child: Text(dateFormat(dateTime.toString())),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xFFB5EAEA), // Updated hex color value
                              title: Text(
                                'Select Date',
                                style: TextStyle(fontSize: 25, color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                  ),
                                )
                              ],
                              content: SizedBox(
                                height: 100,
                                width: 300,
                                child: CupertinoDatePicker(
                                  key: date,
                                  initialDateTime: dateTime,
                                  backgroundColor: Colors.transparent,
                                  minimumYear: DateTime.now().year,
                                  minimumDate: DateTime(DateTime.now().year),
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (DateTime value) {
                                    setState(() {
                                      dateTime = value;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 230),
              Container(
                width: 170,
                height: 60,
                decoration: buttonDecoration,
                child: CupertinoButton(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    buttonTitle(state),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () {
                    if (state) {
                      setState(() {
                        if (money.text.isEmpty || name.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter the goal details.',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        } else {
                          insertGoal();
                          goBack();
                        }
                      });
                    } else {
                      setState(() {
                        updateGoal();
                        goBack();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String dateFormat(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }

  void goBack() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void insertGoal() {
    String nameG = name.text;
    double goalAmount = double.parse(money.text);
    String dateg = dateFormat(dateTime.toString());
    Goal goalg = Goal(nameG, goalAmount, 0, dateg);
    widget.onAddGoal(goalg);
  }

  void updateGoal() {
    goal.date = dateFormat(dateTime.toString());
    // Update goal in your goals list or any other required logic
  }

  String title(bool state) {
    if (state) {
      return 'New Goal';
    } else {
      return goal.name;
    }
  }

  String buttonTitle(bool state) {
    if (state) {
      return 'Create';
    } else {
      return 'Save';
    }
  }
}
