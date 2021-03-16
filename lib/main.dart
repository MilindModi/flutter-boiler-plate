import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:boiler_plate_1/api_client/api_util.dart';
import 'package:boiler_plate_1/util/shared_preference_util.dart';

void main() {
  runApp(MyApp());
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
      home: CustomButton('click me!'),
    );
  }
}

class CustomButton extends StatelessWidget {
   String _title;
   CustomButton(this._title);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _getApiData,
            child: Text('Increment Counter'),
          ),
        ),
      ),
    );
  }

  void _incrementCounter() async  {
    int counter =  await MySharedPreferences.instance.getIntegerValue('counter') + 1 ;
    print('Pressed $counter times.');
    await MySharedPreferences.instance.setIntegerValue('counter', counter);
  }

  Future<void> _getApiData() async {
    Dio dio = new Dio();
    ApiClient api = new ApiClient(dio);
    Response data = await api.get("/ditto");
    print(data.data);
  }
}



//What are the steps i did for the shared preferences
  // installed  shared_preferences: in yaml
  //than i created a util package
  //i create share_preference_util.dart file and put the code
  //and now i changed the code in main.dart to check whether the preference is working or not
  //added button and on click i added _incrementCounter method in same main.dart file

//what are the steps i did for the
//1. created api_client package
//api_client/api_errors , api_client/exceptions , api_client/interceptors , api_util.dart
//installed the
// json_annotation: ^4.0.0
// dio:

//in main i changed the methods
