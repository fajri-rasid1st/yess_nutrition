import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/input_password_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/auth_notifiers/sign_in_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/auth_notifiers/sign_in_with_google_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/firestore_notifiers/create_user_data_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/clickable_text.dart';

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
    _formKey = GlobalKey<FormBuilderState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

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
      final signInNotifier = context.read<SignInNotifier>();

      // show loading when sign in is currently on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // sign in process
      await signInNotifier.signIn(value['email'], value['password']);

      if (!mounted) return;

      if (signInNotifier.state == UserState.success) {
        // get user
        final user = signInNotifier.user;

        // close the loading indicator
        Navigator.pop(context);

        // navigate to home page
        Navigator.pushReplacementNamed(context, homeRoute, arguments: user);
      } else {
        final snackBar = Utilities.createSnackBar(signInNotifier.error);

        // close the loading indicator
        Navigator.pop(context);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  Future<void> _onPressedGoogleSignInButton(BuildContext context) async {
    final googleSignInNotifier = context.read<SignInWithGoogleNotifier>();
    final createUserDataNotifier = context.read<CreateUserDataNotifier>();

    await googleSignInNotifier.signInWithGoogle();

    if (!mounted) return;

    if (googleSignInNotifier.state == UserState.success) {
      // get user
      final user = googleSignInNotifier.user;

      // get user data
      final userData = user.toUserData();

      // craete user data when sign in successfully
      await createUserDataNotifier.createUserData(userData);

      if (!mounted) return;

      // navigate to home page
      Navigator.pushReplacementNamed(context, homeRoute, arguments: user);
    } else {
      final snackBar = Utilities.createSnackBar(googleSignInNotifier.error);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
