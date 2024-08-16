import '../models/bottom_tab_model.dart';
import '../utils/image_resource.dart';

class TabViewConstant {
  static List<BottomTabBarModel> tabData = [
    BottomTabBarModel(ImageResource.homeTab),
    BottomTabBarModel(ImageResource.searchTab),
    BottomTabBarModel(ImageResource.micTab, isCenter: true),
    BottomTabBarModel(ImageResource.userTab),
    BottomTabBarModel(ImageResource.profileTab, isProfile: true),
  ];
}
