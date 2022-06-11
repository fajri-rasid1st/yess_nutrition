import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/auth_notifiers/sign_out_notifier.dart';

class ProfilePage extends StatefulWidget {
  final UserDataEntity userData;

  const ProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
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
                        "Pengaturan Profil",
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
              const SizedBox(height: 36),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Brandon Salim",
                    style: TextStyle(
                      fontSize: 24,
                      color: primaryTextColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    MdiIcons.genderMale,
                    size: 24,
                    color: primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "12 Tahun",
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  "Sehatkan dirimu biar masa renta sanggup melihat anak dan cucumu bahagia.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryTextColor.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, updateProfileRoute);
                },
                icon: const Icon(
                  MdiIcons.accountEditOutline,
                  size: 16,
                ),
                label: const Text("Perbaharui Profil"),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(letterSpacing: 0.25),
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
                            size: 22,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "Pemberitahuan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryTextColor,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Hidup atau matikan pemberitahuan",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: primaryTextColor,
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
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildListTileProfile(
                      MdiIcons.lockOutline,
                      "Ubah Password",
                      () {},
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: dividerColor.withOpacity(0.6),
                    ),
                    const SizedBox(height: 16),
                    _buildListTileProfile(
                      MdiIcons.informationOutline,
                      "Informasi",
                      () {},
                    ),
                    const SizedBox(height: 16),
                    _buildListTileProfile(
                      MdiIcons.logout,
                      "Keluar",
                      () async {
                        await context.read<SignOutNotifier>().signOut();

                        if (!mounted) return;

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          loginRoute,
                          (route) => false,
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

  GestureDetector _buildListTileProfile(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
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
              size: 22,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryTextColor,
            ),
          ),
          const Spacer(),
          const Icon(
            MdiIcons.chevronRight,
            size: 26,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
