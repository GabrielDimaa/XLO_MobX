import 'package:XLO_mobX/screens/base/base_screen.dart';
import 'package:XLO_mobX/stores/category_store.dart';
import 'package:XLO_mobX/stores/home_store.dart';
import 'package:XLO_mobX/stores/page_store.dart';
import 'package:XLO_mobX/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await initalizeParse();
	setupLocators();
	runApp(MyApp());
}

Future<void> initalizeParse() async {
	await Parse().initialize(
		'LxCqQPISEMxlYExRcgk0yCgWSeYOEMqLgIsC9f6h',
		'https://parseapi.back4app.com/',
		clientKey: 'sIVpDekyDLdilSxVhFiMpZC9AgkzIzOlx8rnvyUY',
		autoSendSessionId: true,
		debug: true
	);
}

void setupLocators() {
	GetIt.I.registerSingleton(PageStore());
	GetIt.I.registerSingleton(HomeStore());
	GetIt.I.registerSingleton(UserManagerStore());
	GetIt.I.registerSingleton(CategoryStore());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'XLO',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				primarySwatch: Colors.purple,
				scaffoldBackgroundColor: Colors.purple,
				visualDensity: VisualDensity.adaptivePlatformDensity,
				appBarTheme: AppBarTheme(
					elevation: 0
				),
				cursorColor: Colors.purple
			),
      supportedLocales: const [
        Locale('pt', 'BR')
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
			home: BaseScreen()
		);
	}
}