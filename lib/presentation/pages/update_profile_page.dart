import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/button_style.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _ageController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          color: primaryColor,
                          size: 32,
                        ),
                        tooltip: 'Back',
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Perbaharui Profil",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 45,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 70),
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 15,
                      top: 120,
                      bottom: 30,
                    ),
                    decoration: BoxDecoration(
                      color: primaryBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: secondaryColor.withOpacity(0.4),
                          offset: const Offset(0.0, -4.0),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildNameField(),
                        const SizedBox(height: 20),
                        _buildEmailField(),
                        const SizedBox(height: 20),
                        _buildChoiceChip(),
                        const SizedBox(height: 20),
                        _buildAgeField(),
                        const SizedBox(height: 20),
                        _buildWeightField(),
                        const SizedBox(height: 20),
                        _buildHeightField(),
                        const SizedBox(height: 20),
                        _buildSubmitButton(context),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: secondaryColor,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          'assets/img/test_avatar.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 105),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            MdiIcons.cameraOutline,
                            color: primaryBackgroundColor,
                            size: 28,
                          ),
                          tooltip: 'Add Photo',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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

  FormBuilderChoiceChip<String> _buildChoiceChip() {
    return FormBuilderChoiceChip(
      name: 'gender',
      pressElevation: 0,
      spacing: 8,
      backgroundColor: scaffoldBackgroundColor,
      selectedColor: secondaryColor,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
        labelText: 'Jenis Kelamin',
        labelStyle: TextStyle(
          fontSize: 20,
          color: primaryColor,
        ),
      ),
      options: [
        FormBuilderFieldOption(
          value: 'Laki-laki',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(
                Icons.male_outlined,
                color: Color(0XFF5ECFF2),
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                'Laki-laki',
                style: TextStyle(color: Color(0XFF5ECFF2)),
              ),
            ],
          ),
        ),
        FormBuilderFieldOption(
          value: 'Perempuan',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(
                Icons.female_outlined,
                color: Color(0XFFEF5EF2),
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                'Perempuan',
                style: TextStyle(color: Color(0XFFEF5EF2)),
              ),
            ],
          ),
        ),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
      ]),
    );
  }

  FormBuilderTextField _buildAgeField() {
    return FormBuilderTextField(
      name: 'age',
      controller: _ageController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Umur (tahun)',
        hintText: 'Masukkan umur kamu',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.man_outlined),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
        FormBuilderValidators.integer(errorText: 'Input berupa angka integer.'),
      ]),
    );
  }

  FormBuilderTextField _buildWeightField() {
    return FormBuilderTextField(
      name: 'weight',
      controller: _weightController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Berat Badan (kg)',
        hintText: 'Masukkan berat badan kamu',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.monitor_weight_outlined),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
        FormBuilderValidators.integer(errorText: 'Input berupa angka integer.'),
      ]),
    );
  }

  FormBuilderTextField _buildHeightField() {
    return FormBuilderTextField(
      name: 'height',
      controller: _heightController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Tinggi Badan (cm)',
        hintText: 'Masukkan tinggi badan kamu',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.height_outlined),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
        FormBuilderValidators.integer(errorText: 'Input berupa angka integer.'),
      ]),
    );
  }

  SizedBox _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: elevatedButtonStyle,
        child: const Text('Simpan Perubahan'),
      ),
    );
  }
}
