import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannelApp extends StatefulWidget {
  const PlatformChannelApp({super.key});

  @override
  State<PlatformChannelApp> createState() => _PlatformChannelAppState();
}

class _PlatformChannelAppState extends State<PlatformChannelApp> {
  dynamic betteryLevel = 0;

  dynamic additionResult = 0;

  static const methodChannelPlatform =
      MethodChannel("app.id.com/my_channel_name");

  void _invokeAddNumbers() async {
    dynamic returnValue = await methodChannelPlatform
        .invokeMethod("addnumbers", <String, dynamic>{
      'n1': 50,
      'n2': 10,
    });
    setState(() {
      additionResult = returnValue;
    });
  }

  void _invokeGetBatteryLevel() async {
    dynamic batLevel =
        await methodChannelPlatform.invokeMethod('getbatterylevel');
    setState(() {
      betteryLevel = batLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platform channels App"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              additionResult.toString(),
            ),
            ElevatedButton(
                onPressed: _invokeAddNumbers,
                child: const Text("Invoke Method Channel")),
            Text(
              betteryLevel.toString(),
            ),
            ElevatedButton(
                onPressed: _invokeGetBatteryLevel,
                child: const Text("Invoke Method Channel"))
          ],
        ),
      ),
    );
  }
}
