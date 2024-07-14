import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'GoalDetail.dart';
import '../../models/Goal.dart';  // Updated import statement
import 'AddGoal.dart';  // Import AddGoal page

class GoalPage extends StatefulWidget {
  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  List<Goal> goals = [
    Goal.withId(1, 'Save for Vacation', 1000, 500, '2024-07-15'),
    Goal.withId(2, 'Buy a new phone', 1500, 1250, '2024-08-01'),
    Goal.withId(3, 'Emergency Fund', 3000, 1500, '2024-09-01'),
  ];

  void _addGoal(Goal newGoal) {
    setState(() {
      // Add new goal to the goals list with an auto-incremented ID
      final id = goals.isNotEmpty ? goals.last.id + 1 : 1;
      goals.add(Goal.withId(id, newGoal.name, newGoal.goal, newGoal.currentGoal, newGoal.date));
    });
  }

  void _deleteGoal(int id) {
    setState(() {
      goals.removeWhere((goal) => goal.id == id);
    });
  }

  void _navigateToAddGoal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddGoal(state: true, goal: Goal('', 0, 0, ''), onAddGoal: _addGoal),
      ),
    );
  }

  void _showGoalDetail(Goal goal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoalDetail(goal: goal),
      ),
    ).then((_) {
      setState(() {});  // Refresh state after returning from GoalDetail
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddGoal,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          Goal goal = goals[index];
          return Dismissible(
            key: Key(goal.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              _deleteGoal(goal.id);
            },
            child: GestureDetector(
              onTap: () => _showGoalDetail(goal),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            goal.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteGoal(goal.id);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text('Goal: \$${goal.goal.toStringAsFixed(2)}'),
                      SizedBox(height: 5),
                      Text('Current Goal: \$${goal.currentGoal.toStringAsFixed(2)}'),
                      SizedBox(height: 5),
                      LinearProgressIndicator(
                        value: goal.currentGoal / goal.goal,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      SizedBox(height: 5),
                      Text('End Date: ${goal.date}'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
