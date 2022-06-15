import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/button_style.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';
import 'package:yess_nutrition/presentation/providers/providers.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserDataEntity userData;

  const UpdateProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late final TextEditingController _ageController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  // late Widget _profilePicture;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();

    _nameController.text = widget.userData.name;
    _bioController.text = widget.userData.bio;
    _ageController.text = widget.userData.age.toString();
    _weightController.text = widget.userData.weight.toString();
    _heightController.text = widget.userData.height.toString();

    // _profilePicture = widget.userData.imgUrl.isNotEmpty
    //     ? Image.network(
    //         widget.userData.imgUrl,
    //         fit: BoxFit.cover,
    //       )
    //     : Image.asset(
    //         'assets/img/default_user_pict.png',
    //         fit: BoxFit.cover,
    //       );

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
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
                    const SizedBox(width: 45),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildNameField(),
                          const SizedBox(height: 20),
                          _buildBioField(),
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
                        child: widget.userData.imgUrl.isEmpty
                            ? Image.asset(
                                'assets/img/default_user_pict.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.userData.imgUrl,
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
                          onPressed: () =>
                              _onPressedProfilePictureButton(context),
                          icon: const Icon(
                            MdiIcons.cameraPlusOutline,
                            color: primaryBackgroundColor,
                            size: 24,
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

  FormBuilderTextField _buildBioField() {
    return FormBuilderTextField(
      name: 'bio',
      controller: _bioController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Bio',
        hintText: 'Masukkan bio anda',
        hintStyle: const TextStyle(color: secondaryTextColor),
        prefixIcon: const Icon(Icons.info_outline),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Bagian ini harus diisi.'),
      ]),
    );
  }

  FormBuilderChoiceChip<String> _buildChoiceChip() {
    return FormBuilderChoiceChip(
      name: 'gender',
      pressElevation: 0,
      spacing: 8,
      initialValue: widget.userData.gender,
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
        onPressed: () => _onPressedSubmitButton(context),
        style: elevatedButtonStyle,
        child: const Text('Simpan Perubahan'),
      ),
    );
  }

  Future<void> _onPressedSubmitButton(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;
      final readUserDataNotifier = context.read<ReadUserDataNotifier>();
      final updateUserDataNotifier = context.read<UpdateUserDataNotifier>();

      // show loading when on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // read user data
      await readUserDataNotifier.readUserData(widget.userData.uid);

      if (!mounted) return;

      if (readUserDataNotifier.state == UserState.success) {
        // get user data
        final userData = readUserDataNotifier.userData;

        // updated user data
        final updatedUserData = userData.copyWith(
          name: value['name'],
          bio: value['bio'],
          gender: value['gender'],
          age: int.tryParse(value['age']),
          weight: int.tryParse(value['weight']),
          height: int.tryParse(value['height']),
        );

        // update user data on firestore
        await updateUserDataNotifier.updateUserData(updatedUserData);

        if (!mounted) return;

        if (updateUserDataNotifier.state == UserState.success) {
          // close loading indicator
          Navigator.pop(context);

          // Close Update Profile Page
          Navigator.pop(context);

          // Reload Profile Page
          Navigator.pushReplacementNamed(
            context,
            profileRoute,
            arguments: widget.userData.uid,
          );
        }
      } else {
        final snackBar = Utilities.createSnackBar(updateUserDataNotifier.error);

        // close loading indicator
        Navigator.pop(context);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  Future<void> _onPressedProfilePictureButton(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(MdiIcons.cameraOutline),
              title: const Text('Ambil Gambar'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(MdiIcons.fileImageOutline),
              title: const Text('Pilih File Gambar'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (file == null) {
      return;
    }

    var filecrop = await compressImage(file.path, 35);

    await _uploadFile(filecrop.path);
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${widget.userData.uid}${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future<void> _uploadFile(String path) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator(),
    );

    final uploadProfilePictureNotifier =
        context.read<UploadProfilePictureNotifier>();

    await uploadProfilePictureNotifier.uploadProfilePicture(
        path, p.basename(path));

    if (!mounted) return;

    if (uploadProfilePictureNotifier.state == UserState.success) {
      final readUserDataNotifier = context.read<ReadUserDataNotifier>();
      final updateUserDataNotifier = context.read<UpdateUserDataNotifier>();
      String url = uploadProfilePictureNotifier.downloadUrl;

      // read user data
      await readUserDataNotifier.readUserData(widget.userData.uid);

      if (!mounted) return;

      if (readUserDataNotifier.state == UserState.success) {
        // get user data
        final userData = readUserDataNotifier.userData;

        // updated user data
        final updatedUserData = userData.copyWith(
          imgUrl: url,
        );

        // update user data on firestore
        await updateUserDataNotifier.updateUserData(updatedUserData);

        if (!mounted) return;

        if (updateUserDataNotifier.state == UserState.success) {
          // close loading indicator
          Navigator.pop(context);

          // Close Update Profile Page
          Navigator.pop(context, true);

          // Reload Profile Page
          Navigator.pushReplacementNamed(
            context,
            profileRoute,
            arguments: widget.userData.uid,
          );
        }
      }
    } else {
      final snackBar =
          Utilities.createSnackBar(uploadProfilePictureNotifier.error);

      // close loading indicator
      Navigator.pop(context);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
