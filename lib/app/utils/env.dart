import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final API_URL = dotenv.env['API_URL'];
  static final PASSWORD = dotenv.env['PASSWORD'];
  static final API_KEY = dotenv.env['API_KEY'];
}