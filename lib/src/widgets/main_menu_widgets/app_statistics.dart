import 'package:flutter/material.dart';

class AppStatistics extends StatefulWidget {
  const AppStatistics({Key? key}) : super(key: key);

  @override
  State<AppStatistics> createState() => _AppStatisticsState();
}

class _AppStatisticsState extends State<AppStatistics> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      singleOverview(Icons.people, "ONLINE", 7),
      const SizedBox(width: 20),
      singleOverview(Icons.play_circle, "IN GAME", 4),
      const SizedBox(width: 20),
      singleOverview(Icons.timelapse, "WAITING", 3),
    ]);
  }

  Column singleOverview(IconData icon, String text, int value) {
    return Column(children: [Icon(icon), Text(text), Text(value.toString())]);
  }
}
