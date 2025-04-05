import 'package:budgetcap/domain/entities/category.dart';
import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budgetcap/presentation/widgets/icon_grabber.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AllTransactionsScreen extends StatelessWidget {
  final int? accountId;
  const AllTransactionsScreen({super.key, this.accountId});

  @override
  Widget build(BuildContext context) {
    // Dispatch the GetAllTransactions event when the screen is initialized
    context.read<TransactionBloc>().add(const TransactionFetchAll());
    context.read<CategoryBloc>().add(const CategoryInitial());

    return Scaffold(
      appBar: AppBar(
        title: Text(accountId == null
            ? 'Transactions'
            : '${context.read<AccountBloc>().state.accounts.firstWhere((account) => account.id == accountId).name} '),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.push('/transactions/create');
          }),
      body: SafeArea(
        child: BlocBuilder<TransactionBloc, TransactionBlocState>(
          builder: (context, state) {
            if (state.isInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.message.isNotEmpty) {
              return Center(child: Text(state.message));
            }
            //Guardando transaction del estado e una variable.
            final List<Transaction> transactions =
                List<Transaction>.from(state.transactions);
            //Checking if the accountID is null
            if (accountId != null) {
              //Filter transactions by Id
              transactions.retainWhere(
                  (transaction) => transaction.accountId == accountId);
            }
            // Group transactions by date
            final transactionsByDate = <String, List<Transaction>>{};
            for (Transaction transaction in transactions) {
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
                      final Transaction transaction = transactions[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Dismissible(
                            resizeDuration: const Duration(milliseconds: 200),
                            dragStartBehavior: DragStartBehavior.down,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (direction) {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Eliminar transacción"),
                                    content: const Text(
                                        "¿Estás seguro de que deseas eliminar esta transacción?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text("Cancelar"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text("Eliminar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            key: Key(transaction.id.toString()),
                            onDismissed: (direction) {
                              context.read<TransactionBloc>().add(
                                  TransactionDelete(
                                      transactionId: transaction.id!));

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "${transaction.description} eliminado")),
                              );
                            },
                            /*      background: Container(color: Colors.red), */
                            direction: DismissDirection.endToStart,
                            child: GestureDetector(
                              onTap: () {
                                context.push('/transactions/edit',
                                    extra: transaction);
                              },
                              child: Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: BlocBuilder<CategoryBloc, CategoryState>(
                                  builder: (context, categoryState) {
                                    final category = categoryState.categories
                                        .firstWhere(
                                            (cat) =>
                                                cat.id ==
                                                transaction.categoryId,
                                            orElse: () => Category(
                                                id: 0,
                                                name: 'Unknown',
                                                icon: 'unknown',
                                                description: 'Unknown'));
                                    return ListTile(
                                      leading:
                                          IconGrabber(iconName: category.icon),
                                      title: Text(category.name),
                                      subtitle: Text(
                                          '${transaction.description}\nAccount: ${transaction.accountId}'),
                                      trailing:
                                          Text("C\$ ${transaction.amount}"),
                                    );
                                  },
                                ),
                              ),
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
