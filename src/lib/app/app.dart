import 'package:todo_app_v4/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:todo_app_v4/features/home/widgets/add_todo_sheet.dart';
import 'package:todo_app_v4/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:todo_app_v4/features/home/home_view.dart';
import 'package:todo_app_v4/features/startup/startup_view.dart';
import 'package:todo_app_v4/services/database_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: AddTodoSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
