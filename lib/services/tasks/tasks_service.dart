import 'package:flutter/material.dart';
import 'package:studize_interview/services/tasks/tasks_classes.dart';
import 'package:studize_interview/services/tasks/tasks_exceptions.dart';

class TasksService {
  static Future<List<String>> getSubjectNameList() async {
    return ['Physics', 'Chemistry', 'Mathematics','English'];
  }

  static Future<List<Subject>> getSubjectList() async {
    return <Subject>[
      Subject(name: 'Physics', color: const Color.fromARGB(255, 255, 90, 96)),
      //Subject(name: 'Physics', color:  Color.fromARGB(255, 255, 166, 0)),//Color.fromARGB(255, 255, 90, 96)),
      Subject(name: 'Chemistry', color: const Color.fromARGB(255, 60, 145, 230)),
       Subject(name: 'Mathematics', color: const Color.fromARGB(255, 29, 211, 174)),
      //Subject(name: 'Mathematics', color: Color.fromARGB(255, 37, 209, 100)),
      Subject(name: 'English', color: const Color.fromARGB(255, 254, 216, 102))
      //Subject(name: 'English', color: Color.fromARGB(255, 209, 56, 194))
    ];
  }

  static Future<List<Task>> getAllTasks() async {
    final DateTime now = DateTime.now();
    List<Task> taskList = <Task>[
      Task(
        id: 0,
        title: 'Mathematics',
        description: 'Complex Numbers Quiz',
        timeStart: now.add(const Duration(hours: 1)),
        timeEnd: now.add(const Duration(hours: 2)),
        color: const Color.fromARGB(255, 255, 90, 96),
      ),
      Task(
        id: 1,
        title: 'Physics',
        description: 'Projectile Motion Revision',
        timeStart: now.add(const Duration(hours: 6)),
        timeEnd: now.add(const Duration(hours: 8)),
        color: const Color.fromARGB(255, 60, 145, 230),
      ),
      Task(
        id: 2,
        title: 'Chemistry',
        description: 'Isomerism - Prepare Notes',
        timeStart: now.add(const Duration(hours: 16)),
        timeEnd: now.add(const Duration(hours: 18)),
        color: const Color.fromARGB(255, 29, 211, 174),
      ),
      Task(id: 3, title: 'English', description: 'Read books', timeStart: now.add(const Duration(hours: 16)), timeEnd: now.add(const Duration(hours: 18)), color: const Color.fromARGB(255, 254, 216, 102))
    ];
    return taskList;
  }

  /// Returns task object that corresponds to the specified [taskId] inside the
  /// specified [subjectName].
  ///
  /// Throws exception `TaskNotFoundException` if specified `taskId` is not found
  /// and `SubjectNotFoundException` if specified `subjectName` is not found.
  static Future<Task> getTask({required int taskId}) async {
    List<Task> taskList = await getAllTasks();
    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].id == taskId) {
        return taskList[i];
      }
    }

    // If the loop completes without finding the specified id, then throw
    // exception
    throw TaskNotFoundException();
  }
}


// import 'package:flutter/material.dart';
// import 'package:studize_interview/services/tasks/tasks_classes.dart';

// class TasksService {
  
//   static List<Subject> subjectList = [
//     Subject(name: 'Physics', color: Colors.red),
//     Subject(name: 'Chemistry', color: Colors.blue),
//     Subject(name: 'Mathematics', color: Colors.green),
//   ];
//   static List<Task> taskList = [
     
//     Task(
//         id: 0,
//         title: 'Mathematics',
//         description: 'Complex Numbers Quiz',
//         timeStart: now.add(const Duration(hours: 1)),
//         timeEnd: now.add(const Duration(hours: 2)),
//         color: Colors.red,
//       ),
//       Task(
//         id: 1,
//         title: 'Physics',
//         description: 'Projectile Motion Revision',
//         timeStart: now.add(const Duration(hours: 6)),
//         timeEnd: now.add(const Duration(hours: 8)),
//         color: Colors.blue,
//       ),
//       Task(
//         id: 2,
//         title: 'Chemistry',
//         description: 'Isomerism - Prepare Notes',
//         timeStart: now.add(const Duration(hours: 16)),
//         timeEnd: now.add(const Duration(hours: 18)),
//         color: Colors.green,
//       )
//   ];

//   static Future<List<String>> getSubjectNameList() async {
//     return subjectList.map((subject) => subject.name).toList();
//   }

//   static Future<List<Subject>> getSubjectList() async {
//     return subjectList;
//   }

//   static Future<List<Task>> getAllTasks() async {
    
//     return taskList;
//   }

//   static Future<void> addSubject(Subject newSubject) async {
//     // You can add your logic here to store the newSubject
//     // For example, you can save it to a database or local storage
//     // For now, let's just update the subject list
//     subjectList.add(newSubject);
//   }

//   static Future<void> addTask(Task newTask) async {
//     // You can add your logic here to store the newTask
//     // For example, you can save it to a database or local storage
//     // For now, let's just update the task list
//     taskList.add(newTask);
//   }
// }

