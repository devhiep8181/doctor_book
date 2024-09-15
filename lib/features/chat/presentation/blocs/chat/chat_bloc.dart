import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatInit>(_onChatInit);
  }

  FutureOr<void> _onChatInit(ChatInit event, Emitter<ChatState> emit) async {

    // FirebaseFirestore.instance
    //     .collection("chat")
    //     .doc('anhdz@gmail.comdoctor1@gmail.com')
    //     .collection("message")
    //     .orderBy('timestamp', descending: false)
    //     .snapshots();
  
     FirebaseFirestore.instance.collection("chat").get().then((querySnapshot) {
 
      querySnapshot.docs.forEach((result) {
        log('===============>${result.id}');
      });
    });
  }
}
