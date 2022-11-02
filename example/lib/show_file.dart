import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowFileScreen extends StatefulWidget {
  final String urlFile;
  const ShowFileScreen({Key? key, required this.urlFile}) : super(key: key);

  @override
  State<ShowFileScreen> createState() => _ShowFileScreenState();
}

class _ShowFileScreenState extends State<ShowFileScreen> {
  final UniqueKey _key = UniqueKey();
  final Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Show title'),
        ),
      ),
      body: WebView(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        key: _key,
        gestureRecognizers: _gestureRecognizers,
        initialUrl:
            'https://docs.google.com/gview?embedded=true&url=${widget.urlFile}',
        gestureNavigationEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {},
      ),
    );
  }
}
