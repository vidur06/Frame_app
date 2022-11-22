// ignore_for_file: sort_child_properties_last

import 'dart:typed_data';
import 'dart:ui';

import 'package:festival_frame/widgets/stickerImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
// import 'package:stick_it/src/sticker_image.dart';

/// [StickIt] creates a [Stack] view, consisting of
/// 1. the [child] provided as [Widget]
/// 2. a [List] of [Image]s called [stickerList].
///
/// The default behavior will allow the [Image]s to be added, scaled, rotated and deleted.
/// Sticker can be scaled within a customizable scale.
///
/// Calling the [exportImage] function will provide an [Uint8List],
/// that can be used to preview or further save the image + sticker composition.
///
/// See also:
///
///  * <https://github.com/myriky/flutter_simple_sticker_view>, which is the original project.
class StickIt extends StatefulWidget {
  StickIt(
      {Key? key,
      required this.child,
      required this.stickerList,
      this.devicePixelRatio = 3.0,
      this.panelHeight = 200.0,
      this.panelBackgroundColor = Colors.black,
      this.panelStickerBackgroundColor = Colors.white10,
      this.panelStickerCrossAxisCount = 4,
      this.panelStickerAspectRatio = 1.0,
      this.stickerRotatable = true,
      this.stickerSize = 100.0,
      this.stickerMaxScale = 2.0,
      this.stickerMinScale = 0.5,
      this.viewport = const Size(0.0, 0.0)})
      : super(key: key);

  final Widget child;

  final List<Image> stickerList;

  final double devicePixelRatio;

  final Color panelBackgroundColor;

  final double panelHeight;

  final Color panelStickerBackgroundColor;

  final int panelStickerCrossAxisCount;

  final double panelStickerAspectRatio;

  final double stickerMaxScale;

  final double stickerMinScale;

  final bool stickerRotatable;

  final double stickerSize;

  final Size viewport;

  final _StickItState _stickItState = _StickItState();

  Future<Uint8List> exportImage() async {
    await _stickItState._prepareExport();
    Future<Uint8List> exportImage = _stickItState._exportImage();
    return exportImage;
  }

  @override
  _StickItState createState() => _stickItState;
}

class _StickItState extends State<StickIt> {
  _StickItState();

  final GlobalKey key = GlobalKey();
  List<StickerImage> _attachedList = [];
  late Size _viewport;

  final keyText = GlobalKey();
  Size? size;
  Offset position = Offset.zero;
  
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  @override
  void initState() {
    _viewport = widget.viewport;
    super.initState();
    // calculateSizeAndPosition();
  }

  void calculateSizeAndPosition() =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox box =
            keyText.currentContext!.findRenderObject() as RenderBox;

        setState(() {
          position = box.localToGlobal(Offset.zero);
          size = box.size;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Expanded(
          child: WidgetsToImage(
            key: key,
            controller: controller,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  children: [
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (_viewport == const Size(0.0, 0.0))
                          _viewport =
                              Size(constraints.maxWidth, constraints.maxHeight);
                        return widget.child;
                      },
                    ),
                  ],
                ),
                Stack(
                  fit: StackFit.expand,
                  children: _attachedList,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 430, left: 180),
          child: Container(
            color: Colors.transparent,
            child: IconButton(
              key: keyText,
              onPressed: () {
                calculateSizeAndPosition();
                print('p.dx: ${position.dx}');
                print('p.dy: ${position.dy}');
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
            ),
            // Icon(
            //   Icons.delete,
            //   color: Colors.red,
            //   size: 30,
            // ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 500),
          child: Scrollbar(
            child: DragTarget(
              builder: (BuildContext context, candidateData,
                  List<dynamic> rejectedData) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: this.widget.panelBackgroundColor,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.stickerList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: this.widget.panelStickerBackgroundColor,
                          child: TextButton(
                            onPressed: () {
                              _attachSticker(widget.stickerList[i]);
                            },
                            child: widget.stickerList[i],
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: this.widget.panelStickerCrossAxisCount,
                        childAspectRatio: this.widget.panelStickerAspectRatio),
                  ),
                  height: this.widget.panelHeight,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _attachSticker(Image image) {
    setState(() {
      _attachedList.add(StickerImage(
        image,
        height: this.widget.stickerSize,
        key: Key("sticker_${_attachedList.length}"),
        maxScale: this.widget.stickerMaxScale,
        minScale: this.widget.stickerMinScale,
        onTapRemove: (sticker) {
          this._onTapRemoveSticker(sticker);
        },
        rotatable: this.widget.stickerRotatable,
        viewport: _viewport,
        width: this.widget.stickerSize,
      ));
    });
  }

  Future<Uint8List> _exportImage() async {
    final bytes = await controller.capture();
    return bytes!;
    // RenderRepaintBoundary boundary =
    //     key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // var image =
    //     await boundary.toImage(pixelRatio: this.widget.devicePixelRatio);
    // var byteData = await image.toByteData(format: ImageByteFormat.png);
    // var pngBytes = byteData!.buffer.asUint8List();
    // return pngBytes;
  }

  void _onTapRemoveSticker(sticker) {
    setState(() {
      this._attachedList.removeWhere((s) => s.key == sticker.key);
    });
  }

  Future<void> _prepareExport() async {
    _attachedList.forEach((s) {
      s.prepareExport();
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
