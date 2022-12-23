import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget {
  final String title;
  final String content;
  final dynamic height;
  final dynamic width;
   CommonListTile({super.key,required this.title,required this.content,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:  Text(title),
                content: Container(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      title:  Text(
        title,
        style:const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
