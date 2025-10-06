import 'package:task_manager/src/utils/app_utils.dart';

abstract class Bloc {
  void dispose();

  Future<bool> get isNetworkAvailable async =>
      await CommonUtils.isNetworkAvailable();
}
