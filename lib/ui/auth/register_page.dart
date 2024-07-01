import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';
import 'package:test_drive/app_setup.dart';
import 'package:test_drive/configuration/colors.dart';
import 'package:test_drive/configuration/constants.dart';
import 'package:test_drive/data/models/session/session.dart';
import 'package:test_drive/service/exception/auth/auth_exception.dart';
import 'package:test_drive/ui/auth/login_page.dart';
import 'package:test_drive/ui/widgets/custom_button.dart';
import 'package:test_drive/ui/widgets/custom_text_field.dart';
import 'package:test_drive/ui/widgets/progress_ui.dart';
import 'package:test_drive/ui/widgets/toast_ui.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isTermsAccepted = false;
  bool _isLoading = false;

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
    return Scaffold(
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
                'Inscription',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Display form subtitle
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'Rejoignez-nous maintenant ! Ouvrez un compte pour accéder à notre communauté !',
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
              textController: _lastNameController,
              placeholder: "Nom",
              prefixIcon: Icons.person,
            ),
            SizedBox(height: 2.h),

            // Display email textfield
            CustomTextField(
              textController: _firstNameController,
              placeholder: "Prénom",
              prefixIcon: Icons.person,
            ),
            SizedBox(height: 2.h),

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
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _isTermsAccepted = !_isTermsAccepted;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    child: const Text(
                      "J'accepte les conditions d'utilisations en cochant cette case. Cette action est obligatoire pour votre inscription."
                    ),
                    onTap: () {
                      setState(() {
                        _isTermsAccepted = !_isTermsAccepted;
                      });
                    },
                  )
                )
              ],
            ),
            SizedBox(height: 3.h),

            // Display login button
            CustomButton(
              title: "S'inscrire",
              onTap: _submitRegister,
            ),

            SizedBox(height: 3.h),
            // Display register button
            CustomButton(
              title: "Se connecter",
              bgColor: AppColors.primary,
              onTap: () {
                final route = MaterialPageRoute(builder: (context) => const LoginPage());
                Navigator.push(context, route);
              },
            )
            ],
        ),
      )
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

  void _submitRegister() {

    //Check Inputs
    if(_lastNameController.text.isEmpty){
      //Show Lastname est obligatoire
      ToastUi.showToast("error", "Nom est obligatoire");
      return;
    }
    if(_firstNameController.text.isEmpty){
      //Show Firstname est obligatoire
      ToastUi.showToast("error", "Prénom est obligatoire");
      return;
    }
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
    // _showLoading();

    final String email = _emailController.text.trim().toString();
    final String password  = _passwordController.text.trim().toString();
    final String lastName  = _lastNameController.text.trim().toString();
    final String firstName = _firstNameController.text.trim().toString();

    AppSetup.authService.signUp(lastName: lastName, firstName: firstName, email: email, password: password)
        .then((Session value){
      print("Session  $value");
      _hideLoading();

      AppSetup.localStorageService.storeConnectedUser(value)
          .whenComplete((){

        ToastUi.showToast("success", "Inscription réussie !");

        final newRoute = MaterialPageRoute(builder: (context)=> LoginPage());
        Navigator.pushAndRemoveUntil(context, newRoute, (_) => false);

      });
    }).catchError((error){
      _hideLoading();
      print("RegisterScreen._submitRegister() =>> Error => $error");

      if(error is AuthException){
        ToastUi.showToast("error", error.message);

      }else if(error is SocketException || error is Client){
        ToastUi.showToast("error", "S'il vous plaît, veuillez vérifier votre connexion internet");
      }else if(error is ArgumentError){
        ToastUi.showToast("error", "RegisterScreen.Toast()1 =>> Error => $error");
      }else if(error is Exception){
        ToastUi.showToast("error", "RegisterScreen.Toast()2 =>> Error => $error");
      }else{
        ToastUi.showToast("error", error.message);
      }
    });
  }
}
