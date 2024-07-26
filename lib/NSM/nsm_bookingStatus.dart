import 'package:flutter/material.dart';
import '../SM/SM_RSM_status.dart';
import 'nsm_booker_status.dart';
import 'nsm_rsm_status.dart';
import 'nsm_sm_status.dart';



class NSMBookingStatus extends StatelessWidget {
  const NSMBookingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNavigationCard(context, 'RSM Status', Icons.location_city, NSM_RSM_Status()),
            const SizedBox(height: 16.0),
            _buildNavigationCard(context, 'Booker Status', Icons.assignment_ind, NSM_BookerStatus()),
            const SizedBox(height: 16.0),
            _buildNavigationCard(context, 'SM Status', Icons.supervisor_account,  NSM_SM_Status()), // New card for SM Status
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
                style: TextStyle(
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
