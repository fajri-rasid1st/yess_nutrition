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
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_firestore_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class AdditionalInfoPage extends StatefulWidget {
  final UserEntity user;

  const AdditionalInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final TextEditingController _ageController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormBuilderState>();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          mainRoute,
          (route) => false,
          arguments: widget.user,
        );

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          mainRoute,
                          (route) => false,
                          arguments: widget.user,
                        );
                      },
                      icon: const Icon(Icons.close_rounded),
                      color: primaryColor,
                      tooltip: 'Close',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SvgPicture.asset(
                'assets/svg/reading_list_cuate.svg',
                width: 200,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 24),
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
      options: <FormBuilderChipOption<String>>[
        FormBuilderChipOption(
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
        FormBuilderChipOption(
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
      decoration: const InputDecoration(
        labelText: 'Umur (tahun)',
        hintText: 'Masukkan umur kamu',
        prefixIcon: Icon(Icons.man_outlined),
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
      decoration: const InputDecoration(
        labelText: 'Berat Badan (kg)',
        hintText: 'Masukkan berat badan kamu',
        prefixIcon: Icon(Icons.monitor_weight_outlined),
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
      decoration: const InputDecoration(
        labelText: 'Tinggi Badan (cm)',
        hintText: 'Masukkan tinggi badan kamu',
        prefixIcon: Icon(Icons.height_outlined),
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
        onPressed: () => _onPressedSubmitButton(context),
        child: const Text('Lanjutkan'),
      ),
    );
  }

  Future<void> _onPressedSubmitButton(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;
      final userDataNotifier = context.read<UserFirestoreNotifier>();

      // show loading when on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // read user data
      await userDataNotifier.readUserData(widget.user.uid);

      if (userDataNotifier.state == UserState.success) {
        // get user data
        final userData = userDataNotifier.userData;

        // updated user data
        final updatedUserData = userData.copyWith(
          gender: value['gender'],
          age: int.tryParse(value['age']),
          weight: int.tryParse(value['weight']),
          height: int.tryParse(value['height']),
        );

        // update user data on firestore
        await userDataNotifier.updateUserData(updatedUserData);

        if (userDataNotifier.state == UserState.success) {
          // close loading indicator
          navigatorKey.currentState!.pop();

          // navigate to main page
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            mainRoute,
            (route) => false,
            arguments: widget.user,
          );
        }
      } else {
        final snackBar = Utilities.createSnackBar(userDataNotifier.error);

        // close loading indicator
        navigatorKey.currentState!.pop();

        scaffoldMessengerKey.currentState!
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }
}
