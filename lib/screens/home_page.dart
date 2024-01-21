import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:studize_interview/screens/detail_page.dart';
import 'package:studize_interview/widgets/date_picker.dart';
import 'package:studize_interview/widgets/drawer.dart';
import 'package:studize_interview/widgets/task_timeline.dart';
import 'package:studize_interview/widgets/task_title.dart';
import 'package:studize_interview/services/tasks/tasks_classes.dart';
import 'package:studize_interview/services/tasks/tasks_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime selectedDay;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final now = DateTime.now();
    selectedDay = DateTime(
      now.year,
      now.month,
      now.day,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: const Color.fromARGB(225, 0, 0, 0),
      //backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        leading: Builder(builder: (context) => IconButton(onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        
        icon: const Icon(Icons.menu,),color: Colors.amber ,),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Colors.amber),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: null,
      ),
      body: FutureBuilder(
        future: TasksService.getSubjectList(),
        builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              List<Subject> subjectList = snapshot.data!;
              return ListView(
                controller: _scrollController,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Hello User!',style: GoogleFonts.poppins(fontSize: 30,color: Colors.white,),),
                      ),
                      Text('Today\'s Summary',style: GoogleFonts.poppins(color: Colors.amber),)
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: subjectList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _calculateCrossAxisCount(context),
                        crossAxisSpacing: 10,
                        childAspectRatio: 2,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) =>
                          _buildSubject(context, subjectList[index]),
                    ),
                  ),
                  _buildDetailSection(),
                ],
              );
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: Text('Fetching subjects from storage....'),
              );
            case ConnectionState.none:
              return const Center(
                child: Text("Error: Could not get subjects from storage"),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          _showAddDialog(context);
        },
        child: 
            const Icon(Icons.edit_note_rounded,size: 30,),
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 650 ? 3 : 2;
  }

  Widget _buildSubject(BuildContext context, Subject subject) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const DetailPage(),
        //   ),
        // );
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            }
          });
      },
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 25.0,
            //color: subject.color.withOpacity(0.2),
          )]
        ),
        child: Container(
          // margin: EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                subject.color.withOpacity(1),subject.color.withOpacity(0.7),]),
            //color: subject.color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            // border: Border.all(color: subject.color,width: 2)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  // Image.asset(
                  //   subject.iconAssetPath,
                  //   width: 35,
                  //   height: 35,
                  // ),
                  const SizedBox(height: 5),
                  Text(
                    subject.name,
                    style: GoogleFonts.poppins(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 18)
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildTaskStatus(
                        const Color.fromARGB(255, 45, 45, 45),
                        subject.color,
                        '${subject.numTasksLeft} left',
                        Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              // Image.asset(
              //       subject.iconAssetPath[0],
              //       width: 35,
              //       height: 35,
              //     ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskStatus(
    Color bgColor,
    Color txColor,
    String text,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDetailSection() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DatePicker(
            callback: (selectedDay) =>
                setState(() => this.selectedDay = selectedDay),
          ),
          const TaskTitle(),
          SizedBox(
            height: 400, // Set the height based on your requirement
            child: FutureBuilder(
              future: TasksService.getAllTasks(),
              builder: (context, snapshot) {
                final List<Task> taskList = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) => TaskTimeline(
                    task: taskList[index],
                    subjectColor: taskList[index].color,
                    isFirst: index == 0,
                    isLast: index == taskList.length - 1,
                    refreshCallback: () {
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _showAddDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController colorController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: const Text("Add Subject"),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Subject Name"),
              ),
              TextField(
                controller: colorController,
                decoration: const InputDecoration(labelText: "Subject Color"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              
              onPressed: () {
                // Validate and add the new subject
                String name = nameController.text.trim();
                String colorString = colorController.text.trim();
                if (name.isNotEmpty && colorString.isNotEmpty) {
                  Color color = _getColorFromString(colorString);
                  Subject newSubject = Subject(name: name, color: color);
                  // Add the new subject to the list or perform necessary actions
                  // For now, let's just print the subject details
                  print("New Subject: $newSubject");
                  Navigator.of(context).pop();
                } else {
                  // Show error message or handle invalid input
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Color _getColorFromString(String colorString) {
    // Convert color string to Color object
    int value = int.parse(colorString, radix: 16);
    return Color(value).withOpacity(1.0);
  }
}

