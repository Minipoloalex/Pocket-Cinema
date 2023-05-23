import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/comment.dart';
import 'package:pocket_cinema/model/string_capitalize.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.username ?? 'Anonymous',
            style: const TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 233, 69, 96),
            ),
          ),
          Text(
              comment.content,
              style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 4),
          Text(
            timeago.format(comment.createdAt.toDate()).capitalize(),
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
