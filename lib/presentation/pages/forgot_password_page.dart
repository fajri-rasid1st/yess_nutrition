import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

import '../../common/styles/button_style.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final TextEditingController _emailController;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    _emailController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/wave_background.svg',
                  alignment: Alignment.topCenter,
                  width: width,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          color: primaryBackgroundColor,
                          size: 32,
                        ),
                        tooltip: 'Back',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lupa Password?',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Kami akan mengirim email konfirmasi untuk mengubah password anda.',
                    style: TextStyle(color: secondaryTextColor),
                  ),
                  const SizedBox(height: 24),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildEmailField(),
                        const SizedBox(height: 16),
                        _buildSubmitButton(context)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FormBuilderTextField _buildEmailField() {
    return FormBuilderTextField(
      name: 'email',
      controller: _emailController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Email',
        hintText: 'Masukkan email kamu',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
        FormBuilderValidators.email(errorText: 'Email tidak valid.'),
      ]),
    );
  }

  SizedBox _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();

          _formKey.currentState!.save();

          if (_formKey.currentState!.validate()) {
            print(_formKey.currentState!.value);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('berhasil')),
            );
          }
        },
        style: elevatedButtonStyle,
        child: const Text('Daftar Sekarang'),
      ),
    );
  }
}
