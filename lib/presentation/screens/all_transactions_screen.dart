import 'package:budgetcap/domain/entities/category.dart';
import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budgetcap/presentation/widgets/iconGrabber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch the GetAllTransactions event when the screen is initialized
    context.read<TransactionBloc>().add(GetAllTransactions());
    context.read<CategoryBloc>().add(CategoryInitial());

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TransactionBloc, TransactionBlocState>(
          builder: (context, state) {
            if (state.isInProgress) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.message.isNotEmpty) {
              return Center(child: Text(state.message));
            }
//TODO: Add this logic to the Bloc.
            // Group transactions by date
            final transactionsByDate = <String, List<Transaction>>{};
            for (var transaction in state.transactions) {
              final date = DateFormat('dd-MM-yyyy').format(transaction.date);
              if (!transactionsByDate.containsKey(date)) {
                transactionsByDate[date] = [];
              }
              transactionsByDate[date]!.add(transaction);
            }

            return CustomScrollView(
              slivers: transactionsByDate.entries.map((entry) {
                final date = entry.key;
                final transactions = entry.value;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final transaction = transactions[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                date,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: BlocBuilder<CategoryBloc, CategoryState>(
                              builder: (context, categoryState) {
                                final category = categoryState.categories
                                    .firstWhere(
                                        (cat) =>
                                            cat.id == transaction.categoryId,
                                        orElse: () => Category(
                                            id: 0,
                                            name: 'Unknown',
                                            icon: 'unknown',
                                            description: 'Unknown'));
                                return ListTile(
                                  leading: IconGrabber(iconName: category.icon),
                                  title: Text(category.name),
                                  subtitle: Text(transaction.description),
                                  trailing: Text("C\$ ${transaction.amount}"),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: transactions.length,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
