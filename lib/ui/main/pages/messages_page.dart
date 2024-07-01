import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_drive/app_setup.dart';
import 'package:test_drive/data/models/conversation/conversation.dart';
import 'package:test_drive/ui/widgets/conversation_item_widget.dart';
import 'package:test_drive/ui/widgets/progress_ui.dart';

import '../../../service/exception/auth/auth_exception.dart';
import '../../widgets/toast_ui.dart';
import 'conversation_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  Future<List<Conversation>> getConversations(BuildContext context) async {
    final int id = AppSetup.me?.user?.id ?? 0; // Exemple d'ID utilisateur
    final List<Conversation> conversations = await AppSetup.conversationService
        .loadConversationsByCustomerId(id).catchError((error) {
          if (error is AuthException) {
              AppSetup.logout(context: context, onStartLoading: () {

              }, onCompleteLoading: () {

              });
        } else if (error is SocketException || error is ClientException) {
          ToastUi.showToast("error",
          "S'il vous plâit, veuillez vérifier votre connexion internet");
          } else if (error is ArgumentError) {

          } else if (error is Exception) {

          } else {
          ToastUi.showToast("error", error.message);
          }
        });
    return conversations;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conversation>>(
      future: getConversations(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Afficher un indicateur de chargement pendant le chargement des conversations
          return const ProgressUi();
        } else if (snapshot.hasError) {
          // Gérer les erreurs éventuelles
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Gérer le cas où il n'y a pas de conversations
          return const Center(child: Text('Aucune conversation trouvée.'));
        }

        // Afficher la liste des conversations une fois les données disponibles
        final List<Conversation> conversations = snapshot.data!;
        return ListView.builder(
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            return ConversationItemWidget(
              conversation: conversations[index],
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ConversationScreen(
                    conversation: conversations[index])));
            },);
          },
        );
      },
    );
  }
}
