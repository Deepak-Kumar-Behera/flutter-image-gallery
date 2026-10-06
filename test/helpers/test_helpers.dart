import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void mockFluttertoastChannel() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('PonnamKarthik/fluttertoast');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    channel,
    (call) async => null,
  );
}
