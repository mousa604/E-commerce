

import '../../models/changefavVM.dart';
import '../../models/userVm.dart';

abstract class ShopStats{}

class InitialState extends ShopStats{}
class BottomNavBarState extends ShopStats{}
class HomeLoadingStats extends ShopStats{}
class HomeSuccessStat extends ShopStats{}
class HomeErrorStat extends ShopStats{}
class CategoriesSuccessStat extends ShopStats{}
class CategoriesErrorStat extends ShopStats{}
class ChangeFavSuccessStat extends ShopStats{}
class FavSuccessStat extends ShopStats{
   final ChangeFavVm ?model;
   FavSuccessStat(this.model);
}
class ChangeFavErrorStat extends ShopStats{}

class GatFavErrorStat extends ShopStats{}
class GetFavSuccessStat extends ShopStats{}
class LoadingGatFavErrorStat extends ShopStats{}

class UserDataErrorStat extends ShopStats{}
class UserDataSuccessStat extends ShopStats{}
class LoadingUserDataStat extends ShopStats{}

class UpdateUserDataErrorStat extends ShopStats{}
class UpdateUserDataSuccessStat extends ShopStats{
   final UserVm? loginModel;
   UpdateUserDataSuccessStat(this.loginModel);

}
class LoadingUpdateUserDataStat extends ShopStats{}


