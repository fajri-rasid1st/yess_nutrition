import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/input_password_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/auth_notifiers/sign_up_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/firestore_notifiers/create_user_data_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Buat Akun Baru',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
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
      controller: _nameController,
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
      controller: _emailController,
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

  Consumer<InputPasswordNotifier> _buildPasswordField() {
    return Consumer<InputPasswordNotifier>(
      builder: (context, provider, child) {
        final isVisible = provider.isSignUpPasswordVisible;

        return FormBuilderTextField(
          name: 'password',
          controller: _passwordController,
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

  Consumer<InputPasswordNotifier> _buildConfirmPasswordField() {
    return Consumer<InputPasswordNotifier>(
      builder: (context, provider, child) {
        final isVisible = provider.isSignUpConfirmPasswordVisible;

        return FormBuilderTextField(
          name: 'confirm_password',
          controller: _confirmPasswordController,
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
      final signUpNotifier = context.read<SignUpNotifier>();
      final createUserDataNotifier = context.read<CreateUserDataNotifier>();

      // show loading when sign up is currently on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // sign up process
      await signUpNotifier.signUp(value['email'], value['password']);

      if (!mounted) return;

      if (signUpNotifier.state == UserState.success) {
        // get user
        final user = signUpNotifier.user;

        // get user data
        final userData = user.toUserData();

        // craete user data when sign up successfully
        await createUserDataNotifier.createUserData(
          userData.copyWith(name: value['name']),
        );

        if (!mounted) return;

        // close the loading indicator
        Navigator.pop(context);

        // navigate to additional information page
        Navigator.pushReplacementNamed(
          context,
          additionalInfoRoute,
          arguments: user,
        );
      } else {
        final snackBar = Utilities.createSnackBar(signUpNotifier.error);

        // close the loading indicator
        Navigator.pop(context);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }
}