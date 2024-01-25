import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusServiceProvider {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusServiceProvider() {
    Connectivity().onConnectivityChanged.listen((status) {
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }
}

/**import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/network_status_service.dart';

class NetworkCheckerWidget extends StatefulWidget {
  const NetworkCheckerWidget({super.key}) : super(key: key);

  @override
  _NetworkCheckerWidgetState createState() => _NetworkCheckerWidgetState();
}

class _NetworkCheckerWidgetState extends State<NetworkCheckerWidget> {
  bool wasOffline = false;

  @override
  Widget build(BuildContext context) {
    final networkStatus = Provider.of<NetworkStatus>(context);

    if (networkStatus.name == NetworkStatus.Online.name && wasOffline) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showToast(context, 'Network Online');
      });
      wasOffline = false;
    } else if (networkStatus.name == NetworkStatus.Offline.name) {
      wasOffline = true;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: networkStatus.name == NetworkStatus.Offline.name ? 50.0 : 0.0,
      color: Colors.red,
      child: Center(
        child: Text(
          'Network Offline',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 24.0,
      left: 16.0,
      right: 16.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 50.0,
        color: Colors.green,
        child: Center(
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context)?.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
 */
