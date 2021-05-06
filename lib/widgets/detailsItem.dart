import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:quizti/widgets/pinchZoom.dart';

class DetailsItem extends StatelessWidget {
  final Map item;
  final bool bigFont;

  DetailsItem(this.item, {this.bigFont: false});
  @override
  Widget build(BuildContext context) {
    item['text'] == "" ? item['text'] = null : item['text'] = item['text'];
    item['img'] == "" ? item['img'] = null : item['img'] = item['img'];
    item['latex'] == "" ? item['latex'] = null : item['latex'] = item['latex'];

    // item['latex'] = null;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //item text
          item['text'] != null
              ? Text(item['text'].toString(),
                  style: TextStyle(fontSize: bigFont ? 20 : 16))
              : SizedBox(),
          SizedBox(height: 4),
          //item img
          item['img'] != null
              ? Center(
                  child: PinchZoomImage(
                      image: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                              imageUrl: item['img'],
                              placeholder: (context, url) =>
                                  LinearProgressIndicator(
                                      backgroundColor: Colors.deepPurple),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error)))))
              : SizedBox(),
          //item latex
          item['latex'] != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Math.tex(item['latex'],
                        mathStyle: MathStyle.text,
                        textStyle: TextStyle(fontSize: bigFont ? 22 : 18)),
                  ),
                )
              : SizedBox(),
        ]);
  }
}
