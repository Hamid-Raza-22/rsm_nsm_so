import 'package:flutter/material.dart';
import 'SM_Booker_Status.dart';
import 'SM_RSM_status.dart';
import 'booker_location.dart';
import 'rsm_location.dart';

class smnavigation extends StatelessWidget {
  const smnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const SizedBox(height: 16.0),
            _buildNavigationCard(context, 'RSM Location', Icons.location_city, RSM_Location()),
            const SizedBox(height: 16.0),
            _buildNavigationCard(context, 'Booker Location', Icons.assignment_ind, BookerLocation()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 50.0, color: Colors.green),
              const SizedBox(width: 16.0),
              Container(
                width: 1,
                height: 60,
                color: Colors.green,
              ),
              const SizedBox(width: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontFamily: 'avenir next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
