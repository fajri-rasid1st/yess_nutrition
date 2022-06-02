import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordInvisible = true;

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
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/wave_background.svg',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: 56,
                  child: SvgPicture.asset(
                    'assets/svg/yess_logo_white.svg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        _buildEmailField(),
                        const SizedBox(height: 24),
                        _buildPasswordField(),
                        const SizedBox(height: 8),
                        _buildForgotPasswordButton(context),
                        const SizedBox(height: 16),
                        _buildSubmitButton(context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'atau',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        size: 18,
                      ),
                      label: const Text('Lanjutkan dengan Google'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Belum punya akun? '),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, registerRoute);
                        },
                        child: const Text(
                          'Daftar di sini.',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  SizedBox _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();

          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Masuk'),
      ),
    );
  }

  InkWell _buildForgotPasswordButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, forgotPasswordRoute),
      child: const Text(
        'Lupa Password?',
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  FormBuilderTextField _buildPasswordField() {
    return FormBuilderTextField(
      name: 'password',
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isPasswordInvisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Password',
        hintText: 'Masukkan password kamu',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
          icon: _isPasswordInvisible
              ? const Icon(Icons.visibility_off_outlined)
              : const Icon(Icons.visibility_outlined),
          onPressed: () {
            setState(() {
              _isPasswordInvisible = !_isPasswordInvisible;
            });
          },
        ),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'Bagian ini harus diisi.',
        ),
      ]),
    );
  }

  FormBuilderTextField _buildEmailField() {
    return FormBuilderTextField(
      name: 'email',
      controller: _emailController,
      textInputAction: TextInputAction.next,
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
        FormBuilderValidators.required(
          errorText: 'Bagian ini harus diisi.',
        ),
        FormBuilderValidators.email(
          errorText: 'Masukkan email yang valid.',
        ),
      ]),
    );
  }
}
