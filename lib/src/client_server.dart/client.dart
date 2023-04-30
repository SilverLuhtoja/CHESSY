import 'dart:io';
import 'dart:typed_data';
import '../utils/helpers.dart';

class ClientSocket {
  final int PORT;
  final String LOCALHOST = '10.0.2.2';

  late Socket socket;

  ClientSocket(this.PORT) {}

  void initializeConnection() async {
    print("WAITING CONNECTION");
    await attemptConnect();

    print(
        "Client: Connected to ${socket.remoteAddress.address}:${socket.remotePort}");

    socket.listen((Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      printGreen(serverResponse);
    }, onError: (error) {
      printError("Client :$error");
      socket.destroy();
    }, onDone: () {
      printError("Client: Server closed");
      socket.destroy();
    });

    sendMessage("Silver");
  }

  Future<void> attemptConnect() async {
    socket = await Socket.connect(LOCALHOST, PORT)
        .timeout(const Duration(seconds: 2), onTimeout: () async {
      printError(
          "Failed to establish connection. Is connecting server running ?");
      return Future.value(null);
    });
  }

  Future<void> sendMessage(String message) async {
    socket.write(message);
  }
}

ClientSocket client = ClientSocket(4000);
