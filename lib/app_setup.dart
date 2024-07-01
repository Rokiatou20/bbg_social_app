import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/data/database/database_helper.dart';
import 'package:test_drive/data/models/session/session.dart';
import 'package:test_drive/data/models/conversation/conversation.dart';
import 'package:test_drive/data/storage/database_source.dart';
import 'package:test_drive/service/auth/auth_service.dart';
import 'package:test_drive/service/auth/auth_service_impl.dart';
import 'package:test_drive/service/conversation/conversation_service.dart';
import 'package:test_drive/service/conversation/conversation_service_impl.dart';
import 'package:test_drive/service/message/message_service.dart';
import 'package:test_drive/service/message/message_service_impl.dart';
import 'package:test_drive/service/upload/azure/azure_image_storage_service.dart';
import 'package:test_drive/service/upload/imgur/imgur_service.dart';
import 'package:test_drive/service/upload/upload_image_service.dart';
import 'package:test_drive/service/user/user_service.dart';
import 'package:test_drive/service/user/user_service_impl.dart';
import 'package:test_drive/ui/auth/login_page.dart';
import 'package:test_drive/ui/main/main_screen.dart';

import 'configuration/token_manager.dart';
import 'data/storage/local_storage_service.dart';
import 'data/storage/shared_prefs.dart';

class AppSetup {

  static late AuthService authService;
  static late UserService userService;
  static late MessageService messageService;
  static late ConversationService conversationService;
  static late LocalStorageService localStorageService;
  static late UploadImageService uploadImageService;

  static Session? me;

  static init() async {


    try {

      authService = AuthServiceImpl();
      userService = UserServiceImpl();
      messageService = MessageServiceImpl();
      conversationService = ConversationServiceImpl();
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      // Open Database
      await DatabaseHelper.connection();
      localStorageService = await DatabaseSource.getInstance();
      // localStorageService = SharedPrefs(preferences);
      uploadImageService = ImgurService();

      // localStorageService.clear();

      me = localStorageService.getConnectedUser();

      print("AppSetup init()");
      print("AppSetup init() Session : $me");
    }
    catch (error) {
      print("AppSetup init() =>> $error");
    }

  }

  static Widget start(){

    me = localStorageService.getConnectedUser();

    print("AppSetup start() Session $me");

    if(me == null){
      return const LoginPage();
    }else{
      //Check token expiration
      print("Check token expiration");
      if(TokenManager.isExpired()){
        print("Token is expired");
        localStorageService.clear()
            .whenComplete((){
          print("Cache cleared");
        });
        return const LoginPage();
      }else{
        print("Token is not expired");
        return const MainScreen(title: "Bridge Bank Social");
      }
    }
  }

  static logout({required BuildContext context, required Function() onStartLoading, required Function () onCompleteLoading}){

    onStartLoading();

    //SignOut from API
    authService.signOut()
        .whenComplete((){

      print("SignOut from BackendService");

      //Clear our cache
      localStorageService.clear()
          .whenComplete((){

        print("Cache cleared");

        onCompleteLoading();

        //toastLongSuccess('Déconnexion réussie');

        //Navigate to LoginScreen
        final homeScreen = start();
        final newRoute = MaterialPageRoute(builder: (context)=> homeScreen);
        Navigator.pushAndRemoveUntil(context, newRoute, (_)=>false);
      });
    });
  }
}