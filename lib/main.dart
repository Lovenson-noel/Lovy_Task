import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: TaskScreen(
        taskData: TaskData(
          tasks: [
            Task(description: 'Comprar leite'),
            Task(description: 'Pagar contas'),
            Task(description: 'Estudar Flutter'),
            Task(description: 'Estudar Android'),
            Task(description: 'Ir no Shopping'),
            Task(description: 'Abastecer o carro'),
          ],
        ),
      ),
    ),
  );
}

class Task {
  final String description;
  bool completed;

  Task({required this.description, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}

class TaskData {
  List<Task> tasks;

  TaskData({required this.tasks});

  int get taskCount {
    return tasks.length;
  }

  void addTask(String taskDescription) {
    final task = Task(description: taskDescription);
    tasks.add(task);
  }

  void updateTask(Task task) {
    task.toggleCompleted();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final Function onChanged;

  TaskTile({required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.description,
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: task.completed,
        onChanged: (bool) {
          _onChanged();
          },
      ),
    );
  }

  void _onChanged() {}
}

class TaskList extends StatefulWidget {
  final TaskData taskData;

  TaskList({required this.taskData});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.taskData.taskCount,
      itemBuilder: (context, index) {
        final task = widget.taskData.tasks[index];
        return TaskTile(
          task: task,
          onChanged: (newValue) {
            setState(() {
              widget.taskData.updateTask(task);
            });
          },
        );
      },
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  final Function addTaskCallback;

  AddTaskScreen({required this.addTaskCallback});

  @override
  Widget build(BuildContext context) {
    String taskDescription;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Adicionar tarefa',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                taskDescription = newText;
              },
            ),
            FlatButton(
              child: Text(
                'Adicionar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                var _textEditingController;
                addTaskCallback(_textEditingController.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  FlatButton({required Text child, required MaterialAccentColor color, required Null Function() onPressed}) {}
}

class TaskScreen extends StatefulWidget {
  final TaskData taskData;

  TaskScreen({required this.taskData});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddTaskScreen(
                  addTaskCallback: (taskDescription) {
                    setState(() {
                      widget.taskData.addTask(taskDescription);
                    });
                  },
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      Container(
      padding: EdgeInsets.only(
        top: 60.0,
        left: 30.0,
        right: 30.0,
        bottom: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            child: Icon(
              Icons.list,
              size: 30.0,
              color: Colors.lightBlueAccent,
            ),
            backgroundColor: Colors.white,
            radius: 30.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Tarefas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${widget.taskData.taskCount} tarefas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
    Expanded(
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
    ),
    ),
    child: TaskList(
    taskData: widget.taskData,
    ),
    ),
    ),
    ],
    ),
    );
  }
}

