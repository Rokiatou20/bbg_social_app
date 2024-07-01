import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/service/upload/imgur/imgur_service.dart';

void main () {
  test("upload successfully image", () async {

    ImgurService imgurService = ImgurService();
    final String res =  await imgurService.uploadImage(File("${Directory.current.path}/test/girl.jpeg"));


    print("Response =>> $res");

  });
}