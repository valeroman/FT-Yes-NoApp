import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// ChangeNotifier => Puede notificar cuando hay cambios
class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYeaNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola amore!', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me)
  ];

  // Metodos
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      herReply();
    }

    // Hey flutter algo del provider comabio, notifica a todos quienes esten escuchando
    notifyListeners();
    moveScrollBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYeaNoAnswer.getAnswer();
    messageList.add(herMessage);

    notifyListeners();
    moveScrollBottom();
  }

  Future<void> moveScrollBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
