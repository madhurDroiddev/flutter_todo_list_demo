import 'package:firebasechat/src/utils/app_utils.dart';

abstract class Bloc {
  void dispose();

  Future<bool> get isNetworkAvailable async =>
      await CommonUtils.isNetworkAvailable();
}
