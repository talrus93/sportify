import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(PickCityPage());
}

class PickCityPage extends StatelessWidget {
  const PickCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('Pick City'),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Select the  City'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child: Column(
              children: [
                //adding CSC Picket widget in app
                CSCPicker(
                  //enable disable state dropdown [OPTIONAL PARAMETER]
                  showStates: true,
                  //enable disable city dropdown [OPTIONAL PARAMETER]
                  showCities: true,

                  ///Enable (get flat with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                  flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                  ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey.shade300,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  ///selected item style [OPTIONAL PARAMETER]
                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                  dropdownHeadingStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  ///DropdownDialog Item style [OPTIONAL PARAMETER]
                  dropdownItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///Dialog box radius [OPTIONAL PARAMETER]
                  dropdownDialogRadius: 10.0,

                  ///Search bar radius [OPTIONAL PARAMETER]
                  searchBarRadius: 10.0,

                  ///triggers once country selected in dropdown
                  onCountryChanged: (value) {
                    setState(() {
                      ///store value in country variable
                      countryValue = value;
                    });
                  },

                  ///triggers once state selected in dropdown
                  onStateChanged: (value) {
                    setState(() {
                      ///store value in state variable
                      stateValue = value;
                    });
                  },

                  ///triggers once city selected in dropdown
                  onCityChanged: (value) {
                    setState(() {
                      ///store value in city variable
                      cityValue = value;
                    });
                  },
                ),

                ///print newly selected country state and city in Text Widget
                TextButton(
                    onPressed: () {
                      setState(() {
                        address = "$cityValue, $stateValue, $countryValue";
                      });
                    },
                    child: Text("Print Data")),
                Text(address)
              ],
            )),
      ),
    );
  }
}
