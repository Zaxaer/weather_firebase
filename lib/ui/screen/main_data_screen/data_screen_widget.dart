import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_firebase/ui/screen/main_data_screen/data_screen_widget_model.dart';
import 'package:weather_firebase/ui/themes/app_text_style.dart';

class DataWeatherWidget extends StatelessWidget {
  const DataWeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('weather_item').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data?.docs.isEmpty ?? true) {
          return const Center(
            child: Text(
              'Список пуст',
              style: AppTextStyle.button,
            ),
          );
        }
        return ListView.separated(
          itemCount: snapshot.data?.docs.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return _CardDataWeather(
              index: index,
              snapshot: snapshot,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1);
          },
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _CardDataWeather extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;
  _CardDataWeather({
    Key? key,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DataWeatherWidgetModel>();
    return Dismissible(
      onDismissed: (direction) {
        model.deleteDataWeather(index, snapshot);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Данные удалены')));
      },
      key: Key(snapshot.data!.docs[index].id),
      child: ListTile(
        title: Text('${model.value(index, 'temp', snapshot)} \u00b0 C',
            style: AppTextStyle.button.copyWith(fontSize: 16)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${model.value(index, 'humidity', snapshot)} %',
                style: AppTextStyle.button.copyWith(fontSize: 16)),
            Text('${model.value(index, 'speed', snapshot)} м/с',
                style: AppTextStyle.button.copyWith(fontSize: 16)),
          ],
        ),
        subtitle: Text(model.value(index, 'data', snapshot),
            style: AppTextStyle.button.copyWith(fontSize: 16)),
        leading: Text('${index + 1}',
            style: AppTextStyle.button.copyWith(fontSize: 18)),
      ),
    );
  }
}
