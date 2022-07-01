import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/button_style.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
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

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormBuilderState>();
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
      initialValue: widget.userData.name,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      maxLength: 100,
      decoration: const InputDecoration(
        labelText: 'Nama',
        hintText: 'Masukkan nama kamu',
        hintStyle: TextStyle(color: secondaryTextColor),
        prefixIcon: Icon(Icons.person_outline),
      ),
      validator: FormBuilderValidators.required(
        errorText: 'Bagian ini harus diisi.',
      ),
    );
  }

  FormBuilderTextField _buildBioField() {
    return FormBuilderTextField(
      name: 'bio',
      initialValue: widget.userData.bio,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: 'Bio',
        hintText: 'Masukkan bio anda',
        hintStyle: TextStyle(color: secondaryTextColor),
        prefixIcon: Icon(Icons.info_outline),
      ),
      validator: FormBuilderValidators.maxLength(
        255,
        errorText: 'Maksimal 255 Karakter',
      ),
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
    );
  }

  FormBuilderTextField _buildAgeField() {
    return FormBuilderTextField(
      name: 'age',
      initialValue: widget.userData.age == 0 ? '' : '${widget.userData.age}',
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Umur (tahun)',
        hintText: 'Masukkan umur kamu',
        hintStyle: TextStyle(color: secondaryTextColor),
        prefixIcon: Icon(Icons.man_outlined),
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(3),
      ],
      validator: FormBuilderValidators.match(
        r'^[1-9]\d*$',
        errorText: 'Format yang dimasukkan salah.',
      ),
    );
  }

  FormBuilderTextField _buildWeightField() {
    return FormBuilderTextField(
      name: 'weight',
      initialValue:
          widget.userData.weight == 0 ? '' : '${widget.userData.weight}',
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Berat Badan (kg)',
        hintText: 'Masukkan berat badan kamu',
        hintStyle: TextStyle(color: secondaryTextColor),
        prefixIcon: Icon(Icons.monitor_weight_outlined),
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(3),
      ],
      validator: FormBuilderValidators.match(
        r'^[1-9]\d*$',
        errorText: 'Format yang dimasukkan salah.',
      ),
    );
  }

  FormBuilderTextField _buildHeightField() {
    return FormBuilderTextField(
      name: 'height',
      initialValue:
          widget.userData.height == 0 ? '' : '${widget.userData.height}',
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Tinggi Badan (cm)',
        hintText: 'Masukkan tinggi badan kamu',
        hintStyle: TextStyle(color: secondaryTextColor),
        prefixIcon: Icon(Icons.height_outlined),
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(3),
      ],
      validator: FormBuilderValidators.match(
        r'^[1-9]\d*$',
        errorText: 'Format yang dimasukkan salah.',
      ),
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

    // If no internet connection, return
    if (!await InternetConnectionChecker().hasConnection) {
      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar('Proses gagal. Koneksi internet tidak ada.'),
        );

      return;
    }

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;

      // show loading when on process
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // updated user data
      final updatedUserData = widget.userData.copyWith(
        name: value['name'],
        bio: value['bio'],
        gender: value['gender'],
        age: int.tryParse(value['age']) ?? 0,
        weight: int.tryParse(value['weight']) ?? 0,
        height: int.tryParse(value['height']) ?? 0,
      );

      final isUpdated = await _updateUserData(context, updatedUserData) &&
          await _createUserNutrients(context, updatedUserData);

      if (isUpdated) {
        // close loading indicator
        navigatorKey.currentState!.pop();

        // Close Update Profile Page
        navigatorKey.currentState!.pop();

        scaffoldMessengerKey.currentState!
          ..hideCurrentSnackBar()
          ..showSnackBar(
            Utilities.createSnackBar('Berhasil memperbaharui profil'),
          );
      } else {
        // close loading indicator
        navigatorKey.currentState!.pop();

        scaffoldMessengerKey.currentState!
          ..hideCurrentSnackBar()
          ..showSnackBar(
            Utilities.createSnackBar('Terjadi kesalahan. Silahkan coba lagi'),
          );
      }
    }
  }

  // return true if user data updated successfully, otherwise return false
  Future<bool> _updateUserData(
    BuildContext context,
    UserDataEntity userData,
  ) async {
    final userDataNotifier = context.read<UserDataNotifier>();

    // update user data on firestore
    await userDataNotifier.updateUserData(userData);

    // refresh data
    await userDataNotifier.refresh(widget.userData.uid);

    if (userDataNotifier.state == UserState.success) return Future.value(true);

    return Future.value(false);
  }

  // return true if user nutrients updated successfully, otherwise return false
  Future<bool> _createUserNutrients(
    BuildContext context,
    UserDataEntity userData,
  ) async {
    if (userData.age == 0 &&
        userData.weight == 0 &&
        userData.height == 0 &&
        userData.gender.isEmpty) {
      return Future.value(true);
    }

    final userNutrientsNotifier = context.read<UserNutrientsNotifier>();

    await userNutrientsNotifier.readUserNutrients(userData.uid);

    final userNutrients = userNutrientsNotifier.userNutrients;

    if (userNutrients != null) return Future.value(true);

    // get user daily nutrients needs (BMR)
    final userNeeds = Utilities.calculateUserNutrients(userData);

    // create user nutrients
    await userNutrientsNotifier.createUserNutrients(userNeeds);

    // refresh data
    await userNutrientsNotifier.refresh(userData.uid);

    if (userNutrientsNotifier.state == UserState.success) {
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<void> _onPressedProfilePictureButton(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <ListTile>[
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
            ListTile(
              leading: const Icon(MdiIcons.deleteForeverOutline),
              title: const Text('Hapus Gambar Profil'),
              onTap: () {
                Navigator.pop(context);
                _deleteProfilePicture(widget.userData.uid);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);

    if (pickedFile == null) return;

    final file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (file == null) return;

    final filecrop = await compressImage(file.path, 35);

    await _uploadFile(filecrop.path);
  }

  Future<void> _uploadFile(String path) async {
    // If no internet connection, return
    if (!await InternetConnectionChecker().hasConnection) {
      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar('Proses gagal. Koneksi internet tidak ada.'),
        );

      return;
    }

    // show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator(),
    );

    final uploadProfilePictureNotifier = context.read<UserStorageNotifier>();

    await uploadProfilePictureNotifier.uploadProfilePicture(
      path,
      p.basename(path),
    );

    if (!mounted) return;

    if (uploadProfilePictureNotifier.state == UserState.success) {
      final userDataNotifier = context.read<UserDataNotifier>();

      final url = uploadProfilePictureNotifier.downloadUrl;

      // read user data
      await userDataNotifier.readUserData(widget.userData.uid);

      if (userDataNotifier.state == UserState.success) {
        // get user data
        final userData = userDataNotifier.userData;

        // updated user data
        final updatedUserData = userData.copyWith(imgUrl: url);

        // update user data on firestore
        await userDataNotifier.updateUserData(updatedUserData);

        if (!mounted) return;

        if (userDataNotifier.state == UserState.success) {
          userDataNotifier.refresh(userData.uid);

          // close loading indicator
          Navigator.pop(context);

          // close update profile page
          Navigator.pop(context);
        }
      }
    } else {
      // close loading indicator
      Navigator.pop(context);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar(uploadProfilePictureNotifier.error),
        );
    }
  }

  Future<void> _deleteProfilePicture(String uid) async {
    // If no internet connection, return
    if (!await InternetConnectionChecker().hasConnection) {
      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar('Proses gagal. Koneksi internet tidak ada.'),
        );

      return;
    }

    // show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator(),
    );

    final userDataNotifier = context.read<UserDataNotifier>();

    // read user data
    await userDataNotifier.readUserData(uid);

    if (!mounted) return;

    if (userDataNotifier.state == UserState.success) {
      final imgUrl = userDataNotifier.userData.imgUrl;

      if (imgUrl.isEmpty || imgUrl.contains('lh3.googleusercontent.com')) {
        // close loading indicator
        Navigator.pop(context);

        scaffoldMessengerKey.currentState!
          ..hideCurrentSnackBar()
          ..showSnackBar(
            Utilities.createSnackBar('Gambar default tidak dapat dihapus'),
          );

        return;
      }

      final deleteProfilePictureNotifier = context.read<UserStorageNotifier>();

      await deleteProfilePictureNotifier.deleteProfilePicture(uid);

      if (!mounted) return;

      if (deleteProfilePictureNotifier.state == UserState.error) {
        // close loading indicator
        Navigator.pop(context);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            Utilities.createSnackBar(deleteProfilePictureNotifier.error),
          );
      }

      // get user data
      final userData = userDataNotifier.userData;

      // updated user data
      final updatedUserData = userData.copyWith(imgUrl: '');

      // update user data on firestore
      await userDataNotifier.updateUserData(updatedUserData);

      if (!mounted) return;

      if (userDataNotifier.state == UserState.success) {
        userDataNotifier.refresh(userData.uid);

        // close loading indicator
        Navigator.pop(context);

        // Close Update profile page
        Navigator.pop(context);
      }
    }
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join(
      (await getTemporaryDirectory()).path,
      '${widget.userData.uid}${p.extension(path)}',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }
}
