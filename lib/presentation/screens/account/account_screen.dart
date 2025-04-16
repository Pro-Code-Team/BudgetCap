import 'package:budgetcap/config/constants/constants.dart';
import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  final Account? account;
  const AccountScreen({super.key, this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${account == null ? 'Create New' : 'Edit'} Account'),
      ),
      body: SafeArea(
        child: _AccountView(account),
      ),
    );
  }
}

class _AccountView extends StatelessWidget {
  const _AccountView(this.account);

  final Account? account;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.isSuccess && !state.isInProgress) {
          // Show success message and navigate back
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        } else if (state.message.isNotEmpty && !state.isInProgress) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isInProgress) {
          // Show CircularProgressIndicator while loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _AccountForm(state: state, account: account),
        );
      },
    );
  }
}

class _AccountForm extends StatelessWidget {
  final Account? account;
  final AccountState state;
  _AccountForm({required this.state, this.account});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? selectedCurrency;
    String? selectedColor;

    if (account != null) {
      selectedCurrency = account!.currency;
      selectedColor = account!.color;
      context
          .read<AccountBloc>()
          .add(AccountCategorySelected(iconName: account!.icon));

      final Map<String, String> initialValues = {
        'name': account!.name,
        'currency': account!.currency,
        'description': account!.description,
        'color': account!.color,
        'icon': account!.icon,
      };
      context.read<AccountBloc>().add(
            AccountFormInitializedValues(formData: initialValues),
          );
    }
    //
    List<String> iconsName = icons.keys.toList();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account Name
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Account Name',
              hintText: 'Enter account name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an account name';
              }
              return null;
            },
            onChanged: (value) {
              context.read<AccountBloc>().add(AccountFormFieldChanged(
                    fieldName: 'name',
                    fieldValue: value,
                  ));
            },
            initialValue: account == null ? '' : account!.name,
          ),
          const SizedBox(height: 20),

          // Currency Dropdown
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Currency',
            ),
            value: selectedCurrency,
            items: currencies.map((Map<String, String> currency) {
              return DropdownMenuItem(
                value: currency['currency'],
                child: Text('${currency['country']} (${currency['currency']})'),
              );
            }).toList(),
            onChanged: (String? value) {
              selectedCurrency = value;
              context.read<AccountBloc>().add(AccountFormFieldChanged(
                    fieldName: 'currency',
                    fieldValue: selectedCurrency!,
                  ));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a currency';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Description
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter a description',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
            initialValue: account == null ? '' : account!.description,
            onChanged: (value) {
              context.read<AccountBloc>().add(AccountFormFieldChanged(
                    fieldName: 'description',
                    fieldValue: value,
                  ));
            },
          ),
          const SizedBox(height: 20),

          // Color Dropdown
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Color',
            ),
            value: selectedColor,
            items: colors.map((Map<String, String> color) {
              return DropdownMenuItem(
                value: color['hex'],
                child: Text(color['name']!),
              );
            }).toList(),
            onChanged: (String? value) {
              selectedColor = value;
              context.read<AccountBloc>().add(AccountFormFieldChanged(
                    fieldName: 'color',
                    fieldValue: selectedColor!,
                  ));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a color';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Icon Grid
          const Text(
            'Select an Icon',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: icons.length,
              itemBuilder: (context, index) {
                final String iconName = iconsName[index];
                return GestureDetector(
                  onTap: () {
                    context
                        .read<AccountBloc>()
                        .add(AccountCategorySelected(iconName: iconName));

                    //print(iconName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: iconName == state.selectedIcon
                          ? const Color.fromARGB(255, 173, 70, 228)
                              .withValues(blue: 0.5)
                          : Colors.grey.withValues(blue: 0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: iconName == state.selectedIcon
                            ? const Color.fromARGB(255, 57, 9, 89)
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icons[iconName]),
                        Text(
                          iconName,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<AccountBloc>().add(
                        AccountFormSubmitted(),
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill out all required fields.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('${account == null ? 'Create' : 'Save'} Account'),
            ),
          ),
        ],
      ),
    );
  }
}
