import 'package:flutter/material.dart';
import 'booker_location_nsm.dart';
import 'rsm_location_nsm.dart';
import 'sm_location.dart';

class NsmLocationNavigation extends StatelessWidget {
  const NsmLocationNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNavigationCard(context, 'Booker location', Icons.location_city, BookerLocationnsm()),
            const SizedBox(height: 16.0),
            _buildNavigationCard(context, 'RSM location', Icons.business_center,  RSM_Location_nsm()),
            const SizedBox(height: 16.0),
            _buildNavigationCard(context, 'SM location', Icons.public, SMLocationnsm()),
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


