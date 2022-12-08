import 'package:festival_frame/text_edit/component_layer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import '../text_edit/add_text_layout.dart';
import '../text_edit/confirmation_dialog.dart';
import '../text_edit/dragable_widget.dart';
import '../text_edit/dragable_widget_child.dart';
import '../text_edit/edit_photo_cubit.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPhotoCubit(),
      child: const TextEditor(),
    );
  }
}

class TextEditor extends StatefulWidget {
  const TextEditor({super.key});

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
   FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    // ignore: unused_label
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }
  final controller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Text'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller
                  .capture(delay: const Duration(milliseconds: 10))
                  .then((capturedImage) async {
                Navigator.of(context)
                    .pushNamed("sticker", arguments: [capturedImage, res[1]]);
              }).catchError((onError) {
                // ignore: avoid_print
                print(onError);
              });
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: BlocListener<EditPhotoCubit, EditPhotoState>(
        listener: (context, state) {},
        child: Stack(
          children: [
            Screenshot(
              controller: controller,
              child: Container(
                height: 450,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(res[0]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const ComponentLayer()
                  ],
                ),
              ),
            ),
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(top: 450),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 450, left: 170),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      context
                          .read<EditPhotoCubit>()
                          .changeEditState(EditState.addingText);

                      final result = await addText(context);

                      if (result == null ||
                          result is! DragableWidgetTextChild) {
                        if (!mounted) return;
                        context
                            .read<EditPhotoCubit>()
                            .changeEditState(EditState.idle);
                        return;
                      }

                      final widget = DragableWidget(
                        widgetId: DateTime.now().millisecondsSinceEpoch,
                        child: result,
                        onPress: (id, widget) async {
                          if (widget is DragableWidgetTextChild) {
                            context
                                .read<EditPhotoCubit>()
                                .changeEditState(EditState.addingText);

                            final result = await addText(
                              context,
                              widget,
                            );

                            if (result == null ||
                                result is! DragableWidgetTextChild) {
                              if (!mounted) return;
                              context
                                  .read<EditPhotoCubit>()
                                  .changeEditState(EditState.idle);
                              return;
                            }

                            if (!mounted) return;
                            context
                                .read<EditPhotoCubit>()
                                .editWidget(id, result);
                          }
                        },
                        onLongPress: (id) async {
                          final result = await showConfirmationDialog(
                            context,
                            title: "Delete Text ?",
                            desc: "Are you sure want to Delete this text ?",
                            rightText: "Delete",
                          );
                          if (result == null) return;

                          if (result) {
                            if (!mounted) return;
                            context.read<EditPhotoCubit>().deleteWidget(id);
                          }
                        },
                      );

                      if (!mounted) return;
                      context.read<EditPhotoCubit>().addWidget(widget);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white70,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.text_fields,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      'Text',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 450, left: 180),
            //   child: IconButton(
            //     onPressed: () async {
            //       context
            //           .read<EditPhotoCubit>()
            //           .changeEditState(EditState.addingText);

            //       final result = await addText(context);

            //       if (result == null || result is! DragableWidgetTextChild) {
            //         if (!mounted) return;
            //         context
            //             .read<EditPhotoCubit>()
            //             .changeEditState(EditState.idle);
            //         return;
            //       }

            //       final widget = DragableWidget(
            //         widgetId: DateTime.now().millisecondsSinceEpoch,
            //         child: result,
            //         onPress: (id, widget) async {
            //           if (widget is DragableWidgetTextChild) {
            //             context
            //                 .read<EditPhotoCubit>()
            //                 .changeEditState(EditState.addingText);

            //             final result = await addText(
            //               context,
            //               widget,
            //             );

            //             if (result == null ||
            //                 result is! DragableWidgetTextChild) {
            //               if (!mounted) return;
            //               context
            //                   .read<EditPhotoCubit>()
            //                   .changeEditState(EditState.idle);
            //               return;
            //             }

            //             if (!mounted) return;
            //             context.read<EditPhotoCubit>().editWidget(id, result);
            //           }
            //         },
            //         onLongPress: (id) async {
            //           final result = await showConfirmationDialog(
            //             context,
            //             title: "Delete Text ?",
            //             desc: "Are you sure want to Delete this text ?",
            //             rightText: "Delete",
            //           );
            //           if (result == null) return;

            //           if (result) {
            //             if (!mounted) return;
            //             context.read<EditPhotoCubit>().deleteWidget(id);
            //           }
            //         },
            //       );

            //       if (!mounted) return;
            //       context.read<EditPhotoCubit>().addWidget(widget);
            //     },
            //     icon: const Icon(Icons.text_fields),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
