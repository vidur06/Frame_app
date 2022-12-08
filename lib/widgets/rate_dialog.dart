import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';

class RateDialog extends StatelessWidget {
  const RateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
    initialRating: 1.0,
    title: const Text(
      'Rating Dialog',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    message: const Text(
      'Tap a star to set your rating. Add more description here if you want.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
    image: const FlutterLogo(size: 100),
    submitButtonText: 'Submit',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');
      if (response.rating < 3.0) {
      } else {
        StoreRedirect.redirect(
            androidAppId: 'shri.complete.fitness.gymtrainingapp',
            iOSAppId: 'com.example.festivalFrame');
      }
    },
  );
  }
}