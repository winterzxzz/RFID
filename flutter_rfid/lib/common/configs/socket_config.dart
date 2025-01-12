import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketConfig {
  static io.Socket socket = io.io(
      'https://b712-1-55-254-106.ngrok-free.app',
      io.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());
}
