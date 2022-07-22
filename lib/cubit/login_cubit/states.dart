


import '../../models/userVm.dart';

abstract class LoginStats{}
class LoginInitialStats extends LoginStats{}
class LoginSuccessStats extends LoginStats{
  final UserVm loginModel;
  LoginSuccessStats(this.loginModel);
}
class LoginLoadinglStats extends LoginStats{}
class LoginShowePasswordlStats extends LoginStats{}
class LoginErrorlStats extends LoginStats{
  final error;
  LoginErrorlStats({this.error});
}