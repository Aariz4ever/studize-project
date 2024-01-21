import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime selectedDay) callback;
  const DatePicker({super.key, required this.callback});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final weekList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final DateTime now = DateTime.now();
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = now.weekday - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime thisWeekMonday =
        DateTime(now.year, now.month, now.day + 1 - now.weekday);
    // now.subtract(Duration(days: now.weekday - 1));
    final List<String> dayList = [
      for (int i = 0; i < 7; i++)
        thisWeekMonday.add(Duration(days: i)).day.toString()
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 15)]),
        child: Container(
          color: const Color.fromARGB(255, 36, 36, 36),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              // Wrap the ListView in a SingleChildScrollView
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(weekList.length, (index) {
                  return Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 1.0)
                      ]
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedIndex = index);
                        final selectedDay =
                            thisWeekMonday.add(Duration(days: selectedIndex));
                        widget.callback(selectedDay);
                      },
                      child: Container(
                        
                        padding: const EdgeInsets.all(5),
                        // margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(10),
                          color: selectedIndex == index
                              ? const Color.fromARGB(255, 50, 50, 50)
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:4.0),
                          child: SizedBox(
                            height: 48,
                            width: 48,
                            child: Column(
                              children: [
                            
                                Text(
                                  weekList[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    // selectedIndex == index
                                    //     ? Colors.black
                                    //     : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  dayList[index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber
                                    // selectedIndex == index
                                    //     ? Colors.black
                                    //     : Colors.amber,
                                    //color: selected == index ? Colors.black : Colors.grey,
                                  ),
                                  ),
                                  // style: TextStyle(
                                  //   fontSize: 16,
                                  //   fontWeight: FontWeight.bold,
                                  //   color: selectedIndex == index
                                  //       ? Colors.black
                                  //       : Colors.amber,
                                  //   //color: selected == index ? Colors.black : Colors.grey,
                                  // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

