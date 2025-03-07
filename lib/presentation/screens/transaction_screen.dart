import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/record_type_bloc/record_type_bloc.dart';
import 'package:budgetcap/presentation/widgets/iconGrabber.dart';
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
          create: (_) => RecordTypeBloc(),
        ),
        BlocProvider<DatePickerBloc>(
          create: (_) => DatePickerBloc(),
        ),
        BlocProvider<AccountBloc>(
          create: (_) => AccountBloc(),
        ),
        BlocProvider<CategoryBloc>(create: (_) => CategoryBloc())
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.check),
        ),
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
                          print(selected);
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

                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter a description',
                  ),
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
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        return DropdownMenu<String>(
                            initialSelection: state.selectedAccount,
                            dropdownMenuEntries: state.accounts
                                .map(
                                  (String option) => DropdownMenuEntry(
                                      value: option, label: option),
                                )
                                .toList());
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing:
                            20.0, // Horizontal spacing between items
                        mainAxisSpacing: 20.0, // Vertical spacing between items
                      ),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        final iconName = category.icon;
                        return InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          splashColor: const Color.fromARGB(255, 156, 143, 193),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconGrabber(iconName: iconName),
                                Text(category.name),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
