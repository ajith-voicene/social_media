import 'package:flutter/material.dart';

class CommonAvatar extends StatelessWidget {
  final String url;
  final double size;
  final VoidCallback onClick;
  const CommonAvatar({Key key, this.url, this.size = 25, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: CircleAvatar(
        radius: size,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(url ??
            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fyorktonrentals.com%2Fagents%2Fbtmak%2F&psig=AOvVaw1RnEw9nyaxoU0WDIGgrSa4&ust=1623850952982000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPDK_6rimfECFQAAAAAdAAAAABAR"),
      ),
    );
  }
}
