import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketConfig {
  static io.Socket socket = io.io(
      'https://40c9-1-52-222-105.ngrok-free.app',
      io.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());
}
