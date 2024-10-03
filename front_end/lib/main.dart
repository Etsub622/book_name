import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/core/config/router_config.dart';
import 'package:front_end/core/util/bloc_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/injection/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final router = await AppRouter.router;
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  final BlocMultiProvider blocMultiProvider = BlocMultiProvider();

  MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (BuildContext context, Widget? child) {
            return MultiBlocProvider(
              providers: blocMultiProvider.blocMultiProvider(),
              child: MaterialApp.router(
                routerConfig: router,
                title: 'Book Store',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Color(0xff800080)),
                  useMaterial3: true,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
