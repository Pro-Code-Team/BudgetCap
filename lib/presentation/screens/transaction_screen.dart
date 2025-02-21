import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Operations { transfer, income, expense }

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final Operations view = Operations.income;
  final List<String> accounts = ['Ficohsa', 'BAC', 'Banpro', 'LAFISE'];
  final List<String> categories = [
    'Food & Drinks',
    'Shopping',
    'Housing',
    'Vehicle'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Record"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SegmentedButton<Operations>(
                  segments: <ButtonSegment<Operations>>[
                    ButtonSegment(
                      value: Operations.income,
                      label: Text("Income"),
                    ),
                    ButtonSegment(
                      value: Operations.expense,
                      label: Text("Expense"),
                    ),
                    ButtonSegment(
                      value: Operations.transfer,
                      label: Text("Transfer"),
                    )
                  ],
                  selected: {view},
                  onSelectionChanged: (p0) => {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Chip(
                  label: Text("Test"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Chip(label: Text("USD")),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextField(
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              ///General Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                      child: Row(
                    children: [
                      Icon(Icons.wallet),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Account'),
                    ],
                  )),
                  DropdownMenu<String>(
                      initialSelection: accounts.first,
                      dropdownMenuEntries: accounts
                          .map(
                            (String option) =>
                                DropdownMenuEntry(value: option, label: option),
                          )
                          .toList()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                      child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                      child: Row(
                    children: [
                      Icon(Icons.wallet),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Account'),
                    ],
                  )),
                  DropdownMenu<String>(
                      initialSelection: accounts.first,
                      dropdownMenuEntries: accounts
                          .map(
                            (String option) =>
                                DropdownMenuEntry(value: option, label: option),
                          )
                          .toList()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
