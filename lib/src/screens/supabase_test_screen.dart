import 'package:flutter/material.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:replaceAppName/src/services/database_service.dart';

class SupabaseTestScreen extends StatefulWidget {
  const SupabaseTestScreen({Key? key}) : super(key: key);

  @override
  State<SupabaseTestScreen> createState() => _FireBaseTestScreenState();
}

class _FireBaseTestScreenState extends State<SupabaseTestScreen> {
  final database_controller = TextEditingController();
  final DatabaseService service = DatabaseService(db.client); //client from App

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SUPABASE_TEST_SCREEN"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(60),
              color: Colors.grey,
              child: TextField(controller: database_controller),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("send to supabase database"),
                IconButton(
                    onPressed: () async {
                      printGreen('OLEN SIIN');
                      final message = database_controller.text;
                      try {
                        await Supabase.instance.client
                            .from('test')
                            .upsert({'messages': message, 'author_id': 3});
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Saved '),
                          ));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Error saving '),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    icon: const Icon(Icons.send)),
              ],
            ),
            StreamBuilder(
                stream: service.createStream(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    // case ConnectionState.done: // STREAM IS NEVER DONE
                    default:
                      if (snapshot.hasData) return Text(snapshot.data.toString());
                      if (snapshot.hasError) return Text('${snapshot.error}');
                      return Text("DEFAULT");
                  }
                })
          ],
        ),
      ),
    );
  }
}

class DatabaseService {
  final SupabaseClient client;

  DatabaseService(this.client);

  void listenToChatMessages(String message, int userId) async {
    // client.channel('public:test').on(
    //   RealtimeListenTypes.postgresChanges,
    //   ChannelFilter(event: '*', schema: '*'),
    //   (payload, [ref]) {
    //     // Handle realtime payload
    //     printGreen(payload);
    //     printGreen(ref);
    //     printGreen('OLEN SIIN 333');
    //   },
    // ).subscribe();
  }

  Stream createStream() {
    return client.from('test').stream(primaryKey: ['id']);
  }
}
