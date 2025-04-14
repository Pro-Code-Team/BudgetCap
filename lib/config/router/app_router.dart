import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/presentation/screens/reports/reports_screen.dart';
import 'package:budgetcap/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        // Return the widget that implements the custom shell (in this case
        // using a BottomNavigationBar). The StatefulNavigationShell is passed
        // to be able access the state of the shell and to navigate to other
        // branches in a stateful way.
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the
              // bottom navigation bar.
              path: '/',
              builder: (BuildContext context, GoRouterState state) =>
                  ReportsScreen(),
              // routes: <RouteBase>[
              //   // The details screen to display stacked on navigator of the
              //   // first tab. This will cover screen A but not the application
              //   // shell (bottom navigation bar).
              //   GoRoute(
              //     path: 'details',
              //     builder: (BuildContext context, GoRouterState state) =>
              //         const DetailsScreen(label: 'A'),
              //   ),
              // ],
            ),
          ],
          // To enable preloading of the initial locations of branches, pass
          // 'true' for the parameter `preload` (false is default).
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/transactions',
              builder: (BuildContext context, GoRouterState state) =>
                  const AllTransactionsScreen(),
              routes: <RouteBase>[
                GoRoute(
                    path: '/edit',
                    builder: (BuildContext context, GoRouterState state) {
                      final Transaction transaction =
                          state.extra as Transaction;
                      return TransactionScreen(
                        transaction: transaction,
                      );
                    }),
                GoRoute(
                  path: '/create',
                  builder: (BuildContext context, GoRouterState state) =>
                      TransactionScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: '/settings',
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: '/accounts',
                    builder: (context, state) {
                      return NewAccountScreen();
                    },
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: '/accounts',
                builder: (BuildContext context, GoRouterState state) =>
                    const AllAccountsScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: '/transactions',
                    builder: (context, state) {
                      final int accountId = state.extra as int;
                      return AllTransactionsScreen(accountId: accountId);
                    },
                  ),
                ]),
          ],
        ),
      ],
    ),
  ],
);
