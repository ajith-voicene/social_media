import 'package:flutter/material.dart';
import 'package:social_media/common_widgets/videoPlaterCard.dart';
import 'package:social_media/model/home_models.dart';

class SingleView extends StatefulWidget {
  final Data data;
  const SingleView(this.data, {Key key}) : super(key: key);

  @override
  _SingleViewState createState() => _SingleViewState();
}

class _SingleViewState extends State<SingleView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                    child: (widget.data.firstAttachmentType == "image/jpeg")
                        ? InteractiveViewer(
                            minScale: .4,
                            child: Image.network(widget.data.firstAttachmentUrl,
                                // width: 300,
                                // height: 300,
                                fit: BoxFit.contain),
                          )
                        : (widget.data.firstAttachmentType == "video/mp4")
                            ? Container(
                                child: VideoPlayCard(
                                    widget.data.firstAttachmentUrl))
                            : Container(
                                height: 0,
                              )))));
  }
}
