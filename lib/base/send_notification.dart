import 'dart:convert';
import 'dart:developer';

import '../access_firebase_token.dart';
import 'package:http/http.dart' as http;

class SendNotification {
  static sendToNotification(String title, String body, String token) async {
    String bearerToken = await AccessFirebaseToken().getAccessToken();
    String endPointMessage =
        'https://fcm.googleapis.com/v1/projects/finddoctor-50ec6/messages:send';

    final Map<String, dynamic> bodySend = {
      "message": {
        "token": token,
        "notification": {"title": title, "body": body}
      }
    };

    final response = await http.post(Uri.parse(endPointMessage),
        headers: {
          'Content-Type': 'application/Json',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(bodySend));

    if (response.statusCode == 200) {
      log('Notification send succffullll');
    } else {
      log('error: ${response.request}');
    }
  }
}
