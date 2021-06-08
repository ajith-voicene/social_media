import 'package:flutter/material.dart';

class CommonFullProgressIndicator extends StatelessWidget {
  CommonFullProgressIndicator({
    Key key,
    this.message = "Loading",
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder<String>(
              future: Future.delayed(
                Duration(seconds: 4),
                () => _lateLoadingMessage,
              ),
              initialData: "",
              builder: (context, snapshot) => Text(
                snapshot.data,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black.withOpacity(0.75)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// We're trying to connect to the Justice-Tracker network but it looks like it's taking longer than usual. Please give us a little more time.
const _lateLoadingMessage =
    "We're trying to connect to the Justice-Tracker network but it looks like it's taking longer than usual. Please give us a little more time.";
