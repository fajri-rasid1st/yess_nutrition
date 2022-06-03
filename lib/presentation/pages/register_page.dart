import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

import '../../common/styles/button_style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordInvisible = true;
  bool _isConfirmPasswordInvisible = true;

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
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Nama',
        hintText: 'Masukkan nama kamu',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.person_outline),
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

  FormBuilderTextField _buildPasswordField() {
    return FormBuilderTextField(
      name: 'password',
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isPasswordInvisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Password',
        hintText: 'Masukkan password kamu',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.lock_outlined),
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
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
        FormBuilderValidators.match(
          r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
          errorText: 'Password min. 8 karakter dengan 1 angka dan huruf.',
        ),
      ]),
    );
  }

  FormBuilderTextField _buildConfirmPasswordField() {
    return FormBuilderTextField(
      name: 'confirm_password',
      controller: _confirmPasswordController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isConfirmPasswordInvisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Konfirmasi Password',
        hintText: 'Masukkan password sekali lagi',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: _isConfirmPasswordInvisible
              ? const Icon(Icons.visibility_off_outlined)
              : const Icon(Icons.visibility_outlined),
          onPressed: () {
            setState(() {
              _isConfirmPasswordInvisible = !_isConfirmPasswordInvisible;
            });
          },
        ),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
        FormBuilderValidators.equal<String>(
          _passwordController.text,
          errorText: 'Harus sama dengan password kamu.',
        ),
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
