import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NutrientInputField extends StatelessWidget {
  final String name;
  final String initialValue;
  final bool isAutoFocus;
  final TextInputAction textInputAction;
  final String prefixText;
  final String suffixText;

  const NutrientInputField({
    Key? key,
    required this.name,
    required this.initialValue,
    this.isAutoFocus = false,
    this.textInputAction = TextInputAction.next,
    required this.prefixText,
    required this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      autofocus: isAutoFocus,
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixText: prefixText,
        suffixText: suffixText,
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(6),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
        FormBuilderValidators.match(
          r'^[1-9]\d*$',
          errorText: 'Format yang dimasukkan salah.',
        ),
      ]),
    );
  }
}
