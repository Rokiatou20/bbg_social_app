import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/app_setup.dart';
import 'package:test_drive/data/models/message/message.dart';
import 'package:test_drive/data/models/session/session.dart';
import 'package:test_drive/data/models/user/user.dart';
import 'package:test_drive/service/auth/auth_service_impl.dart';
import 'package:test_drive/service/conversation/conversation_service_impl.dart';
import 'package:test_drive/data/models/conversation/conversation.dart';
import 'package:test_drive/service/exception/auth/auth_exception.dart';
import 'package:test_drive/service/message/message_service_impl.dart';
import 'package:test_drive/service/user/user_service_impl.dart';

void main() {

  // test('Check successful refresh_token', () async {
  //   final Session ses = await AuthServiceImpl().signIn(email: "rouattara150@gmail.com", password: "1234");
  //   final res = await AuthServiceImpl().refreshToken(session: ses);
  //
  //   print("Backend Test ===> Load Contacts : $res");
  //
  //   expect(res is Session, true);
  // });

  // test('Check successful logout', () async {
  //   final Session ses = await AuthServiceImpl().signIn(email: "rouattara150@gmail.com", password: "1234");
  //   final res = await AuthServiceImpl().signOut(session: ses);
  //
  //   print("Backend Test ===> Load Contacts : $res");
  //
  //   expect(res, true);
  // });

  // test('Check unsuccessful logout', () async {
  //   final Session ses = Session.fromJson({
  //     "user": {
  //       "id": 2,
  //       "first_name": "Test",
  //       "last_name": "Test",
  //       "email": "angebagui@adjemin.com",
  //       "password": "UF.uGDM2dw1E4M7QHKV4uiQEzKHVQZmJ7LC",
  //       "photo": null,
  //       "created_at": "2023-12-02T00:02:33.000000Z",
  //       "updated_at": "2023-12-02T00:02:33.000000Z",
  //       "deleted_at": null
  //     },
  //     "authorization": {
  //       "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwaS1zb2NpYWxhcHAuYWRqZW1pbmNsb3VkLmNvbS9hcGkvdjEvdXNlcl9hdXRoIiwiaWF0IjoxNzE5NDAwOTg5LCJleHAiOjE3MTk0MDEwNDksIm5iZiI6MTcxOTQwMDk4OSwianRpIjoiNG14MlA0UFJEajhMVnNaVSIsInN1YiI6IjIiLCJwcnYiOiIxZDBhMDIwYWNmNWM0YjZjNDk3OTg5ZGYxYWJmMGZiZDRlOGM4ZDYzIn0.et936G5ZEnA2OgEWy9pTouW8X9F1zLGAtZ40jif4lCk",
  //       "type": "bearer"
  //     }
  //   });
  //
  //   try {
  //     final res = await AuthServiceImpl().signOut(session: ses);
  //     print("Backend Test ===> Load Contacts : $res");
  //   }
  //   catch (e) {
  //     print(e);
  //     expect(e is AuthException, true);
  //   };
  //
  // });

  // test('Check load Contacts By Customer Id', () async {
  //     final res = await UserServiceImpl().loadContactsByCustomerId(1);
  //
  //     print("Backend Test ===> Load Contacts : $res");
  //
  //     expect(res is List<User>, true);
  // });

  // test('Check load Messages By Conversation Id', () async {
  //       final res = await MessageServiceImpl().loadMessagesByConversationId(2);
  //
  //       print("Backend Test ===> Load Messages : $res");
  //
  //       expect(res is List<Message>, true);
  //   });

  // test('Check register successful', () async {
  //     final res = await ConversationServiceImpl().loadConversationsByCustomerId(2);
  //
  //     expect(res is List<Conversation>, true);
  // });

  // test('Check register successful', () async {
  //   final res = await AuthServiceImpl()
  //     .signUp(
  //       firstName: "Ange",
  //       lastName: "Bagui",
  //       email: "angebagu1i@adjemin.com",
  //       password: "123456789"
  //     );
  //
  //   expect(res is Session, true);
  // });

  // test('Check login successful', () async {
  //   final res = await AuthServiceImpl()
  //     .signIn(
  //       email: "angebagui@adjemin.com",
  //       password: "123456789"
  //     );
  //
  //   expect(res is Session, true);
  // });
  //
  // test("Check login failed", () async {
  //   final res = await AuthServiceImpl()
  //     .signIn(
  //       email: "angebagui@adjemin.com",
  //       password: "1234567890"
  //     );
  //
  //   expect(res is Session, false);
  // });

  // test("Check openConversation", ()async{
  //
  //   final res = await ConversationServiceImpl()
  //       .openConversation(speakers: [14,2]);
  //
  //   print("Body Response => $res");
  //
  //   expect(res is Conversation, true);
  //
  // });

  // test("Check openConversation with bad token", ()async{
  //
  //   try{
  //     final res = await ConversationServiceImpl()
  //         .openConversation(speakers: [14,2]);
  //
  //     print("Body Response => $res");
  //
  //   }catch(error){
  //
  //     print("Error $error");
  //
  //     expect(error is AuthException , true);
  //   }
  //
  // });

  // test("Check sendMessage successfully", ()async{
  //
  //   print("MessageContentType.text => ${MessageContentType.text.name}");
  //   final res = await BackendRestService()
  //       .sendMessage(
  //       content: "Hello, Comment ça va ?",
  //       contentType: MessageContentType.text.name,
  //       senderId: 2,
  //       conversationId: 4);
  //
  //   print("Body Response => $res");
  //
  //   expect(res is Message, true);
  //
  // });

}