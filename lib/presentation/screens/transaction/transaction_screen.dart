import 'package:budgetcap/config/constants/constants.dart';
import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';

import 'package:budgetcap/presentation/blocs/transaction_type_bloc/transaction_type_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budgetcap/presentation/widgets/icon_grabber.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionScreen extends StatelessWidget {
  final Transaction? transaction;
  TransactionScreen({super.key, this.transaction});

  final Operations view = Operations.income;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Define the FormKey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<TransactionBloc, TransactionBlocState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              // Trigger form validation
              if (_formKey.currentState?.validate() ?? false) {
                // If the form is valid, dispatch the FormSubmitted event
                context.read<TransactionBloc>().add(TransactionFormSubmitted(
                    transactionId: transaction?.id, context: context));
                //Will retrieve the balances for all account from the database whenever a transaction is created, updated or deleted.
                context.read<AccountBloc>().add(
                      const AccountInitial(),
                    );
                context.pop();
              } else {
                // Show an error if the form is invalid
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill out all required fields.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Icon(Icons.check),
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: TransactionView(
        formKey: _formKey,
        transaction: transaction,
      ), // Pass the FormKey to TransactionView
    );
  }
}

class TransactionView extends StatelessWidget {
  final Transaction? transaction;
  final GlobalKey<FormState> formKey;

  const TransactionView({
    super.key,
    required this.formKey,
    this.transaction, // Accept the FormKey
  });

  @override
  Widget build(BuildContext context) {
    //Looking for the transaction that came from the selected item on "All transaction list".
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TransactionTypeSelection(
                transaction: transaction,
              ),
              const SizedBox(height: 20),
              DatePickerSelection(
                transaction: transaction,
              ),
              const SizedBox(height: 20),
              // Pass the FormKey to RecordInputFields
              TransactionInputFields(
                  formKey: formKey, transaction: transaction),
              const SizedBox(height: 10),
              AccountSelection(
                transaction: transaction,
              ),
              const SizedBox(height: 10),
            ],
          ),
          CategoriesView(
            transaction: transaction,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class TransactionTypeSelection extends StatelessWidget {
  final Transaction? transaction;
  const TransactionTypeSelection({
    super.key,
    this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    String transactionType = transaction?.type ??
        OperationsExtension.fromName('expense')
            .name; // Default to income if transaction is null

    context.read<TransactionTypeBloc>().add(TransactionTypeChanged(
        selectedTransactionType:
            OperationsExtension.fromName(transactionType)));

    context.read<TransactionBloc>().add(TransactionFormFieldChanged(
        fieldName: 'transaction_type', fieldValue: transactionType));

    return Center(
      child: BlocBuilder<TransactionTypeBloc, TransactionTypeState>(
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
            ],
            selected: <Operations>{state.selectedValue as Operations},
            onSelectionChanged: (selected) {
              context.read<TransactionTypeBloc>().add(TransactionTypeChanged(
                  selectedTransactionType: selected.first));
              context.read<TransactionBloc>().add(TransactionFormFieldChanged(
                  fieldName: 'transaction_type',
                  fieldValue: selected.first.name));
            },
          );
        },
      ),
    );
  }
}

class DatePickerSelection extends StatelessWidget {
  final Transaction? transaction;
  const DatePickerSelection({
    super.key,
    this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    DateTime date = transaction?.date ?? DateTime.now();

    context.read<DatePickerBloc>().add(DateChanged(selectedDate: date));

    context
        .read<TransactionBloc>()
        .add(TransactionFormFieldChanged(fieldName: 'date', fieldValue: date));

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
                context.read<TransactionBloc>().add(TransactionFormFieldChanged(
                    fieldName: 'date', fieldValue: pickedDate));
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

class TransactionInputFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Transaction? transaction;

  const TransactionInputFields({
    super.key,
    required this.formKey,
    this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    String amount = '';
    String description = '';
    //Validating amount and description and setting values in the state.
    if (transaction != null) {
      final TransactionBloc transactionBloc = context.read<TransactionBloc>();
      amount = transaction!.amount.toString();
      description = transaction!.description;

      transactionBloc.add(
          TransactionFormFieldChanged(fieldValue: amount, fieldName: 'amount'));
      transactionBloc.add(TransactionFormFieldChanged(
          fieldValue: description, fieldName: 'description'));
    }
    return Form(
      key: formKey, // Assign the FormKey to the Form widget
      child: BlocBuilder<TransactionBloc, TransactionBlocState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Chip(
                    label: BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        return Text(state.accounts
                            .where((account) =>
                                account.id == state.accountSelected)
                            .first
                            .currency);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      initialValue: amount,
                      onChanged: (value) {
                        context.read<TransactionBloc>().add(
                            TransactionFormFieldChanged(
                                fieldValue: value, fieldName: 'amount'));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an amount";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter amount',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: description,
                onChanged: (value) {
                  context.read<TransactionBloc>().add(
                      TransactionFormFieldChanged(
                          fieldValue: value, fieldName: 'description'));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a description',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AccountSelection extends StatelessWidget {
  final Transaction? transaction;
  const AccountSelection({
    super.key,
    this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    int accountId = transaction?.accountId ?? 1;

    context
        .read<AccountBloc>()
        .add(AccountSelected(accountSelected: accountId));
    context.read<TransactionBloc>().add(TransactionFormFieldChanged(
        fieldName: 'account_id', fieldValue: accountId));

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
                  context.read<TransactionBloc>().add(
                      TransactionFormFieldChanged(
                          fieldName: 'account_id', fieldValue: newValue));
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class CategoriesView extends StatelessWidget {
  final Transaction? transaction;
  const CategoriesView({
    super.key,
    this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    int categoryId = transaction?.categoryId ?? 1;

    final int index = context
        .read<CategoryBloc>()
        .state
        .categories
        .indexWhere((category) => category.id == categoryId);

    context.read<CategoryBloc>().add(CategoryChanged(categorySelected: index));

    context.read<TransactionBloc>().add(TransactionFormFieldChanged(
        fieldName: 'category_id', fieldValue: categoryId));

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
                    context.read<TransactionBloc>().add(
                        TransactionFormFieldChanged(
                            fieldName: 'category_id', fieldValue: category.id));
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
