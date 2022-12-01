
import 'package:festival_frame/text_edit/edit_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComponentLayer extends StatelessWidget {
  const ComponentLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPhotoCubit, EditPhotoState>(
      buildWhen: (p, c) {
        return p.opacityLayer != c.opacityLayer || p.widgets != c.widgets;
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            /// opacity layer
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(state.opacityLayer),
              ),
            ),

            ///
            for (var i = 0; i < state.widgets.length; i++)
              Align(
                key: UniqueKey(),
                alignment: Alignment.center,
                child: state.widgets[i],
              ),
          ],
        );
      },
    );
  }
}
