import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const DatePickerPage(title: 'Flutter Demo Pick Date'),
    );
  }
}

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key, required this.title});
  final String title;
  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}
class _DatePickerPageState extends State<DatePickerPage> {
//controller of textField
  TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: TextField(
                    cursorHeight: 20,
                    readOnly:
                    true, //set it true, so that user will not able to edit text
                    controller: _dateController,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: Colors.blueGrey,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.date_range,
                          color: Colors.blueGrey, size: 25),
                      hintText: "Enter date",
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        if (kDebugMode) {
                          print(pickedDate);
                        } //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =

                        DateFormat('yyyy-MM-dd').format(pickedDate);
                        if (kDebugMode) {
                          print(formattedDate);
                        } //formatted date output using intl package =>  2021-03-16
//you can implement different kind of Date Format here according to your requirement
                        setState(() {
                          _dateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        if (kDebugMode) {
                          print("Date is not selected");
                        }
                      }
                    },
                  ),
                )),
          ),
        ));
  }
}