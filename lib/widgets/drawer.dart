import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                ),
                Row(
                  children: [
                    Text('user@gmail.com',style: GoogleFonts.poppins(color: Colors.grey[500]),),
                    const SizedBox(width: 10,),
                    Icon(Icons.arrow_drop_down,color: Colors.grey[500],)
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: 
              Icon(Icons.star_border_rounded,color: Colors.grey[300],),
              title: Text('Starred',style: GoogleFonts.poppins(color: Colors.grey[300]),),
           onTap: () {
              
            },
          ),
          //Divider(color: Colors.grey[800]),
          ListTile(
            leading: 
              Icon(Icons.snooze_rounded,color: Colors.grey[300],),
              title: Text('Snoozed',style: GoogleFonts.poppins(color: Colors.grey[300]),),
           onTap: () {
              
            },
          ),
          ListTile(
            leading: 
              Icon(Icons.calendar_month_rounded,color: Colors.grey[300],),
              title: Text('Calender',style: GoogleFonts.poppins(color: Colors.grey[300]),),
           onTap: () {
              
            },
          ),
          ListTile(
            leading: 
              Icon(Icons.settings,color: Colors.grey[300],),
              title: Text('Settings',style: GoogleFonts.poppins(color: Colors.grey[300]),),
           onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}