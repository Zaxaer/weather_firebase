import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_firebase/ui/screen/main_weather_screen/main_weather_screen_widget_model.dart';
import 'package:weather_firebase/ui/themes/app_colors.dart';
import 'package:weather_firebase/ui/themes/app_text_style.dart';

class MainWeatherScreenWidget extends StatefulWidget {
  const MainWeatherScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainWeatherScreenWidget> createState() =>
      _MainWeatherScreenWidgetState();
}

class _MainWeatherScreenWidgetState extends State<MainWeatherScreenWidget> {
  @override
  void didChangeDependencies() {
    final snackMessage =
        context.watch<MainWeatherScreenWidgetModel>().snackMessage;
    if (snackMessage.isNotEmpty) {
      Future.microtask(
          () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(snackMessage),
              )));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainWeatherScreenWidgetModel>();
    return Scaffold(
      floatingActionButton: const _AddWeatherInFB(),
      body: RefreshIndicator(
        onRefresh: () => model.determinePosition(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 10),
              model.errorMessage.isEmpty
                  ? const _CardWeatherWidget()
                  : _ErrorText(errorMessage: model.errorMessage),
              const SizedBox(height: 10),
              _TextWidget(text: model.date, size: 50),
              const SizedBox(height: 10),
              const RepaintBoundary(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Center(child: _TimerWidget()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _TextWidget(
          text: errorMessage,
          size: 20,
        ),
      ),
    );
  }
}

class _AddWeatherInFB extends StatelessWidget {
  const _AddWeatherInFB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addData = context.read<MainWeatherScreenWidgetModel>().addDataWeather;
    return FloatingActionButton(
      backgroundColor: AppColors.mainColor,
      child: const Icon(Icons.add),
      onPressed: () => addData(),
    );
  }
}

class _CardWeatherWidget extends StatelessWidget {
  const _CardWeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherData =
        context.watch<MainWeatherScreenWidgetModel>().weatherData;
    if (weatherData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      color: AppColors.mainColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            _TextWidget(text: weatherData.name, size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TextWidget(
                  text: '${weatherData.main.temp.toInt()} \u00b0',
                  size: 50,
                ),
                Image.network(
                    "http://openweathermap.org/img/wn/${weatherData.weather.first.icon}@2x.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TextWidget(
                  text: '${weatherData.wind.speed} м/с',
                  size: 30,
                ),
                _TextWidget(size: 30, text: '${weatherData.main.humidity} %')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TextWidget extends StatelessWidget {
  final double size;
  final String text;
  const _TextWidget({
    Key? key,
    required this.size,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppTextStyle.button.copyWith(fontSize: size),
    );
  }
}

class _TimerWidget extends StatefulWidget {
  const _TimerWidget({Key? key}) : super(key: key);

  @override
  __TimerWidgetState createState() => __TimerWidgetState();
}

class __TimerWidgetState extends State<_TimerWidget>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  String timer = '';
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        timer = DateFormat.Hms().format(DateTime.now()).toString();
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _TextWidget(text: timer, size: 50);
  }
}
