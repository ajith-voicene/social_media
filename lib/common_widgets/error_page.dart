import 'package:flutter/material.dart';
import 'package:social_media/common_widgets/common_button.dart';



class ErrorPage extends StatelessWidget {
   final String title;
   final String subtitle;
   final VoidCallback onRetry;

  const ErrorPage({Key key, this.title, this.subtitle, this.onRetry}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      color: Colors.blue.withOpacity(0.5),
      // padding: EdgeInsets.symmetric(horizontal: context.blockSizeVertical * 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset(
          //   ImageResPng.connectionError,
          //   // height: context.blockSizeHorizontal * 10,
          // ),
          SizedBox(height: 8),
          FittedBox(
            child: Text(
              title ?? "Connection Error",
              style: themeData.textTheme.headline6
                  .copyWith(color: Colors.black),
            ),
          ),
          Text(
            subtitle ??
                "You are not connected to internet it seems Please check your internet connection",
            textAlign: TextAlign.center,
            style: themeData.textTheme.bodyText1.copyWith(
                color: Colors.black,
                shadows: [Shadow(color: Colors.white60, blurRadius: 4)]),
          ),
         
            
          CommonButton(onPressed: onRetry, label: "Try Again",),
        ],
      ),
    );
  }
}
