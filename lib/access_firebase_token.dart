import 'package:googleapis_auth/auth_io.dart';

class AccessFirebaseToken {
  static String fMessagingScope =
      'https://www.googleapis.com/auth/firebase.messaging';

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "finddoctor-50ec6",
        "private_key_id": "3024c6c96a699c1069d9a939e6a207c311990f42",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDjzVohazWTD6fG\nfWVv5PM8v3skbEFxmIjqvefB7hSoGzMM8tmeP+JOYEocoACI3QDO9ELy387dnpuw\nqUYkJJUHDQy15LphWtnRUK+OIHNjn+NOLPGOeq1OCUNyihdHABPRibEtY59XQjK3\nQoycdboPDazHde4l45C1WMr4uBgRzKVkG4vUYMOGYIh+rZjjXwpHq1L72+Le0Xbl\nKh7fyH6KMz7Ha39OVMOS7UP60ekXW8D9rD3sYyl96CBWQ7hT7dC93rTLXFM5SsE0\nxwHpBqQc3qmSBR0i7vZQBAum5tH8f3XPYHeVFkwAdMANkaahXHCjH2f5eJ+8Jzn0\nc1aKymjLAgMBAAECggEAQmd5/oPh+hx2K8Yh65wxy2OF4fgsm5B7WPJCvKVKIDbN\niti/1wGIVpB7Ch0aCsthkPJjEalsA+5YNAckCyUezA9hxSQHsJlrJTj/885B1Kim\n+gLf50ibfEP3BUx7vJapMEuS+kgwCp+haQpdMr6engS+eOZHpYPQiwx3HkmLuqQA\nR06KOs8XPLVEhRILxsWjvGyKGBsew8EASdDGFQuVrvQmdqsLDMfYJTeswg+YFCMr\nHUSy33qKkRd2Bztq5gZA6Zn6wEtN5d9ORNIREEqRMyBR784UXxj2nlXEt2esNP3k\nyMvYlH6Guz5p5tKYvUOa74TM93qorXjsmOnoL9vfAQKBgQDy7im67DPK/rNBv8R/\na5J4lmL8TolZaa+zVyptQRuS/q/RNjktYKH9uyxTNcXVDZAMmfCmg+8etaeLJzG6\nU0XnT027EDneMKayMtfV4j+gaEr22uUzet7ImIBRmdE81XlQswjUBZM+5i6a6vct\nonnfEVPSGSDuE62aBwpDvAzpvwKBgQDwDtTZyWQLqxm/vwl2nbrY2PGhqBtXuwf7\nJ7aVPYcKfham4gHXZfDiZegmdHrKO5n4/lJRBu755xl3L0Pri1xZI5fHNUO21yaT\ndGwXaXZgychfvSC24VhbSZKxuihm4rUu4jrj4K0je/lRqUwBkt+r5kZFvRPwlZYB\ndQq4aXyL9QKBgGOyek3MQjU88jQ5j1r7utDiZx1E3flj9keTrkXIQpjBDUa/Chgl\nYFXRSw+bMeWN+2AwjSLJYokn4+qn2zCsnDOhyDTNI/Kb5M2dMBcHEzWxl5JXo1jN\nREDu1Tqn9ccRlQgZcbYR06wsq1PIukhwNbPmWJAQ4ALU8JoV6ZCCzInhAoGAT4pq\nhnsPVjpsPrd62D2tEnrXnVvJK4mCPHrNKagIXbanpMYQHCHf7fQcNtmzcdzLyM/j\n0Is+lbk4G+CiXaKAh9yeRthkRmoFkygpRJyiJ7HUXbyZ4V7LWvwGyjLHfkeyBwXY\nw3bHh5Fla+RvlbnnuNqFAEiFGdtGp9bzJWV2ah0CgYEA384u5qgVsrdRSwcqxplq\n/vkJFdl8BOm4Fdi38Kmeo9fAYKC0+x10E8zm+hmXi46lK4WemWpt7zwwOshcYrfg\noGLo3JUBcLJ/qeYjvLQPcI5K9Gb9Vg688uFKuE/edmPsx11nUjdrmVYxSQcHO4fH\n3ctj7monharYvdcAmhwWPGU=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-lflhf@finddoctor-50ec6.iam.gserviceaccount.com",
        "client_id": "111125373221213664191",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-lflhf%40finddoctor-50ec6.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      [fMessagingScope],
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
