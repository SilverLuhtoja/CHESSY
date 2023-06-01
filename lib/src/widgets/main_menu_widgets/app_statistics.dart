import 'package:flutter/material.dart';
import 'package:replaceAppName/src/utils/helpers.dart';

import '../../services/database_service.dart';

class AppStatistics extends StatefulWidget {
  const AppStatistics({Key? key}) : super(key: key);

  @override
  State<AppStatistics> createState() => _AppStatisticsState();
}

class _AppStatisticsState extends State<AppStatistics> {
  int _finished = 0, _ongoing = 0, _waiting = 0;
  _getData() async {
    _finished = await db.getGamesNumber(DbGameState.GAMEOVER.name);
    _ongoing = await db.getGamesNumber(DbGameState.INGAME.name);
    _waiting = await db.getGamesNumber(DbGameState.WAITING.name);
    return _finished;
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                singleOverview(
                    Icons.videogame_asset_off, "FINISHED", _finished, null),
                const SizedBox(width: 20),
                singleOverview(Icons.play_circle, "ONGOING", _ongoing, null),
                const SizedBox(width: 20),
                singleOverview(Icons.timelapse, "WAITING", _waiting, null),
              ]);
        } else {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                singleOverview(
                    Icons.videogame_asset_off, "FINISHED",  null, CircularProgressIndicator()),
                const SizedBox(width: 20),
                singleOverview(Icons.play_circle, "ONGOING", null, CircularProgressIndicator()),
                const SizedBox(width: 20),
                singleOverview(Icons.timelapse, "WAITING",  null, CircularProgressIndicator() ),
                ]
          );
        }
      },
    );
  }

  Column singleOverview(IconData icon, String text, int? value, CircularProgressIndicator? widget) {
    return widget == null?  Column(children: [Icon(icon), Text(text), Text(value.toString())]) : Column(children: [Icon(icon), Text(text), widget]);
  }
}
