import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';
import 'package:test_drive/ui/widgets/toast_ui.dart';

import '../../../app_setup.dart';
import '../../../data/models/user/user.dart';
import '../../../service/exception/auth/auth_exception.dart';
import '../../widgets/progress_ui.dart';

class ContactsPage extends StatefulWidget {

  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  List<User> _contacts = [];

  @override
  void initState() {
    ProgressUtils.init();
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: ProgressUtils.isLoading ? const ProgressUi():
      Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: ListView(
          children: _contacts.map<Widget>((contact)=>
            _buildContactItemUi(contact)).toList()
        ),
      )
    );
  }

  void _loadData() {
    //Show Loading()
    ProgressUtils.showProgress(() {
      if (mounted) {
        setState(() {

        });
      }
    });

    //Load Contacts
    AppSetup.userService.loadContactsByCustomerId(
      customerId:
        AppSetup.localStorageService
            .getConnectedUser()
            ?.user
            ?.id
        ).then((List<User> value) {
          _contacts = value;
          //Hide Loading ()
          ProgressUtils.hideProgress(() {
            if (mounted) {
              setState(() {

              });
            }
          });
        })
        .catchError((error) {
          //Hide Loading ()
          ProgressUtils.hideProgress(() {
            if (mounted) {
              setState(() {

              });
            }
          });

          print("MessagesPage.loadData() Error $error");

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
        }
      );
  }

  Widget _buildContactItemUi(User contact) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 80.0,
            height: 80.0,
            decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
            ),
            child: const Icon(Icons.person, color: Colors.white,),
          ),
          title: Text("${contact.firstName} ${contact.lastName}"),
        ),
        Divider(
          thickness: 0.1.h,
          color: Colors.black.withAlpha(15),
        ),
      ],
    );
  }
}