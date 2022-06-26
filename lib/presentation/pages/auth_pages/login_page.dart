import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/input_password_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_auth_notifiers/user_auth_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_data_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/clickable_text.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormBuilderState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
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
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/wave_background.svg',
                  alignment: Alignment.topCenter,
                  width: width,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SvgPicture.asset('assets/svg/yess_logo_white.svg'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline4,
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Halo, ',
                          style: TextStyle(color: primaryTextColor),
                        ),
                        TextSpan(
                          text: 'Apa Kabar!',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Masukkan akunmu terlebih dahulu ya.',
                    style: TextStyle(color: secondaryTextColor),
                  ),
                  const SizedBox(height: 24),
                  FormBuilder(
                    key: _formKey,
                    autoFocusOnValidationFailure: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        _buildEmailField(),
                        const SizedBox(height: 20),
                        _buildPasswordField(),
                        const SizedBox(height: 8),
                        ClickableText(
                          onTap: () {
                            Navigator.pushNamed(context, forgotPasswordRoute);
                          },
                          text: 'Lupa Password?',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSubmitButton(context),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'atau',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildGoogleSignInButton(context),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Belum punya akun? '),
                      ClickableText(
                        onTap: () {
                          Navigator.pushNamed(context, registerRoute);
                        },
                        text: 'Daftar di sini.',
                      )
                    ],
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
        final isVisible = provider.isSignInPasswordVisible;

        return FormBuilderTextField(
          name: 'password',
          controller: _passwordController,
          textInputAction: TextInputAction.done,
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
              onPressed: () => provider.isSignInPasswordVisible = !isVisible,
            ),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi.',
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
        child: const Text('Masuk'),
      ),
    );
  }

  SizedBox _buildGoogleSignInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _onPressedGoogleSignInButton(context),
        icon: const FaIcon(
          FontAwesomeIcons.google,
          size: 18,
        ),
        label: const Text('Lanjutkan dengan Google'),
      ),
    );
  }

  Future<void> _onPressedSubmitButton(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;
      final authNotifier = context.read<UserAuthNotifier>();

      // show loading when sign in is currently on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // sign in process
      await authNotifier.signIn(value['email'], value['password']);

      if (authNotifier.state == UserState.success) {
        // get user
        final user = authNotifier.user;

        // close the loading indicator
        navigatorKey.currentState!.pop();

        // navigate to main page
        navigatorKey.currentState!.pushReplacementNamed(
          mainRoute,
          arguments: user,
        );
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

  Future<void> _onPressedGoogleSignInButton(BuildContext context) async {
    final authNotifier = context.read<UserAuthNotifier>();
    final userDataNotifier = context.read<UserDataNotifier>();

    await authNotifier.signInWithGoogle();

    if (authNotifier.state == UserState.error) {
      final snackBar = Utilities.createSnackBar(authNotifier.error);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    // get user
    final user = authNotifier.userFromGoogle;

    if (user != null) {
      // first, check if this user already in database
      await userDataNotifier.getUserStatus(user.uid);

      if (userDataNotifier.state == UserState.success) {
        if (userDataNotifier.isNewUser) {
          // convert user entity to user data entity
          final userData = user.toUserData();

          // craete user data
          await userDataNotifier.createUserData(userData);

          if (userDataNotifier.state == UserState.success) {
            // navigate to main page
            navigatorKey.currentState!.pushReplacementNamed(
              mainRoute,
              arguments: user,
            );
          }
        } else {
          // navigate to main page
          navigatorKey.currentState!.pushReplacementNamed(
            mainRoute,
            arguments: user,
          );
        }
      }
    }
  }
}
