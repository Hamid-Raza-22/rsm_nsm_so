import 'package:flutter/material.dart';
import 'dart:async';

import 'LIVE_location_page.dart';
import 'RSM_Booker_Details.dart';
import 'RSM_ShopDetails.dart';
import 'RSM_ShopVisit.dart';
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'RSM Homepage',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 24,
                color: Colors.white
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.info, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    isClockedIn ? _formatElapsedTime(_elapsedSeconds) : 'Timer',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await _toggleClockInOut();
                },
                icon: Icon(
                  isClockedIn ? Icons.timer_off : Icons.timer,
                  color: isClockedIn ? Colors.red : Colors.green,
                ),
                label: Text(
                  isClockedIn ? 'Clock Out' : 'Clock In',
                  style: const TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: isClockedIn ? Colors.red : Colors.green,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildCard(context, 'SHOP VISIT', Icons.store, Colors.green),
            _buildCard(context, 'BOOKERS STATUS', Icons.person, Colors.blue),
            _buildCard(context, 'SHOPS DETAILS', Icons.info, Colors.orange),
            _buildCard(context, 'BOOKERS ORDER DETAILS', Icons.book, Colors.purple),
            _buildCard(context, 'LIVE LOCATION', Icons.location_on, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
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
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'avenir next',
                      fontSize: 18,
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
    // Navigation logic based on the title
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
          MaterialPageRoute(builder: (context) => BookerDetailPage()),
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
          MaterialPageRoute(builder: (context) => BookingBookPage()),
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

class BookingBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSM BOOKING BOOK'),
      ),
      body: const Center(child: Text('Booking Book Page')),
    );
  }
}
