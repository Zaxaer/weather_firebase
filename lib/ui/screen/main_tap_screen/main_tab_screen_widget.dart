import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_firebase/ui/screen/main_data_screen/data_screen_widget.dart';
import 'package:weather_firebase/ui/screen/main_data_screen/data_screen_widget_model.dart';
import 'package:weather_firebase/ui/screen/main_tap_screen/main_tab_screen_widget_model.dart';
import 'package:weather_firebase/ui/screen/main_weather_screen/main_weather_screen_widget.dart';
import 'package:weather_firebase/ui/screen/main_weather_screen/main_weather_screen_widget_model.dart';
import 'package:weather_firebase/ui/themes/app_colors.dart';
import 'package:weather_firebase/ui/themes/app_text_style.dart';

class MainTabScreenWidget extends StatelessWidget {
  const MainTabScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = context.watch<MainTabScreenWidgetModel>().currentTabIndex;
    final model = context.watch<MainTabScreenWidgetModel>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gradientTop,
            AppColors.gradientBot,
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather',
            style: AppTextStyle.button,
          ),
        ),
        drawer: const _DrawerWidget(),
        body: IndexedStack(
          index: index,
          children: [
            ChangeNotifierProvider(
                create: (_) => MainWeatherScreenWidgetModel(),
                child: const MainWeatherScreenWidget()),
            ChangeNotifierProvider(
                create: (_) => DataWeatherWidgetModel(),
                child: const DataWeatherWidget()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              label: 'List data',
            ),
          ],
          currentIndex: index,
          onTap: (indexSelect) => model.setCurrentTabIndex(indexSelect),
        ),
      ),
    );
  }
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainTabScreenWidgetModel>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.mainColor,
            ),
            child: Text('Weather menu'),
          ),
          ListTile(
            title: const Text('Weather tooday'),
            onTap: () {
              model.setCurrentTabIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Data weather'),
            onTap: () {
              model.setCurrentTabIndex(1);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
