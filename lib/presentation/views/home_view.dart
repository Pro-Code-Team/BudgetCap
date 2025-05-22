import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/reports_bloc/reports_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budgetcap/presentation/views/latest_transactions.dart';
import 'package:budgetcap/presentation/widgets/icon_grabber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<TransactionBloc>().add(TransactionFetchAll());
        });

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        return PageView.builder(
                          itemCount: state.accounts.length,
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            final account = state.accounts[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconGrabber(iconName: account.icon),
                                    const SizedBox(height: 10),
                                    Text(
                                      account.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '\$${account.balance.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: context.read<AccountBloc>().state.accounts.length,
                    effect: SwapEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                    ), // your preferred effect
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          'Latest Transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        BlocBuilder<TransactionBloc, TransactionBlocState>(
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: 3,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final transaction = state.transactions[index];
                                final accountState = context
                                    .watch<AccountBloc>()
                                    .state;
                                final accountsMap = {
                                  for (var account in accountState.accounts)
                                    account.id: account,
                                };
                                final accountFound =
                                    accountsMap[transaction.accountId]?.name ??
                                    "Not Found";
                                return ListTile(
                                  leading: IconGrabber(iconName: accountFound),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
