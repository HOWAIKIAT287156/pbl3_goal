import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../models/Goal.dart';  // Adjust import path as needed

class GoalDetail extends StatefulWidget {
  final Goal goal;

  GoalDetail({required this.goal});

  @override
  _GoalDetailState createState() => _GoalDetailState();
}

class _GoalDetailState extends State<GoalDetail> {
  late double currentGoal;

  @override
  void initState() {
    super.initState();
    currentGoal = widget.goal.currentGoal;
  }

  void _editCurrentGoal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double? newCurrentGoal = currentGoal;

        return AlertDialog(
          title: Text('Edit Current Goal'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Current Goal',
              hintText: 'Enter new current goal',
            ),
            onChanged: (value) {
              newCurrentGoal = double.tryParse(value) ?? currentGoal;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  currentGoal = newCurrentGoal!;
                  widget.goal.currentGoal = currentGoal;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(widget.goal.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: _editCurrentGoal,
            icon: Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF219ebc), Color(0xFF023047)], // Hexadecimal colors replaced with Color class
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.goal.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                LinearPercentIndicator(
                  animation: true,
                  lineHeight: 30,
                  animationDuration: 1000,
                  percent: currentGoal / widget.goal.goal,
                  center: Text(
                    '\$${currentGoal.toStringAsFixed(2)} / \$${widget.goal.goal.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Color(0xFFa7cf4d), // Hexadecimal color replaced with Color class
                ),
                SizedBox(height: 30),
                // Add more goal details as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
