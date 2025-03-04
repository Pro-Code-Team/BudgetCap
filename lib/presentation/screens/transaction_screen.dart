import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/record_type/record_type_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecordTypeBloc>(
          create: (context) => RecordTypeBloc(),
        ),
        BlocProvider<DatePickerBloc>(
          create: (context) => DatePickerBloc(),
        ),
      ],
      child: Scaffold(
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
                  child: BlocBuilder<RecordTypeBloc, RecordTypeState>(
                    builder: (context, state) {
                      return SegmentedButton<Operations>(
                        segments: const <ButtonSegment<Operations>>[
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
                        selected: <Operations>{
                          state.selectedValue as Operations
                        },
                        onSelectionChanged: (selected) {
                          context.read<RecordTypeBloc>().add(
                              RecordChanged(selectedRecord: selected.first));
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //DATE SECTION
                Center(
                  child: BlocBuilder<DatePickerBloc, DatePickerState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          //
                          if (context.mounted && pickedDate != null) {
                            context
                                .read<DatePickerBloc>()
                                .add(DateChanged(selectedDate: pickedDate));
                          }
                        },
                        child: Chip(
                          avatar: const Icon(Icons.calendar_month),
                          label: Text(DateFormat.yMMMd().format(context
                              .read<DatePickerBloc>()
                              .state
                              .selectedDate)),
                        ),
                      );
                    },
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
                              (String option) => DropdownMenuEntry(
                                  value: option, label: option),
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
                              (String option) => DropdownMenuEntry(
                                  value: option, label: option),
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
      ),
    );
  }
}
