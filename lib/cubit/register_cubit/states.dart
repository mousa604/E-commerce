


import '../../models/userVm.dart';

abstract class RegisterStats{}
class RegisterInitialStats extends RegisterStats{}
class RegisterSuccessStats extends RegisterStats{
  final UserVm loginModel;
  RegisterSuccessStats(this.loginModel);
}
class RegisterLoadinglStats extends RegisterStats{}
class RegisterShowePasswordlStats extends RegisterStats{}
class RegisterErrorlStats extends RegisterStats{
  final error;
  RegisterErrorlStats({this.error});
}