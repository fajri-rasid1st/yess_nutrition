import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_auth_notifiers/user_auth_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class ForgotPasswordPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  ForgotPasswordPage({Key? key}) : super(key: key);

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
                          size: 32,
                        ),
                        color: primaryBackgroundColor,
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
                        _buildSubmitButton(context),
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
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan email kamu',
        prefixIcon: Icon(Icons.email_outlined),
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
        onPressed: () => _onPressedSubmitButton(context),
        child: const Text('Kirim Email Konfirmasi'),
      ),
    );
  }

  Future<void> _onPressedSubmitButton(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;
      final authNotifier = context.read<UserAuthNotifier>();

      // show loading when currently on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      await authNotifier.resetPassword(value['email']);

      if (authNotifier.state == UserState.success) {
        final succeessSnackBar = Utilities.createSnackBar(authNotifier.success);

        scaffoldMessengerKey.currentState!
          ..hideCurrentSnackBar()
          ..showSnackBar(succeessSnackBar);

        // navigate to first route after email sended
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
      } else {
        final errorSnackBar = Utilities.createSnackBar(authNotifier.error);

        // close the loading indicator
        navigatorKey.currentState!.pop();

        scaffoldMessengerKey.currentState!
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackBar);
      }
    }
  }
}
