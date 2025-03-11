import 'package:budgetcap/config/constants/variables.dart';
import 'package:budgetcap/infrastructure/datasource/transaction_datasource_impl.dart';
import 'package:budgetcap/infrastructure/repositories/transaction_repository_impl.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/record_type_bloc/record_type_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budgetcap/presentation/screens/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Get a reference your Supabase client
  final SupabaseClient supabase = Supabase.instance.client;

  // Create a new instance of the datasource
  final TransactionDatasourceImpl transactionDatasource =
      TransactionDatasourceImpl(supabase: supabase);

  // Create a new instance of the repository
  final TransactionRepositoryImpl transactionRepository =
      TransactionRepositoryImpl(transactionDatasource: transactionDatasource);

  // Run the app
  runApp(MultiBlocProvider(providers: [
    BlocProvider<RecordTypeBloc>(
      create: (_) => RecordTypeBloc(),
    ),
    BlocProvider<DatePickerBloc>(
      create: (_) => DatePickerBloc(),
    ),
    BlocProvider<AccountBloc>(
      create: (_) => AccountBloc(),
    ),
    BlocProvider<CategoryBloc>(
      create: (_) => CategoryBloc(),
    ),
    BlocProvider<TransactionBloc>(
      create: (_) => TransactionBloc(repo: transactionRepository),
    ),
  ], child: const MyApp()));
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
