import "dart:math";

String generateToken() {
  const int length = 3;
  const String chars = '123456789';

  Random random = Random();
  String token = 'GKU-';

  for (int i = 0; i < length; i++) {
    token += chars[random.nextInt(chars.length)];
  }

  return token;
}
