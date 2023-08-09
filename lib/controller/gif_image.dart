import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

class GifImages extends StatefulWidget {
  final double? width;
  const GifImages({Key? key, this.width}) : super(key: key);

  @override
  State<GifImages> createState() => _GifImagesState();
}

class _GifImagesState extends State<GifImages> with TickerProviderStateMixin {
  late FlutterGifController controller;

  @override
  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this);
    controller.repeat(
      min: 0,
      max: 18,
      period: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GifImage(
      controller: controller,
      image: const AssetImage('assets/gif/loading.gif'),
      width: widget.width ?? 64,
      color: Colors.black,
    );
  }
}
