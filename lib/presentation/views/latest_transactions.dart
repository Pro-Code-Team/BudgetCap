import 'package:budgetcap/config/constants/constants.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestTransactions extends StatelessWidget {
  const LatestTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionBloc>().add(TransactionFetchAll());
    });
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.height * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text('Latest Transactions'),
                BlocBuilder<TransactionBloc, TransactionBlocState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];
                        final accountState = context.watch<AccountBloc>().state;
                        final accountsMap = {
                          for (var account in accountState.accounts)
                            account.id: account,
                        };
                        final accountFound =
                            accountsMap[transaction.accountId]?.name ??
                            "Not Found";

                        return ListTile(
                          title: Text(transaction.description),
                          subtitle: Text(accountFound),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
