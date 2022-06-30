import 'package:flutter/material.dart';

// Some routes name
const loginRoute = '/login';
const registerRoute = '/register';
const forgotPasswordRoute = '/forgot-password';
const additionalInfoRoute = '/add-info';
const mainRoute = '/main';
const nutrientsDetailRoute = '/nutrients-detail';
const webviewRoute = '/webview';
const profileRoute = '/profile';
const updateProfileRoute = '/profile-update';
const scheduleAlarmRoute = '/schedule-alarm';
const checkRoute = '/check';
const foodCheckRoute = '/check-food';
const productCheckRoute = '/check-product';
const foodAndProductCheckHistoryRoute = '/check-food-and-product-history';
const recipeCheckRoute = '/check-recipe';
const recipeDetailRoute = '/check-recipe-detail';
const recipeWebViewRoute = '/check-recipe-webview';
const recipeBookmarksRoute = '/check-recipe-bookmarks';
const newsDetailRoute = '/news-detail';
const newsBookmarksRoute = '/news-bookmarks';
const productsRoute = '/products';
const favoriteProductsRoute = '/favorite-products';

// Register the RouteObserver as a navigation observer.
final routeObserver = RouteObserver<ModalRoute<void>>();
