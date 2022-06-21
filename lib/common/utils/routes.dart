import 'package:flutter/widgets.dart';

// Some routes name
const loginRoute = '/login';
const registerRoute = '/register';
const forgotPasswordRoute = '/forgot-password';
const additionalInfoRoute = '/add-info';
const mainRoute = '/main';
const profileRoute = '/profile';
const updateProfileRoute = '/profile/update';
const newsDetailRoute = '/news-detail';
const newsWebViewRoute = '/news-webview';
const newsBookmarksRoute = '/news-bookmarks';
const alarmNutriTime = '/alarm-nutri-time';
const alarmNutriTimePage = '/alarm-nutri-time-page';

// Register the RouteObserver as a navigation observer.
final routeObserver = RouteObserver<ModalRoute<void>>();
