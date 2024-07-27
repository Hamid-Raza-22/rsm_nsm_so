import 'package:flutter/material.dart';
import 'dart:async';

import '../bookerstatus.dart';
import 'LIVE_location_page.dart';
import 'RSM_Booker_Details.dart';
import 'RSM_ShopDetails.dart';
import 'RSM_ShopVisit.dart';
import 'RSM_bookerbookingdetails.dart';
// Import other pages if needed

class RSMHomepage extends StatefulWidget {
  const RSMHomepage({Key? key}) : super(key: key);

  @override
  _RSMHomepageState createState() => _RSMHomepageState();
}

class _RSMHomepageState extends State<RSMHomepage> {
  bool isClockedIn = false;
  late Timer _timer;
  int _elapsedSeconds = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  String _formatElapsedTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  Future<void> _toggleClockInOut() async {
    setState(() {
      if (isClockedIn) {
        _stopTimer();
      } else {
        _elapsedSeconds = 0;
        _startTimer();
      }
      isClockedIn = !isClockedIn;
    });
    // Add any additional logic for clocking in/out here, such as API calls or database updates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.green),
            onPressed: () {
              // Add reload functionality here
            },
          ),
        ],
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // Remove shadow
        title: null, // No title
        centerTitle: true,
        flexibleSpace: Container(
          color: Colors.transparent, // Transparent color to ensure no background
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const Text(
          'RSM - DASHBOARD',
          style: TextStyle(
            fontFamily: 'avenir next',
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final cardInfo = [
                    {'title': 'SHOP VISIT', 'icon': Icons.store, 'color': Colors.green},
                    {'title': 'BOOKERS STATUS', 'icon': Icons.person, 'color': Colors.green},
                    {'title': 'SHOPS DETAILS', 'icon': Icons.info, 'color': Colors.green},
                    {'title': 'BOOKERS ORDER DETAILS', 'icon': Icons.book, 'color': Colors.green},
                    {'title': 'LIVE LOCATION', 'icon': Icons.location_on, 'color': Colors.green},
                  ][index];

                  return _buildCard(
                    context,
                    cardInfo['title'] as String,
                    cardInfo['icon'] as IconData,
                    cardInfo['color'] as Color,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TIMER: ${_formatElapsedTime(_elapsedSeconds)}',
                  style: const TextStyle(
                    fontFamily: 'avenir next',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 50),
                ElevatedButton.icon(
                  onPressed: () async {
                    await _toggleClockInOut();
                  },
                  icon: Icon(
                    isClockedIn ? Icons.timer_off : Icons.timer,
                    color: Colors.white,
                  ),
                  label: Text(
                    isClockedIn ? 'Clock Out' : 'Clock In',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'avenir next',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          _navigateToPage(context, title);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.3), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'avenir next',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String title) {
    switch (title) {
      case 'SHOP VISIT':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShopVisitPage()),
        );
        break;
      case 'BOOKERS STATUS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookerStatus()),
        );
        break;
      case 'SHOPS DETAILS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShopDetailPage()),
        );
        break;
      case 'BOOKERS ORDER DETAILS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RSMBookingBookPage()),
        );
        break;
      case 'LIVE LOCATION':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveLocationPage()),
        );
        break;
    }
  }
}
