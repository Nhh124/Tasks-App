// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/business_logic/blocs/switch_bloc/switch_bloc.dart';
import 'package:flutter_tasks_app/services/app_theme.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_tasks_app/services/app_router.dart';

import 'business_logic/bloc_exports.dart';
import 'presentation/screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(
        appRouter: AppRouter(),
      ),
    ),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(),
        ),
        BlocProvider<SwitchBloc>(
          create: (context) => SwitchBloc(),
        ),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            debugShowCheckedModeBanner: false,
            home: const TasksScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
