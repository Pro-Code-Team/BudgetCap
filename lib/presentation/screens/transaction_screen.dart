import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/form_bloc/form_bloc.dart';
import 'package:budgetcap/presentation/blocs/record_type_bloc/record_type_bloc.dart';
import 'package:budgetcap/presentation/widgets/iconGrabber.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Operations { transfer, income, expense }

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final Operations view = Operations.income;
  final List<String> accounts = ['Ficohsa', 'BAC', 'Banpro', 'LAFISE'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<FormControlBloc, FormControlState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state.isValid
                ? () {
                    context.read<FormControlBloc>().add(FormSubmitted(
                        formData: state.formData, context: context));
                  }
                : null,
            child: const Icon(Icons.check),
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Add Record"),
      ),
      body: const TransactionView(),
    );
  }
}

class TransactionView extends StatelessWidget {
  const TransactionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RecordTypeSelection(),
              SizedBox(
                height: 20,
              ),
              //DATE SECTION
              DatePickerSelection(),
              SizedBox(
                height: 20,
              ),
              RecordInputFields(),

              SizedBox(
                height: 10,
              ),
//Account selection section
              AccountSelection(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          //Scrollable GRID
          CategoriesView(),
        ],
      ),
    );
  }
}

class RecordInputFields extends StatelessWidget {
  const RecordInputFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormControlBloc, FormControlState>(
      listener: (context, state) {
        if (state.isValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Form submitted successfully'),
            ),
          );
        } else if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              Row(
                children: [
                  Chip(label: Text("USD")),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      onChanged: (value) {
                        context.read<FormControlBloc>().add(FormFieldChanged(
                            value: value, fieldName: 'Amount'));
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Enter some text";
                        }
                        return null;
                      },
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType
                          .number, // Set the keyboard type to number
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter amount',
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              ///General Section

              TextFormField(
                onChanged: (value) {
                  context.read<FormControlBloc>().add(
                      FormFieldChanged(value: value, fieldName: 'Description'));
                },
                validator: (value) {
                  if (value == null) {
                    return "Enter some text";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a description',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AccountSelection extends StatelessWidget {
  const AccountSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            return DropdownButton<int>(
              value: state.accountSelected,
              items: state.accounts.map<DropdownMenuItem<int>>((Account value) {
                return DropdownMenuItem<int>(
                  value: value.id,
                  child: Text(
                    value.name,
                  ),
                );
              }).toList(),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  context
                      .read<AccountBloc>()
                      .add(AccountSelected(accountSelected: newValue));
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class DatePickerSelection extends StatelessWidget {
  const DatePickerSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
              label: Text(DateFormat.yMMMd()
                  .format(context.read<DatePickerBloc>().state.selectedDate)),
            ),
          );
        },
      ),
    );
  }
}

class RecordTypeSelection extends StatelessWidget {
  const RecordTypeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
            selected: <Operations>{state.selectedValue as Operations},
            onSelectionChanged: (selected) {
              context
                  .read<RecordTypeBloc>()
                  .add(RecordChanged(selectedRecord: selected.first));
              print(selected);
            },
          );
        },
      ),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.isInProgress) {
              return const Center(
                heightFactor: 10,
                child: CircularProgressIndicator(),
              );
            }
            if (state.message.isNotEmpty) {
              return Center(
                heightFactor: 10,
                child: Text(state.message),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 20.0, // Horizontal spacing between items
                mainAxisSpacing: 20.0, // Vertical spacing between items
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                final iconName = category.icon;
                return GestureDetector(
                  onTap: () {
                    context
                        .read<CategoryBloc>()
                        .add(CategoryChanged(categorySelected: index));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index == state.categorySelected
                          ? const Color.fromARGB(255, 156, 143, 193)
                          : Colors.white,
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
        ),
      ),
    );
  }
}
