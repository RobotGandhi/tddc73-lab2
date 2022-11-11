import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> months = <String>[
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12"
];

void main() {
  runApp(const MyApp());
}

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  CreditCardFormState createState() {
    return CreditCardFormState();
  }
}

class CreditCardFormState extends State<CreditCardForm> {
  final _formkey = GlobalKey<FormState>();
  String dropdownValue = months.first;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/14.jpeg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.symmetric(vertical: 30),
              width: 310,
              height: 200,
              child: Column(
                children: const <Widget>[
                  Text("tja"),
                ],
              ),
            ),
            Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  child: Text('Card Number',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              height: 100,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberFormatter(),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                validator: (value) {
                  if (value?.length == 19) {
                    return null;
                  }
                  return 'Please enter a valid credit card number.';
                },
                maxLength: 19,
                onChanged: (value) {},
              ),
            ),
            Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  child: Text('Card Name',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              height: 100,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                ),
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Please enter a valid name.';
                  } else if (RegExp(r"^[\p{L} ,.'-]*$",
                          caseSensitive: false, unicode: true, dotAll: true)
                      .hasMatch(value)) {
                    return null;
                  }
                  return 'Please enter a valid name.';
                },
                maxLength: 100,
                onChanged: (value) {},
              ),
            ),
            Row(
              children: const <Widget>[
                SizedBox(width: 10),
                Text("Expiration Date",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(width: 172),
                Text("CVV",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Expanded(
                    child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  items: months.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: SizedBox(
                        width: 68,
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }).toList(),
                  value: dropdownValue,
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                )),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownDatePicker(
                    inputDecoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    isDropdownHideUnderline: true,
                    isFormValidator: true,
                    width: 10,
                    startYear: 2022,
                    endYear: 2100,
                    selectedMonth: 11,
                    selectedYear: 2022,
                    onChangedDay: (value) {},
                    onChangedMonth: (value) {},
                    onChangedYear: (value) {},
                    showDay: false,
                    showMonth: false,
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 22.5, horizontal: 10),
                      counterText: "",
                    ),
                    validator: (value) {
                      if (value!.length > 3) {
                        return null;
                      } else {
                        return "Please enter a valid CVV.";
                      }
                    },
                    maxLength: 4,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Thanks for your money")),
                    );
                  }
                },
                child: const Text('Submit'))
          ],
        ));
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: const <Widget>[
            SizedBox(height: 50),
            CreditCardForm(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
