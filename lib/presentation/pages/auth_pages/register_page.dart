import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/password_field_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_auth_notifiers/user_auth_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_data_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  RegisterPage({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Buat Akun Baru',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tinggal selangkah lagi, menuju hidup sehat.',
                    style: TextStyle(color: secondaryTextColor),
                  ),
                  const SizedBox(height: 24),
                  FormBuilder(
                    key: _formKey,
                    autoFocusOnValidationFailure: true,
                    child: Column(
                      children: <Widget>[
                        _buildNameField(),
                        const SizedBox(height: 20),
                        _buildEmailField(),
                        const SizedBox(height: 20),
                        _buildPasswordField(),
                        const SizedBox(height: 20),
                        _buildConfirmPasswordField(),
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

  FormBuilderTextField _buildNameField() {
    return FormBuilderTextField(
      name: 'name',
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      maxLength: 100,
      decoration: const InputDecoration(
        labelText: 'Nama',
        hintText: 'Masukkan nama kamu',
        prefixIcon: Icon(Icons.person_outline_rounded),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
      ]),
    );
  }

  FormBuilderTextField _buildEmailField() {
    return FormBuilderTextField(
      name: 'email',
      textInputAction: TextInputAction.next,
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

  Consumer<PasswordFieldNotifier> _buildPasswordField() {
    return Consumer<PasswordFieldNotifier>(
      builder: (context, provider, child) {
        final isVisible = provider.isSignUpPasswordVisible;

        return FormBuilderTextField(
          name: 'password',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !isVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Masukkan password kamu',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: isVisible
                  ? const Icon(Icons.visibility_outlined)
                  : const Icon(Icons.visibility_off_outlined),
              onPressed: () => provider.isSignUpPasswordVisible = !isVisible,
            ),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi.',
            ),
            FormBuilderValidators.match(
              r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
              errorText: 'Password min. 8 karakter dengan 1 angka dan huruf.',
            ),
          ]),
          onChanged: (value) => provider.signUpPasswordValue = value ?? '',
        );
      },
    );
  }

  Consumer<PasswordFieldNotifier> _buildConfirmPasswordField() {
    return Consumer<PasswordFieldNotifier>(
      builder: (context, provider, child) {
        final isVisible = provider.isSignUpConfirmPasswordVisible;

        return FormBuilderTextField(
          name: 'confirm_password',
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !isVisible,
          decoration: InputDecoration(
            labelText: 'Konfirmasi Password',
            hintText: 'Masukkan password sekali lagi',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: isVisible
                  ? const Icon(Icons.visibility_outlined)
                  : const Icon(Icons.visibility_off_outlined),
              onPressed: () {
                provider.isSignUpConfirmPasswordVisible = !isVisible;
              },
            ),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi.',
            ),
            FormBuilderValidators.equal<String>(
              provider.signUpPasswordValue,
              errorText: 'Harus sama dengan password kamu.',
            ),
          ]),
        );
      },
    );
  }

  SizedBox _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _onPressedSubmitButton(context),
        child: const Text('Daftar Sekarang'),
      ),
    );
  }

  Future<void> _onPressedSubmitButton(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;
      final authNotifier = context.read<UserAuthNotifier>();
      final userDataNotifier = context.read<UserDataNotifier>();

      // show loading when sign up is currently on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // sign up process
      await authNotifier.signUp(value['email'], value['password']);

      if (authNotifier.state == UserState.success) {
        // get user
        final user = authNotifier.user;

        // convert user entity to user data entity
        final userData = user.toUserData();

        // craete user data when sign up successfully
        await userDataNotifier.createUserData(
          userData.copyWith(name: value['name']),
        );

        if (userDataNotifier.state == UserState.success) {
          // close the loading indicator
          navigatorKey.currentState!.pop();

          // navigate to additional information page
          navigatorKey.currentState!.pushReplacementNamed(
            additionalInfoRoute,
            arguments: user,
          );
        }
      } else {
        final snackBar = Utilities.createSnackBar(authNotifier.error);

        // close the loading indicator
        navigatorKey.currentState!.pop();

        scaffoldMessengerKey.currentState!
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }
}
