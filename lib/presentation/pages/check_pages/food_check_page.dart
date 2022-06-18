import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/search_field.dart';

class FoodCheckPage extends StatefulWidget {
  const FoodCheckPage({Key? key}) : super(key: key);

  @override
  State<FoodCheckPage> createState() => _FoodCheckPageState();
}

class _FoodCheckPageState extends State<FoodCheckPage> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  toolbarHeight: 64,
                  backgroundColor: secondaryBackgroundColor,
                  shadowColor: Colors.black.withOpacity(0.6),
                  centerTitle: true,
                  title: const Text(
                    'Food Nutrition Check',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      size: 32,
                    ),
                    tooltip: 'Back',
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.history_rounded),
                      tooltip: 'History',
                    )
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(72),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: SearchField(
                        controller: _searchController,
                        backgroundColor: primaryBackgroundColor,
                        query: '',
                        hintText: 'Masukkan nama makanan atau minuman...',
                        onTap: () {
                          // _scrollController.animateTo(
                          //   0,
                          //   duration: const Duration(milliseconds: 250),
                          //   curve: Curves.easeOut,
                          // );
                        },
                        onChanged: (value) {
                          // newsNotifier.onChangedQuery = value.trim();
                        },
                        onSubmitted: (value) {
                          // if (value.trim().isNotEmpty) {
                          //   newsNotifier.searchNews(page: 1, query: value);
                          // }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: const CustomInformation(
          key: Key('first_greeting'),
          imgPath: 'assets/svg/pasta_cuate.svg',
          title: 'Mau nyari apa yo?',
          subtitle: 'Hasil pencarian anda akan muncul di sini.',
        ),
      ),
    );
  }
}
