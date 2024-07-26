import 'package:flutter/material.dart';

import 'landing_page.dart';
import 'RSM/RSM_HomePage.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
 runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage()
    ),
  );
}