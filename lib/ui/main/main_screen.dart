import 'package:flutter/material.dart';
import 'package:test_drive/configuration/colors.dart';
import 'package:test_drive/configuration/constants.dart';
import 'package:test_drive/ui/main/pages/contacts_page.dart';
import 'package:test_drive/ui/main/pages/groups_page.dart';
import 'package:test_drive/ui/main/pages/messages_page.dart';
import 'package:test_drive/ui/main/pages/profil_page.dart';

import '../../app_setup.dart';
import '../widgets/dialogs.dart';

class MainScreen extends StatefulWidget {
  final String title;

  const MainScreen({super.key, required this.title});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  bool _isLoading = false;
  int _currentPosition = 0;

  void _showProgress(){
    _isLoading = true;
    if(mounted){
      setState(() {

      });
    }
  }

  void _hideProgress(){
    _isLoading = false;
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            IconButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>
              const ProfilPage()
              ));

            }, icon: const Icon(Icons.person)),
            IconButton(
              onPressed: (){

                //Show Disclaimer and Take confirmation

                Dialogs.showConfirmDialog(
                  context: context,
                  message: "Êtes-vous sûr de vouloir vous déconnecter?",
                  onCancel: (){
                    print("onCancel()");

                  },
                  onConfirm: (){
                    print("onConfirm()");
                    AppSetup.logout(context:context, onStartLoading:_showProgress, onCompleteLoading:_hideProgress);

                  }
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white,)
            )
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "Message",
              ),
              Tab(
                text: "Group",
              )
            ],
          ),
        ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: (){

              Navigator.push(context, MaterialPageRoute(
                builder: (context)=> const ContactsPage(),

              ));
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary,

              ),
              child: const Icon(Icons.add, color: Colors.white,),
            ),
          ),
        body: const TabBarView(
          children: [
            MessagesPage(),
            GroupsPage(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPosition,
          onTap: (int position){
            setState(() {
              _currentPosition = position;
            });
            if (_currentPosition == 0) {
              // message_icon is clicked
            }
          },
          items:  [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                  "${Constants.imageDirectory}/message_icon.png",
              ),
              icon: Image.asset(
                  "${Constants.imageDirectory}/message_icon.png",
                  color: Color(0xff91a7c0),
              ),
              label: "",
            ),

            BottomNavigationBarItem(
              activeIcon: Image.asset(
                "${Constants.imageDirectory}/friends_icon.png",
                color: Color(0xff000000),
              ),
                icon: Image.asset(
                  "${Constants.imageDirectory}/friends_icon.png",
                ),
                label: ""
            ),

            BottomNavigationBarItem(
                icon: Image.asset(
                  "${Constants.imageDirectory}/add_box_icon.png",
                  color: Color(0xff91a7c0),
                ),
                label: ""
            ),


            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  "${Constants.imageDirectory}/notifications_icon.png",
                  color: Color(0xff000000),
                ),icon: Image.asset(
                  "${Constants.imageDirectory}/notifications_icon.png",
                ),
                label: ""
            ),

            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  "${Constants.imageDirectory}/profile_icon.png",
                  color: Colors.black,
                ),icon: Image.asset(
                  "${Constants.imageDirectory}/profile_icon.png",
                ),
                label: ""
            )
          ],
        ),
      )
    );
  }
}