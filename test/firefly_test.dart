import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firefly/firefly.dart';

void main() {
  const MethodChannel channel = MethodChannel('firefly');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Firefly.platformVersion, '42');
  });
}
