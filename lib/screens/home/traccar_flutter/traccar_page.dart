import 'package:addrive/global/imports/app_imports.dart';
import 'package:traccar_flutter/entity/traccar_configs.dart';
import 'package:traccar_flutter/traccar_flutter.dart';

class TraccarPage extends StatefulWidget {
  const TraccarPage({super.key});

  @override
  State<TraccarPage> createState() => _TraccarPageState();
}

class _TraccarPageState extends State<TraccarPage> {
  final _traccarFlutterPlugin = TraccarFlutter();
  bool isServiceStarted = false;
  String? traccingMessage;
  TextEditingController controller = TextEditingController();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState(String deviceId) async {
    traccingMessage = await _traccarFlutterPlugin.initTraccar();
    traccingMessage = await _traccarFlutterPlugin.setConfigs(TraccarConfigs(
      deviceId: deviceId,
      serverUrl: "http://161.35.56.189:8082/",
      interval: 10000,
      distance: 5,
      angle: 10,
      accuracy: AccuracyLevel.medium,
      offlineBuffering: true,
      wakelock: true,
      notificationIcon: 'ic_notification',
    ));

    setState(() {});
  }

  @override
  void initState() {
    initPlatformState('499432');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Traccar Message: \n\n ${traccingMessage ?? '-'}',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headlineMedium),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              _traccarFlutterPlugin.showStatusLogs();
            },
            child: const Icon(Icons.screenshot_monitor),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _toggleService,
            child: Icon(isServiceStarted ? Icons.stop : Icons.play_arrow),
          ),
        ],
      ),
    );
  }

  _toggleService() async {
    try {
      String? result;
      if (isServiceStarted) {
        result = await _traccarFlutterPlugin.stopService();
      } else {
        result = await _traccarFlutterPlugin.startService();
      }
      setState(() {
        traccingMessage = result;
        isServiceStarted = !isServiceStarted;
      });
    } catch (e) {
      setState(() {
        traccingMessage = e.toString();
      });
    }
  }
}
