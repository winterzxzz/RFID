import 'package:flutter_rfid/common/configs/app_configs.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketConfig {
  static io.Socket socket = io.io(
      AppConfigs.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());
}
