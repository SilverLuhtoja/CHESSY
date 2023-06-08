import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/providers/util_provider.dart';
import 'package:replaceAppName/src/services/username_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';

class UsernameContainer extends StatefulWidget {
  const UsernameContainer({super.key});

  @override
  State<UsernameContainer> createState() => _UsernameContainerState();
}

class _UsernameContainerState extends State<UsernameContainer> {

  var wantToChange = false;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Visibility(
        visible: wantToChange,
        child: NameChangeInput(onStateChanged: (value) => setState(() {
          wantToChange = value; 
        })),
      ),
        Visibility(
        visible: !wantToChange,
        child: NameDisplay(onStateChanged: (value) => setState(() {
          wantToChange = value; 
        }),)
        )
    ]);
  }
}

class UsernameButton extends StatelessWidget {
  final VoidCallback? handler;
  final String text;

  const UsernameButton({super.key, required this.text, required this.handler});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: handler,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, padding: EdgeInsets.all(5)),
        child: Text(text));
  }
}

class NameChangeInput extends StatelessWidget {
  final ValueChanged<bool> onStateChanged;

    NameChangeInput({super.key, required this.onStateChanged});
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 150,
        child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Change your username:',
            )),
      ),
      UsernameButton(
          handler: () async {
            await saveUsername(nameController.text);
            onStateChanged(false);
          },
          text: 'save'),
    ]);
  }
}

class NameDisplay extends StatefulWidget {
  final ValueChanged<bool> onStateChanged;
  NameDisplay({super.key, required this.onStateChanged});

  @override
  State<NameDisplay> createState() => _NameDisplayState();
}

class _NameDisplayState extends State<NameDisplay> {
  _getName() async {
    return await getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getName(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Row(children: [
              Text(snapshot.data),
              const SizedBox(
                width: 30,
              ),
              UsernameButton(handler: () => widget.onStateChanged(true), text: 'change')
            ]);
          } else {
            return Text('loading...');
          }
        });
  }
}
