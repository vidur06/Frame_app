import 'package:festival_frame/widgets/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class RateDialog extends StatelessWidget {
  const RateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: 1.0,
      title: const Text(
        'Rate Us',
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
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        StoreRedirect.redirect(
          androidAppId: 'com.example.festival_frame',
          iOSAppId: 'com.example.festivalFrame',
        );
      },
    );
  }
}
