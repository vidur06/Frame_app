// ignore_for_file: sort_child_properties_last, unnecessary_this

import 'dart:typed_data';

import 'package:festival_frame/widgets/stickerImage.dart';
import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class StickIt extends StatefulWidget {
  StickIt({
    Key? key,
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
    // ignore: use_named_constants
    this.viewport = const Size(0.0, 0.0),
  }) : super(key: key);

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
    final Future<Uint8List> exportImage = _stickItState._exportImage();
    return exportImage;
  }

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _StickItState createState() => _stickItState;
}

class _StickItState extends State<StickIt> {
  _StickItState();

  final GlobalKey key = GlobalKey();
  final List<StickerImage> _attachedList = [];
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
                        // ignore: use_named_constants
                        if (_viewport == const Size(0.0, 0.0)) {
                          _viewport =
                              Size(constraints.maxWidth, constraints.maxHeight);
                        }
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
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 500),
          child: Scrollbar(
            child: DragTarget(
              builder: (
                BuildContext context,
                candidateData,
                List<dynamic> rejectedData,
              ) {
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
                          decoration: BoxDecoration(
                            color: this.widget.panelStickerBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                      childAspectRatio: this.widget.panelStickerAspectRatio,
                    ),
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
      _attachedList.add(
        StickerImage(
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
        ),
      );
    });
  }

  Future<Uint8List> _exportImage() async {
    final bytes = await controller.capture();
    return bytes!;
  }

  void _onTapRemoveSticker(sticker) {
    setState(() {
      this._attachedList.removeWhere((s) => s.key == sticker.key);
    });
  }

  Future<void> _prepareExport() async {
    // ignore: avoid_function_literals_in_foreach_calls
    _attachedList.forEach((s) {
      s.prepareExport();
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
