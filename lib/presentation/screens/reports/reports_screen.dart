import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/reports_bloc/reports_bloc.dart';
import 'package:budgetcap/presentation/widgets/icon_grabber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //Current page saved in the bloc.
    int currentPage = context.watch<ReportsBloc>().state.currentPage;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // Section 1: Horizontal Carousel for Accounts with Page Indicator
            SliverToBoxAdapter(
              child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state.isInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.accounts.isEmpty) {
                    return const Center(
                      child: Text('No accounts available'),
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height: 200, // Fixed height for the carousel
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: state.accounts.length,
                          onPageChanged: (index) {
                            context
                                .read<ReportsBloc>()
                                .add(ReportsPageChanged(index));
                          },
                          itemBuilder: (context, index) {
                            final account = state.accounts[index];
                            return InkWell(
                              onTap: () {
                                //Redirect to see all the transactions with this accountID in them.
                                context.push('/accounts/transactions',
                                    extra: account.id);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Container(
                                    width: 300,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconGrabber(iconName: account.icon),
                                        Text(
                                          account.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${account.balance.round()} ${account.currency}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.accounts.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentPage == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Section 2: Vertical List of Transactions
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // Replace this with your transaction data
                  final transaction = context
                      .read<AccountBloc>()
                      .state
                      .accounts[index]; // Example transaction data

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text(transaction.description),
                      subtitle: const Text(
                        'Amount: ',
                      ),
                      trailing: Text(
                        DateTime.now().toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
                childCount: context
                    .read<AccountBloc>()
                    .state
                    .accounts
                    .length, // Replace with the number of transactions
              ),
            ),
          ],
        ),
      ),
    );
  }
}
