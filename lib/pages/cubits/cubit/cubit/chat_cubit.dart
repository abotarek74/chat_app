import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  void sendMessage({required String message, required String email}) {
    messages
        .add({kMessage: message, kCreatedAt: DateTime.now(), 'id': 'email'});
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: false).snapshots().listen(
      (event) {
        emit(ChatSuccess());
      },
    );
  }
}
