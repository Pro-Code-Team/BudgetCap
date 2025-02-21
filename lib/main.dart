import 'package:budgetcap/config/constants/variables.dart';
import 'package:budgetcap/presentation/screens/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
  //Initial widgets will load.
  //WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  //Setting up the supabase
  await Supabase.initialize(
      url: 'https://rdslpdguvbjyxouecbsw.supabase.co',
      anonKey: Variables.supabaseAnonKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TransactionScreen());
  }
}
