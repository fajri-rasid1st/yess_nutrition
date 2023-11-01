import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_auth_notifiers/user_auth_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_data_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataNotifier>(
      builder: (context, result, child) {
        if (result.state == UserState.success) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
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
                              'Pengaturan Profil',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 46),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: secondaryColor,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: result.userData.imgUrl.isEmpty
                          ? Image.asset(
                              'assets/img/default_user_pict.png',
                              fit: BoxFit.cover,
                            )
                          : CustomNetworkImage(
                              imgUrl: result.userData.imgUrl,
                              fit: BoxFit.cover,
                              placeHolderSize: 60,
                              errorIcon: Icons.person_off_rounded,
                            ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              result.userData.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: primaryTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          result.userData.gender == 'Laki-laki'
                              ? MdiIcons.genderMale
                              : MdiIcons.genderFemale,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${result.userData.age} Tahun',
                      style: const TextStyle(
                        color: secondaryTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Text(
                        result.userData.bio.isNotEmpty
                            ? result.userData.bio
                            : 'Belum ada bio.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryTextColor.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          updateProfileRoute,
                          arguments: result.userData,
                        );
                      },
                      icon: const Icon(
                        MdiIcons.accountEditOutline,
                        size: 16,
                      ),
                      label: const Text('Perbaharui Profil'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        textStyle: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(letterSpacing: 0.25),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 56),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: primaryBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: secondaryColor.withOpacity(0.4),
                            offset: const Offset(0.0, -4.0),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  MdiIcons.bellOutline,
                                  color: primaryColor,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Pemberitahuan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Hidup atau matikan pemberitahuan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: primaryTextColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              FlutterSwitch(
                                width: 56,
                                height: 32,
                                inactiveColor: secondaryColor,
                                inactiveToggleColor: primaryColor,
                                activeColor: primaryColor,
                                value: status,
                                onToggle: (value) {
                                  setState(() => status = value);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildListTileProfile(
                            MdiIcons.lockOutline,
                            'Ubah Password',
                            () {
                              Navigator.pushNamed(
                                context,
                                forgotPasswordRoute,
                                arguments: result.userData.email,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: dividerColor.withOpacity(0.6),
                          ),
                          const SizedBox(height: 16),
                          _buildListTileProfile(
                            MdiIcons.informationOutline,
                            'Informasi',
                            () {},
                          ),
                          const SizedBox(height: 16),
                          _buildListTileProfile(
                            MdiIcons.logout,
                            'Keluar',
                            () {
                              Utilities.showConfirmDialog(
                                context,
                                title: 'Konfirmasi',
                                question: 'Apakah anda yakin ingin keluar?',
                                onPressedPrimaryAction: () async {
                                  await context
                                      .read<UserAuthNotifier>()
                                      .signOut();

                                  if (!mounted) return;

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    loginRoute,
                                    (route) => false,
                                  );
                                },
                                onPressedSecondaryAction: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(body: LoadingIndicator());
      },
    );
  }

  ClipRRect _buildListTileProfile(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryTextColor,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(
                MdiIcons.chevronRight,
                color: primaryColor,
                size: 26,
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
