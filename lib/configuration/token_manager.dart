import 'package:jwt_decoder/jwt_decoder.dart';

import '../app_setup.dart';
import '../data/models/session/session.dart';
import 'constants.dart';

class TokenManager{

  static isExpired(){
    final Session? me = AppSetup.localStorageService.getConnectedUser();
    final String? token  = me?.authorization?.token;
    if(token != null){
      print("TokenManager.isExpired() =====> ${JwtDecoder.isExpired(token)}");
      print("JwtDecoder.getRemainingTime =>> ${JwtDecoder.getRemainingTime(token)}");

      return JwtDecoder.isExpired(token);
    }
    return true;
  }

  static refresh(){

    print("TokenManager.refresh()");

    final Session? me = AppSetup.localStorageService.getConnectedUser();
    final String? token  = me?.authorization?.token;
    if(token != null){
      final bool hasExpired = JwtDecoder.isExpired(token);
      if(hasExpired == false){//Token is not expired
        final Duration remainingTime = JwtDecoder.getRemainingTime(token);
        print("JwtDecoder.getRemainingTime =>> $remainingTime");
        if(remainingTime.inMinutes < Constants.tokenRemainingRefreshTime){
          print("We refresh our token");

          AppSetup.authService.refreshToken(session: me)
              .then((session){
            AppSetup.localStorageService.storeConnectedUser(session).
            whenComplete((){
              print("Token is refreshed");
            });
          });
        }
      }
    }
  }
}