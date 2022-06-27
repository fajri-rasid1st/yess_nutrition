import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/presentation/providers/food_notifiers/food_history_notifier.dart';
import 'package:yess_nutrition/presentation/providers/food_notifiers/search_food_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/food_hint_list_tile.dart';
import 'package:yess_nutrition/presentation/widgets/food_list_tile.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/search_field.dart';

class FoodCheckPage extends StatefulWidget {
  final String uid;

  const FoodCheckPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<FoodCheckPage> createState() => _FoodCheckPageState();
}

class _FoodCheckPageState extends State<FoodCheckPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
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
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: secondaryBackgroundColor,
                  shadowColor: Colors.black.withOpacity(0.5),
                  toolbarHeight: 64,
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
                      onPressed: () => Navigator.pushNamed(
                        context,
                        foodAndProductCheckHistoryRoute,
                        arguments: widget.uid,
                      ),
                      icon: const Icon(Icons.history_rounded),
                      tooltip: 'History',
                    )
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(68),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: _buildSearchField(),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Consumer<SearchFoodNotifier>(
          builder: (context, foodNotifier, child) {
            final onChangedQuery = foodNotifier.onChangedQuery;
            final onSubmittedQuery = foodNotifier.onSubmittedQuery;
            final isOnChangedQueryEmpty = onChangedQuery.isEmpty;
            final isOnSubmittedQueryEmpty = onSubmittedQuery.isEmpty;
            final isTyping = onChangedQuery != onSubmittedQuery;

            if (isOnChangedQueryEmpty || isOnSubmittedQueryEmpty || isTyping) {
              return _buildFirstView();
            }

            if (foodNotifier.state == RequestState.success) {
              return foodNotifier.results.isEmpty && foodNotifier.hints.isEmpty
                  ? _buildSearchEmpty()
                  : _buildSearchResults(context, foodNotifier);
            }

            if (foodNotifier.state == RequestState.error) {
              return _buildSearchError(context, foodNotifier);
            }

            return const LoadingIndicator();
          },
        ),
      ),
    );
  }

  Consumer<SearchFoodNotifier> _buildSearchField() {
    return Consumer<SearchFoodNotifier>(
      builder: (context, foodNotifier, child) {
        return SearchField(
          controller: _searchController,
          backgroundColor: primaryBackgroundColor,
          query: foodNotifier.onChangedQuery,
          hintText: 'Cari nama makanan atau minuman...',
          onChanged: (value) {
            foodNotifier.onChangedQuery = value.trim();
          },
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              foodNotifier.searchFoods(query: value).then((_) async {
                // add every search results to history
                await addSearchedToHistory(context, foodNotifier);
              });
            }
          },
        );
      },
    );
  }

  SingleChildScrollView _buildSearchResults(
    BuildContext context,
    SearchFoodNotifier foodNotifier,
  ) {
    final results = foodNotifier.results;
    final hints = foodNotifier.hints;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Hasil Pencarian:',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          if (results.isEmpty) ...[
            _buildSearchEmpty(),
          ] else ...[
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return FoodListTile(
                  food: results[index],
                  onPressedTimeIcon: () {},
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
          ],
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 20),
            child: Divider(
              height: 8,
              thickness: 8,
              color: scaffoldBackgroundColor,
            ),
          ),
          if (hints.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Rekomendasi untukmu:',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemCount: hints.length > 16 ? 16 : hints.length,
              itemBuilder: (_, index) {
                return FoodHintListTile(
                  food: hints[index],
                  onPressedSearchIcon: () {
                    final label = hints[index].label;

                    // change search field text
                    _searchController.text = label;

                    // change on changed query
                    foodNotifier.onChangedQuery = label;

                    // search foods, according to item label
                    foodNotifier.searchFoods(query: label).then((_) async {
                      // add every search results to history
                      await addSearchedToHistory(context, foodNotifier);
                    });
                  },
                  onPressedTimeIcon: () {},
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
          ]
        ],
      ),
    );
  }

  CustomInformation _buildFirstView() {
    return const CustomInformation(
      key: Key('first_view'),
      imgPath: 'assets/svg/pasta_cuate.svg',
      title: 'Mau cari apa hari ini?',
      subtitle: 'Hasil pencarian anda akan muncul di sini.',
    );
  }

  CustomInformation _buildSearchEmpty() {
    return const CustomInformation(
      key: Key('query_not_found'),
      imgPath: 'assets/svg/not_found_cuate.svg',
      title: 'Hasil tidak ditemukan',
      subtitle: 'Coba masukkan kata kunci yang lain.',
    );
  }

  CustomInformation _buildSearchError(
    BuildContext context,
    SearchFoodNotifier foodNotifier,
  ) {
    return CustomInformation(
      key: const Key('error_message'),
      imgPath: 'assets/svg/error_robot_cuate.svg',
      title: foodNotifier.message,
      subtitle: 'Silahkan coba beberapa saat lagi.',
      child: ElevatedButton.icon(
        onPressed: foodNotifier.isReload
            ? null
            : () {
                // set isReload to true
                foodNotifier.isReload = true;

                Future.wait([
                  // create one second delay
                  Future.delayed(const Duration(seconds: 1)),

                  // refresh page
                  foodNotifier.refresh(),
                ]).then((_) async {
                  // add every search results to history
                  await addSearchedToHistory(context, foodNotifier);

                  // set isReload to true
                  foodNotifier.isReload = false;
                });
              },
        icon: foodNotifier.isReload
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: dividerColor,
                ),
              )
            : const Icon(Icons.refresh_rounded),
        label: foodNotifier.isReload
            ? const Text('Tunggu sebentar...')
            : const Text('Coba lagi'),
      ),
    );
  }

  Future<void> addSearchedToHistory(
    BuildContext context,
    SearchFoodNotifier foodNotifier,
  ) async {
    if (foodNotifier.state == RequestState.success) {
      for (var food in foodNotifier.results) {
        final foodHistory = food.copyWith(
          uid: widget.uid,
          createdAt: DateTime.now(),
        );

        await context.read<FoodHistoryNotifier>().addFoodHistory(foodHistory);
      }
    }
  }
}
