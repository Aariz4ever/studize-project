import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0, 26, 26, 26),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Task',
                style: GoogleFonts.poppins(color: Colors.white,fontSize: 20)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'On Progress',
                  style: GoogleFonts.poppins(color: Colors.amber,fontSize: 15)
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.filter_alt_rounded,
                  color: Colors.amber, // Set icon color to white
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
