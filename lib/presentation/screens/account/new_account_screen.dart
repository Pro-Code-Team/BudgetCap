import 'package:budgetcap/config/constants/constants.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewAccountScreen extends StatelessWidget {
  NewAccountScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? selectedCurrency;
    String? selectedColor;
    String? selectedIcon;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
      ),
      body: SafeArea(
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Show success message and navigate back
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
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
            List<String> iconsName = icons.keys.toList();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
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
                        context.read<AccountBloc>().add(FormFieldChanged(
                              fieldName: 'name',
                              fieldValue: value,
                            ));
                      },
                    ),
                    const SizedBox(height: 20),

                    // Currency Dropdown
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Currency',
                      ),
                      value: selectedCurrency,
                      items: currencies.map((currency) {
                        return DropdownMenuItem(
                          value: currency['currency'],
                          child: Text(
                              '${currency['country']} (${currency['currency']})'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedCurrency = value;
                        context.read<AccountBloc>().add(FormFieldChanged(
                              fieldName: 'currency',
                              fieldValue: value!,
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
                      onChanged: (value) {
                        context.read<AccountBloc>().add(FormFieldChanged(
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
                      items: colors.map((color) {
                        return DropdownMenuItem(
                          value: color['hex'],
                          child: Text(color['name']!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedColor = value;
                        context.read<AccountBloc>().add(FormFieldChanged(
                              fieldName: 'color',
                              fieldValue: value!,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: icons.length,
                        itemBuilder: (context, index) {
                          final iconName = iconsName[index];
                          return GestureDetector(
                            onTap: () {
                              selectedIcon = iconName;
                              context.read<AccountBloc>().add(FormFieldChanged(
                                    fieldName: 'icon',
                                    fieldValue: iconName,
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedIcon == iconName
                                    ? Colors.blue.withOpacity(0.5)
                                    : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedIcon == iconName
                                      ? Colors.blue
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
                                  FormSubmitted(formData: state.formData),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please fill out all required fields.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text('Create Account'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
