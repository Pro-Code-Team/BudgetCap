import 'package:budgetcap/config/constants/constants.dart';
import 'package:budgetcap/config/router/app_router.dart';
import 'package:budgetcap/infrastructure/datasource/account_datasource_impl.dart';
import 'package:budgetcap/infrastructure/datasource/category_datasource_impl.dart';
import 'package:budgetcap/infrastructure/datasource/transaction_datasource_impl.dart';
import 'package:budgetcap/infrastructure/repositories/account_repository_impl.dart';
import 'package:budgetcap/infrastructure/repositories/category_repository_impl.dart';
import 'package:budgetcap/infrastructure/repositories/transaction_repository_impl.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/reports_bloc/reports_bloc.dart';

import 'package:budgetcap/presentation/blocs/transaction_type_bloc/transaction_type_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
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
    anonKey: Variables.supabaseAnonKey,
  );

  // Get a reference your Supabase client
  final SupabaseClient supabase = Supabase.instance.client;

  // Create a new instance of the datasource
  final TransactionDatasourceImpl transactionDatasource =
      TransactionDatasourceImpl(supabase: supabase);

  final CategoryDatasourceImpl categoryDatasource = CategoryDatasourceImpl(
    supabase: supabase,
  );

  final AccountDatasourceImpl accountDatasource = AccountDatasourceImpl(
    supabase: supabase,
  );

  // Create a new instance of the repository
  final TransactionRepositoryImpl transactionRepository =
      TransactionRepositoryImpl(transactionDatasource: transactionDatasource);

  final CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl(
    categoryDatasource: categoryDatasource,
  );

  final AccountRepositoryImpl accountRepository = AccountRepositoryImpl(
    datasource: accountDatasource,
  );

  // Run the app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TransactionTypeBloc>(create: (_) => TransactionTypeBloc()),
        BlocProvider<DatePickerBloc>(create: (_) => DatePickerBloc()),
        BlocProvider<AccountBloc>(
          create: (_) => AccountBloc(accountRepository),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(categoryRepository),
        ),
        BlocProvider<TransactionBloc>(
          create: (_) => TransactionBloc(transactionRepository),
        ),
        BlocProvider<ReportsBloc>(create: (_) => ReportsBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class AppInitializer extends StatelessWidget {
  final Widget child;
  const AppInitializer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionBlocState>(
      builder: (context, state) {
        context.read<TransactionBloc>().add(TransactionFetchAll());
        return child;
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'BugdetCap',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
