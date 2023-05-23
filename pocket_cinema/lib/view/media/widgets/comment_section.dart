import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/common_widgets/comment_and_list_form.dart';
import 'package:pocket_cinema/view/common_widgets/error_widget.dart';
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
      FirestoreDatabase().addComment(widget.mediaID, text, FirebaseAuth.instance.currentUser!.uid);
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
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child:Text(
          "Comments",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        ),
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
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                children: data
                    .map((comment) => CommentWidget(comment: comment))
                    .toList(),
              );
            },
            loading: () => Container(),
            error: (error, stack) {
              Logger().e(error);
              return ErrorOccurred(error: error);
            },
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: CommentAndListForm(
              controller: _controller,
              focusNode: _node,
              handleSubmit: _handleSubmit,
              onTapOutside: (_) => _node.unfocus(),
              paddingLeft: 20,
              maxLines: 4,
              suffixIcon: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.send),
                onPressed: () {
                  _handleSubmit(_controller.text);
                },
              ),
            )),
      ],
    );
  }
}
