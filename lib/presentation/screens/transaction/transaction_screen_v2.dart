import 'package:budgetcap/config/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TransactionScreenV2 extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TransactionScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Transaction')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormBuilderChoiceChips(
                spacing: 10.0,
                alignment: WrapAlignment.center,
                name: "tranType",
                options: [
                  FormBuilderChipOption(
                    value: Operations.income,
                    child: Text('Income'),
                  ),
                  FormBuilderChipOption(
                    value: Operations.expense,
                    child: Text('Expense'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FormBuilderDateTimePicker(
                name: 'date',
                initialEntryMode: DatePickerEntryMode.calendar,
                initialValue: DateTime.now(),
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: 'Date',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.calendar_month_outlined),
                    onPressed: () {
                      _formKey.currentState!.fields['date']?.didChange(
                        DateTime.now(),
                      );
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['date']?.didChange(null);
                    },
                  ),
                ),
                initialTime: const TimeOfDay(hour: 8, minute: 0),
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUnfocus,
                name: 'amount',
                decoration: InputDecoration(labelText: 'Amount'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.positiveNumber(),
                ]),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'description',
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              FormBuilderDropdown(
                decoration: InputDecoration(labelText: 'Accounts'),
                name: 'account',
                items: [
                  DropdownMenuItem(value: 'bac', child: Text('BAC')),
                  DropdownMenuItem(value: 'banpro', child: Text('Banpro')),
                  DropdownMenuItem(value: 'lafise', child: Text('LAFISE')),
                ],
              ),
              SizedBox(height: 20),
              FormBuilderChoiceChips<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Choose a category:',
                ),
                name: 'category',
                initialValue: 'Dart',
                options: const [
                  FormBuilderChipOption(
                    value: 'Dart',
                    avatar: CircleAvatar(child: Text('D')),
                  ),
                  FormBuilderChipOption(
                    value: 'Kotlin',
                    avatar: CircleAvatar(child: Text('K')),
                  ),
                  FormBuilderChipOption(
                    value: 'Java',
                    avatar: CircleAvatar(child: Text('J')),
                  ),
                  FormBuilderChipOption(
                    value: 'Swift',
                    avatar: CircleAvatar(child: Text('S')),
                  ),
                  FormBuilderChipOption(
                    value: 'Objective-C',
                    avatar: CircleAvatar(child: Text('O')),
                  ),
                ],
                onChanged: (_) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
