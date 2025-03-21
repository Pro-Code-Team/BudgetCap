import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewAccountScreen extends StatelessWidget {
  const NewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state.isInProgress) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
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
                      Flexible(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Enter some text";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Account Name',
                            hintText: 'Enter account name',
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
                    /* onChanged: (value) {
                      context.read<FormControlBloc>().add(FormFieldChanged(
                          value: value, fieldName: 'Description'));
                    }, */
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
        ),
      ),
    );
  }
}
