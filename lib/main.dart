import 'package:flutter/material.dart';
import 'package:maskapp/ui/view/mainpage.dart';
import 'package:maskapp/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ChangeNotifierProvider.value(value: StoreModel(), child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}


