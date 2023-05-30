import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:replaceAppName/src/utils/helpers.dart';

import '../constants.dart';
import '../widgets/main_menu_widgets/buttons/button.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isVisible ? const Text("History") : const Text('Rules'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Column(
            children: [
              Visibility(
                visible: _isVisible,
                child: History(),
              ),
              Visibility(
                visible: !_isVisible,
                child: const Rules(),
              ),
              const SizedBox(height: 30),
              MenuButton(
                  text: _isVisible ? 'RULES' : 'BACK TO HISTORY',
                  handler: () => setState(() {
                        _isVisible = !_isVisible;
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  History({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      Image.asset(
        'assets/chahMat.jpg',
        height: 200,
      ),
      SizedBox(height: 30),
      Text(chessHistory),
      SizedBox(height: 30),
      Image.asset(
        'assets/chess-pieces.jpg',
        height: 100,
      ),
    ]);
  }
}

class Rules extends StatefulWidget {
  const Rules({super.key});

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  String _selected = gameRules[0]['name'] as String;
  bool _specialToShow = false;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.7;
    var _selectedElement;
    for (var element in gameRules) {
      if (element['name'] == _selected) {
        _selectedElement = element;
      }
    }
    return Column(children: [
      Row(
        children: [
          SizedBox(
              width: 30,
              child: Column(children: [
                for (var element in gameRules) ...[
                  SelectionButton(
                      location: 'assets/${element['name']}.svg',
                      handler: () => setState(() {
                            _selected = element['name'] as String;
                          }),
                      color: _selected == element['name']
                          ? Colors.blue
                          : Colors.grey),
                  SizedBox(
                    height: 5,
                  ),
                ]
              ])),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              width: c_width,
              child: Column(
                children: [
                  Visibility(
                    visible: _specialToShow,
                    child: Column(
                      children: [
                        _selectedElement!['SPECIAL'] != null
                            ? Column(
                                children: [
                                  Text(
                                    _selectedElement!['SPECIAL']['name']
                                        .toUpperCase(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    _selectedElement!['SPECIAL']['image']
                                        as String,
                                    height: 200,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(_selectedElement!['SPECIAL']['actions']
                                      as String),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () => setState(() {
                                                _specialToShow =
                                                    !_specialToShow;
                                              }),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                          ),
                                          child: Text('BACK'))
                                    ],
                                  )
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !_specialToShow,
                    child: Column(children: [
                      Text(
                        _selectedElement!['name'].toUpperCase(),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      //Some extra info
                      _selectedElement!['text'] != null
                          ? Text(_selectedElement!['text'] as String)
                          : Container(),
                      Image.asset(
                        _selectedElement!['image'] as String,
                        height: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(_selectedElement!['actions'] as String),
                      _selectedElement['SPECIAL'] != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('SPECIAL RULE:'),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () => setState(() {
                                          _specialToShow = !_specialToShow;
                                        }),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                    child: Text(
                                      _selectedElement['SPECIAL']['name']
                                          as String,
                                    ))
                              ],
                            ))
                          : Container()
                    ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ]);
  }
}

class SelectionButton extends StatelessWidget {
  final VoidCallback? handler;
  final String location;
  final Color color;

  const SelectionButton(
      {super.key,
      required this.location,
      required this.handler,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color,
      ),
      child: IconButton(
        icon: SvgPicture.asset(location),
        iconSize: 50,
        onPressed: handler,
      ),
    );
  }
}
