import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yess_nutrition/common/styles/button_style.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/presentation/widgets/clickable_text.dart';

class AdditionalInformationPage extends StatefulWidget {
  const AdditionalInformationPage({Key? key}) : super(key: key);

  @override
  State<AdditionalInformationPage> createState() =>
      _AdditionalInformationPageState();
}

class _AdditionalInformationPageState extends State<AdditionalInformationPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final TextEditingController _ageController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClickableText(
                    onTap: () => Navigator.pushNamed(context, homeRoute),
                    text: 'Lewati',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.exit_to_app_outlined,
                        color: primaryColor,
                        size: 32,
                      ),
                      tooltip: 'Exit',
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/svg/reading_list_cuate.svg',
                width: 240,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lengkapi Data Anda',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: primaryColor),
            ),
            const SizedBox(height: 4),
            const Text(
              'Untuk memastikan kecukupan gizi anda, kami menyarankan untuk mengisi form berikut.',
              style: TextStyle(color: secondaryTextColor),
            ),
            const SizedBox(height: 24),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildChoiceChip(),
                  const SizedBox(height: 20),
                  _buildAgeField(),
                  const SizedBox(height: 20),
                  _buildWeightField(),
                  const SizedBox(height: 20),
                  _buildHeightField(),
                  const SizedBox(height: 16),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
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
        FormBuilderValidators.integer(errorText: 'Input harus berupa angka.'),
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
        FormBuilderValidators.integer(errorText: 'Input harus berupa angka.'),
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
        FormBuilderValidators.integer(errorText: 'Input harus berupa angka.'),
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

          if (_formKey.currentState!.validate()) {}
        },
        style: elevatedButtonStyle,
        child: const Text('Lanjutkan'),
      ),
    );
  }
}
