library rating_dialog;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDialog extends StatefulWidget {

  final Text title;
  final Text? message;
  final Widget? image;
  final Color starColor;
  final double starSize;
  final bool force;
  final bool showCloseButton;
  final double initialRating;
  final bool enableComment;
  final String commentHint;
  final String submitButtonText;
  final TextStyle submitButtonTextStyle;
  final Function(RatingDialogResponse) onSubmitted;
  final Function? onCancelled;

  const RatingDialog({
    required this.title,
    this.message,
    this.image,
    required this.submitButtonText,
    this.submitButtonTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
    required this.onSubmitted,
    this.starColor = Colors.amber,
    this.starSize = 40.0,
    this.onCancelled,
    this.showCloseButton = true,
    this.force = false,
    this.initialRating = 0,
    this.enableComment = true,
    this.commentHint = 'Tell us your comments',
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final _commentController = TextEditingController();
  RatingDialogResponse? _response;

  @override
  void initState() {
    super.initState();
    _response = RatingDialogResponse(rating: widget.initialRating);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _content = Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                widget.image != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 25),
                        child: widget.image,
                      )
                    : Container(),
                widget.title,
                const SizedBox(height: 15),
                widget.message ?? Container(),
                const SizedBox(height: 10),
                Center(
                  child: RatingBar.builder(
                    initialRating: widget.initialRating,
                    glowColor: widget.starColor,
                    minRating: 0,
                    itemSize: widget.starSize,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding:const EdgeInsets.symmetric(horizontal: 3),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _response!.rating = rating;
                      });
                    },
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: widget.starColor,
                    ),
                  ),
                ),
                widget.enableComment
                    ? TextField(
                        controller: _commentController,
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: widget.commentHint,
                        ),
                      )
                    : const SizedBox(height: 15),
                TextButton(
                  onPressed: _response!.rating == 0
                      ? null
                      : () {
                          if (!widget.force) Navigator.pop(context);
                          _response!.comment = _commentController.text;
                          widget.onSubmitted.call(_response!);
                        },
                  child: Text(
                    widget.submitButtonText,
                    style: widget.submitButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!widget.force &&
            widget.onCancelled != null &&
            widget.showCloseButton) ...[
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () {
              Navigator.pop(context);
              widget.onCancelled!.call();
            },
          )
        ]
      ],
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      title: _content,
    );
  }
}

class RatingDialogResponse {
  String comment;

  double rating;

  RatingDialogResponse({this.rating = 0.0, this.comment = ''});
}
