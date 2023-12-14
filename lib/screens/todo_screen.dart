import 'package:enough_platform_widgets/enough_platform_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:paxa_health/state_provider.dart';
import 'package:paxa_health/utils/app_logger.dart';
import 'package:paxa_health/utils/loadin_overlay.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child:
            Consumer<StateProvider>(builder: (context, stateProvider, child) {
          final todos = stateProvider.todos;
          final today = todos.where((e) => e.todo.today).toList();
          final todayfinished =
              todos.where((e) => e.completed == true && e.todo.today).toList();
          final tomorrow = todos.where((e) => !e.todo.today).toList();
          return Stack(
            // fit: StackFit.expand,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(stateProvider.user?.image ?? ''),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer()
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: today.length,
                              itemBuilder: (_, i) {
                                final todoE = today[i];
                                if (todoE.completed) {
                                  return IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_box,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Opacity(
                                              opacity: 0.4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    todoE.todo.name,
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    todoE.todo.Hour,
                                                    style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          todoE.todo.img == null
                                              ? SizedBox()
                                              : Image.network(
                                                  height: 40, todoE.todo.img!)
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return IntrinsicHeight(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                todoE.todo.name,
                                                style: TextStyle(
                                                    color: Colors.grey[500]),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                todoE.todo.Hour,
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        todoE.todo.img == null
                                            ? SizedBox()
                                            : Image.network(
                                                height: 40, todoE.todo.img!)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tomorrow',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer()
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: tomorrow.length,
                              itemBuilder: (_, i) {
                                final todoE = tomorrow[i];
                                return IntrinsicHeight(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                todoE.todo.name,
                                                style: TextStyle(
                                                    color: Colors.grey[500]),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                todoE.todo.Hour,
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        todoE.todo.img == null
                                            ? SizedBox()
                                            : Image.network(
                                                height: 40, todoE.todo.img!)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 30,
                right: 10,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (_) {
                          return TaskCreationScreen();
                        });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class TaskCreationScreen extends StatefulWidget {
  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _hourController = TextEditingController();
  bool _isToday = true;
  TextEditingController _imageController = TextEditingController();
  String time = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Add a task',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                space(),
                Row(
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    space2(),
                    Expanded(
                        child: CupertinoTextField.borderless(
                      controller: _nameController,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CupertinoColors.inactiveGray,
                            width: 0.0, // One physical pixel.
                            style: BorderStyle.solid,
                          ),
                        ),
                        // decoration: const InputDecoration(
                        //   labelText: 'Task Name',
                        // ),
                      ),
                    ))
                  ],
                ),
                space(),
                Row(
                  children: [
                    const Text(
                      'Hour',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    space2(),
                    SizedBox(
                        height: 40,
                        width: 120,
                        child: CupertinoDatePicker(
                            use24hFormat: true,
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (v) {
                              final temp = formatDateTime(v);
                              AppLogger.print(temp);
                              time = temp;
                            })),
                    SizedBox(
                        height: 40,
                        width: 60,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 2)),
                          child: Center(
                              child: Text(
                            'AM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ))
                  ],
                ),
                space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    CupertinoSwitch(
                      value: _isToday,
                      onChanged: (bool value) {
                        setState(() {
                          _isToday = value;
                        });
                      },
                    ),
                  ],
                ),
                space(),
                Row(
                  children: [
                    const Text(
                      'Image Link',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    space2(),
                    Expanded(
                      child: CupertinoTextField.borderless(
                        controller: _imageController,
                        onChanged: (value) {},
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CupertinoColors.inactiveGray,
                              width: 0.0, // One physical pixel.
                              style: BorderStyle.solid,
                            ),
                          ),
                          // decoration: const InputDecoration(
                          //   labelText: 'Task Name',
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty || time.isEmpty) {
                        return;
                      }
                      LoadingOverlay.of(context)
                          .during(context.read<StateProvider>().addTask(
                              _nameController.text,
                              time,
                              _isToday,
                              _imageController.text))
                          .then((value) {
                        if (value != null) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'If you disable today, the task will be considered as tomorrow',
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget space() => const SizedBox(
      height: 40,
    );
Widget space2() => const SizedBox(
      width: 25,
    );
String formatDateTime(DateTime dateTime) {
  String period = 'AM';
  int hour = dateTime.hour;

  if (hour >= 12) {
    period = 'PM';
    if (hour > 12) {
      hour -= 12;
    }
  }

  // Use the formatted components to create a custom format
  String formattedTime =
      '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
  String formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';

  return '$formattedTime';
}
