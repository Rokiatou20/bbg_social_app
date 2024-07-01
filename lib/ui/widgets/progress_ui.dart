import 'package:flutter/material.dart';

import '../../configuration/colors.dart';

class ProgressUi extends StatelessWidget {
  const ProgressUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        const Center(
          child: CircularProgressIndicator(
            color: AppColors.secondary,
          ),
        )
      ],
    );
  }
}

class ProgressUtils{

  static bool isLoading = false;

  static void init(){
    isLoading = false;
  }
  static void showProgress(Function () onSuccess){
    isLoading = true;
    onSuccess();
  }

  static void hideProgress(Function () onSuccess){
    isLoading = false;
    onSuccess();
  }
}