import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class RetryWidget extends StatelessWidget {
  final String? message;
  final VoidCallback callback;
  final TextStyle? style;

  const RetryWidget.withMessage({
    Key? key,
    this.message,
    required this.callback,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                message ?? S.of(context).errorText,
                textAlign: TextAlign.center,
                style: style,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: 52,
              width: screenSize.width,
              child: ElevatedButton(

                onPressed: () {
                  callback();
                },
                child:  Text(S.of(context).retry),

              ),
            ),
          ),
        )
      ],
    );
  }
}
