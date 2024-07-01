import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';
import 'package:test_drive/app_setup.dart';
import 'package:test_drive/configuration/colors.dart';
import 'package:test_drive/configuration/constants.dart';
import 'package:test_drive/data/models/session/session.dart';
import 'package:test_drive/service/exception/auth/auth_exception.dart';
import 'package:test_drive/ui/auth/register_page.dart';
import 'package:test_drive/ui/widgets/custom_button.dart';
import 'package:test_drive/ui/widgets/custom_text_field.dart';
import 'package:test_drive/ui/widgets/progress_ui.dart';
import 'package:test_drive/ui/widgets/toast_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController(text: "angebagui@adjemin.com");
  final TextEditingController _passwordController = TextEditingController(text: "123456789");

  bool _isLoading = false;

  @override
  initState() {
    super.initState();

    Timer.run(
        () {
          notificationInit();
          _getFirebaseId();
        }
    );
  }


  notificationInit() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  _getFirebaseId()  {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

  // use the returned token to send messages to users from your custom server
    messaging.getToken().then((String? token) {
      print("Firebase Id : $token");
    });
  }

  void _showLoading() {
    _isLoading = true;
    if (mounted){
      setState(() {
      });
    }
  }

  void _hideLoading() {
    _isLoading = false;

    if (mounted){
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          appBar: AppBar(),
          body: _isLoading ? const ProgressUi() : SingleChildScrollView(
            child: Column(
              children: [
                // Display logo
                _buildLogoUI(),
                SizedBox(height: 4.h),

                // Display form title
                Center(
                  child: Text(
                    'Connexion',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),

                // Display form subtitle
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      'Connectez-vous maintenant !',
                      textAlign: TextAlign.center,
                      style: TextStyle (
                        fontSize: 13.dp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

                // Display email textfield
                CustomTextField(
                  textController: _emailController,
                  placeholder: "Email",
                  prefixIcon: Icons.email,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 2.h),

                // Display password textfield
                CustomTextField(
                  textController: _passwordController,
                  placeholder: "Mot de passe",
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility,
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(height: 3.h),

                // Display forgot password
                InkWell(
                  onTap: () { print("User onTap"); },
                  child: const Text(
                      'Mot de passe oublie ?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )
                  ),
                ),
                SizedBox(height: 3.h),

                // Display login button
                CustomButton(
                  title: "Se connecter",
                  onTap: _submitLogin,
                ),

                SizedBox(height: 3.h),
                // Display register button
                CustomButton(
                  title: "S'inscrire",
                  bgColor: AppColors.primary,
                  onTap: () {
                    final route = MaterialPageRoute(builder: (context) => const RegisterPage());
                    Navigator.pushReplacement(context, route);
                  },
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _buildLogoUI() {
    return Center(
      child: Image.asset(
        '${Constants.imageDirectory}/login_page_logo.png',
        width: 80.w,
      ),
    );
  }

  void _submitLogin() {

    //Check Inputs
    if(_emailController.text.isEmpty){
      //Show Email est obligatoire
      ToastUi.showToast("error", "Email est obligatoire");
      return;
    }

    if(_passwordController.text.isEmpty){
      //Show Mot de passe est obligatoire
      ToastUi.showToast("error", "Mot de passe est obligatoire");
      return;
    }

    //Show Dialog
    _showLoading();

    final String email = _emailController.text.trim().toString();
    final String password  = _passwordController.text.trim().toString();

    AppSetup.authService.signIn(email: email, password: password)
      .then((Session value){
        print("Session  $value");
        _hideLoading();

        AppSetup.localStorageService.storeConnectedUser(value)
            .whenComplete((){

          ToastUi.showToast("success", "Connexion réussie !");

          final newRoute = MaterialPageRoute(builder: (context)=> AppSetup.start());
          Navigator.pushAndRemoveUntil(context, newRoute, (_) => false);

        });
    }).catchError((error){
      _hideLoading();
      print("LoginScreen._submitLogin() =>> Error => $error");
      if(error is AuthException){
        ToastUi.showToast("error", error.message);
      }else if(error is SocketException || error is Client){
        ToastUi.showToast("error", "S'il vous plaît, veuillez vérifier votre connexion internet");
      }else if(error is ArgumentError){

      }else if(error is Exception){

      }else{
        ToastUi.showToast("error", error.message);
      }
    });
  }
}
