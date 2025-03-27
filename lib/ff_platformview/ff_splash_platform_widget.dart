import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


class PlatformSplashWidget extends StatefulWidget {

  PlatformSplashWidget({Key? key}) : super(key: key);

  @override
  _PlatformSplashWidgetState createState() => _PlatformSplashWidgetState();
}

class _PlatformSplashWidgetState extends State<PlatformSplashWidget> {
  @override
  Widget build(BuildContext context) {
    if(defaultTargetPlatform == TargetPlatform.android) {
      return PlatformViewLink(
        viewType: 'ff_splash_platform_view',
        surfaceFactory: (
            BuildContext context,
            PlatformViewController controller,
            ) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (PlatformViewCreationParams params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: 'ff_splash_platform_view',
            layoutDirection: TextDirection.ltr,
            creationParams: {},
            creationParamsCodec: const StandardMessageCodec(),
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      );
    } else {
      return Text("Unsupported platform");
    }
  }
}


