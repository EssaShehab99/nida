import 'package:flutter/cupertino.dart';
import '/modules/navigation/custom_transition_delegate.dart';
import '/modules/Screens/connect_us.dart';
import '/modules/Screens/post_details.dart';

import '../../data/providers/app_state_manager.dart';
import '../../data/providers/connect_us_manager.dart';
import '../../data/providers/post_manager.dart';
import '../../data/providers/home_manager.dart';
import '../../data/setting/app_pages.dart';
import '../Screens/home.dart';
import 'app_link.dart';


class AppRoute extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final HomeManager homeManager;
  final PostManager postManager;
  final ConnectUsManager connectUsManager;

  AppRoute({
    required this.appStateManager,
    required this.homeManager,
    required this.postManager,
    required this.connectUsManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    homeManager.addListener(notifyListeners);
    postManager.addListener(notifyListeners);
    connectUsManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    homeManager.removeListener(notifyListeners);
    postManager.removeListener(notifyListeners);
    connectUsManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      transitionDelegate: CustomTransitionDelegate(),
      pages: [
       ...[
          Home.page(),
          if(postManager.didSelectedPage)
            PostDetails.page(postManager.post!)
          else if(connectUsManager.didSelectedPage)
            ConnectUs.page()
        ]
      ],
    );
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();

  AppLink getCurrentPath() {
    if (postManager.didSelectedPage) {
      final id = postManager.post?.id;
      return AppLink(location: AppLink.kPostPath, postId: id);
    } else if (connectUsManager.didSelectedPage) {
      return AppLink(location: AppLink.kConnectUsPath);
    } else if (homeManager.didSelectedPage) {
      return AppLink(location: AppLink.kHomePath);
    } else {
      return AppLink(location: AppLink.kHomePath);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    switch (configuration.location) {
      case AppLink.kHomePath:
        homeManager.selectedPage(true);
        postManager.selectedPage(false);
        connectUsManager.selectedPage(false);
        break;
      case AppLink.kConnectUsPath:
        connectUsManager.selectedPage(true);

        break;
      case AppLink.kPostPath:
        postManager.selectedPage(true, post: postManager.post);
        break;
      default:
        break;
    }
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    if (route.settings.name == AppPages.homePath) {
      homeManager.selectedPage(false);

    }
    if (route.settings.name == AppPages.connectUsPath) {
      connectUsManager.selectedPage(false);
    }
    if (route.settings.name == AppPages.postPath) {
      postManager.selectedPage(false);
    }
    return true;
  }
}
