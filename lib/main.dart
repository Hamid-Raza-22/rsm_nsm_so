import 'package:flutter/material.dart';
import 'package:rsm_nsm_so/RSM_HomePage.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
 runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RSMHomepage()
    ),
  );
}