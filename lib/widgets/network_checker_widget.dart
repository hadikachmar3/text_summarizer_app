import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/network_status_service.dart';

class NetworkCheckerWidget extends StatefulWidget {
  const NetworkCheckerWidget({super.key});

  @override
  State<NetworkCheckerWidget> createState() => _NetworkCheckerWidgetState();
}

class _NetworkCheckerWidgetState extends State<NetworkCheckerWidget> {
  bool wasOffline = false;
  String message = 'Network Offline';

  @override
  Widget build(BuildContext context) {
    final networkStatus = Provider.of<NetworkStatus>(context);
    double height;

    if (networkStatus == NetworkStatus.Online && wasOffline) {
      message = 'Back Online';
      height = 20.0;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            height = 0.0;
            message = 'Back Online';
          });
        });
      });

      wasOffline = false;
    } else if (networkStatus == NetworkStatus.Offline) {
      height = 20.0;
      message = 'Network Offline';
      wasOffline = true;
    } else {
      height = 0.0;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height,
      color: networkStatus == NetworkStatus.Offline ? Colors.red : Colors.green,
      child: Center(
        child: FittedBox(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
