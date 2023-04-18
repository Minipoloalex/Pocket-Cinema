import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/search_provider.dart';

import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_cinema/view/media/widgets/comment_widget.dart';

class CommentSection extends ConsumerStatefulWidget {
  final String mediaID;
  const CommentSection({super.key, required this.mediaID});

  @override
  CommentSectionState createState() => CommentSectionState();
}

class CommentSectionState extends ConsumerState<CommentSection> {
  final TextEditingController _controller = TextEditingController();
  late FocusNode _node;

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Button');
    ref.refresh(commentsProvider(widget.mediaID)).value;
  }

  void _handleSubmit(String text) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirestoreDatabase.addComment(widget.mediaID, text);
    }
    _controller.clear();
    _node.unfocus();
    ref.refresh(commentsProvider(widget.mediaID)).value;
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentsProvider(widget.mediaID));

    return Column(
      children: [
        Expanded(
          child: comments.when(
            data: (data) {
              if (data.isEmpty) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("No comments yet..."),
                      const SizedBox(height: 2),
                      const Text("Begin the first discussion"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _node.requestFocus(),
                        child: const Text('Start discussion'),
                      ),
                    ]);
              }

              return ListView(
                children: data
                    .map((comment) => CommentWidget(comment: comment))
                    .toList(),
              );
            },
            loading: () => Container(),
            error: (error, stack) => Text(error.toString()),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
            child: Stack(
              children: [
                TextField(
                  focusNode: _node,
                  controller: _controller,
                  onSubmitted: _handleSubmit,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 1,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String value = _controller.text;
                      _handleSubmit(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
