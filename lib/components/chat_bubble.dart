import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final Decoration decoration;
  final MainAxisAlignment mainAxisAligement;
  final Timestamp timestamp;
  const ChatBubble({
    super.key,
    required this.message,
    required this.decoration,
    required this.mainAxisAligement,
    required this.timestamp,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  void dispose() {
    super.dispose();
  }

  String time = "";
  @override
  Widget build(BuildContext context) {
    Widget messageBox = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: const EdgeInsets.all(12),
      decoration: widget.decoration,
      child: Text(
        widget.message,
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
    Widget timeBox = Text(
      time,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 13,
      ),
    );
    List<Widget> items = [];
    if (widget.mainAxisAligement == MainAxisAlignment.start) {
      items.add(messageBox);
      items.add(const SizedBox(width: 10));
      items.add(Container(child: timeBox));
    } else {
      items.add(Container(child: timeBox));
      items.add(const SizedBox(width: 10));
      items.add(messageBox);
    }

    if (widget.timestamp.toDate().difference(DateTime.now()).inDays == 0) {}

    String hour = widget.timestamp.toDate().hour.toString();
    if (hour.length == 1) {
      hour = "0$hour";
    }
    String minute = widget.timestamp.toDate().minute.toString();
    if (minute.length == 1) {
      minute = "0$minute";
    }

    int weekdayIndex = widget.timestamp.toDate().weekday;
    List weekdays = [
      "fill",
      "Mon.",
      "Tue.",
      "Wen.",
      "Thu.",
      "Fri.",
      "Sat.",
      "Sun."
    ];
    String weekday = weekdays[weekdayIndex];

    return SizedBox(
      // color: Colors.amber,
      child: GestureDetector(
        onLongPress: () async {
          setState(() {
            if (widget.timestamp.toDate().difference(DateTime.now()).inDays ==
                0) {
              time = "$hour:$minute";
              // time = "$weekday at $hour:$minute";
            } else {
              debugPrint(widget.timestamp.toDate().toString());
              time = "$weekday at $hour:$minute";
            }
            // time = "11:34";
          });
          debugPrint("time is $time");
          await Future.delayed(const Duration(seconds: 3), () {});
          if (mounted) {
            setState(() {
              time = "";
            });
            debugPrint("empty again");
          }
        },
        child: Row(
          mainAxisAlignment: widget.mainAxisAligement,
          // children: [
          //   Container(
          //     constraints: BoxConstraints(
          //       maxWidth: MediaQuery.of(context).size.width * 0.7,
          //     ),
          //     padding: const EdgeInsets.all(12),
          //     decoration: widget.decoration,
          //     child: Text(
          //       widget.message,
          //       style: const TextStyle(fontSize: 15, color: Colors.white),
          //     ),
          //   ),
          // ],
          children: items,
        ),
      ),
    );
  }
}
