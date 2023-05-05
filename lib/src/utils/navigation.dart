import 'package:flutter/material.dart';

navigateTo(BuildContext context, StatefulWidget screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
