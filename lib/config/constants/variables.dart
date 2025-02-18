import 'package:flutter_dotenv/flutter_dotenv.dart';

class Variables {
  static String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ??
      "No se ha encontrado el Anon Key de Supabase";
}
