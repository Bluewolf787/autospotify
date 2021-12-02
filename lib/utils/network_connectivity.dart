import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkConnectivity {
  
  StreamController<DataConnectionStatus> streamController = StreamController<DataConnectionStatus>();
  
  NetworkConnectivity() {
    DataConnectionChecker().onStatusChange.listen((connectionStatus) {
      streamController.add(connectionStatus);
    });
  }

}