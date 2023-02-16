import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:new_task/user.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const SecondScreen(),
        '/thired': (context) => const ThiredScreen(),
      },
    ),
  );
}

// var resps = [0,1,2,3];

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

var resps = [];
var respLength = resps.length;
Future<List> getDataFrom() async {
  return Future.delayed(Duration(milliseconds: 500), () async {
    // Get Data

    var uril = 'http://localhost:5000/university';

    var urll = Uri.parse(uril);
    http.Response responses = await http.get(
      urll,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        "accept": "application/json",
        "content-type": "application/json"
      },
    );

    return resps = json.decode(responses.body);
    // List<String> _products = [''];
    // _products.add(resps.toString());
    print(resps.runtimeType);
    print(resps.length);

    // var a =  resps.forEach((val) {
    //     var b= val['name'];
    //     print("b is $b");

    //   });
  });
}

class _FirstScreenState extends State<FirstScreen> {
  User user = User("");

  var name;
  final namecon = TextEditingController();
  // var resps=[];
  // var respLength = resps.length;
  var arr = [''];

  // var resps;
  void universityFun() async {
    setState(() {
      name = namecon.text;
      namecon.clear();
      arr.add(name);
      resps;
    });

    // Post Data

    var uri = 'http://localhost:5000/register';

    var url = Uri.parse(uri);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        "accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode(<String, String>{"name": name}),
    );

    var resp = json.decode(response.body);
  }

  void initState() {
    super.initState();
    getDataFrom();
  }
   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Portal"),

          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/first');
              },
              child: Container(
                color: Color.fromARGB(255, 182, 216, 183),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: const Text(
                  'University',
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Container(
                color: Color.fromARGB(255, 182, 216, 183),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: const Text(
                  'Course',
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/thired');
              },
              child: Container(
                color: Color.fromARGB(255, 182, 216, 183),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: const Text(
                  'Student',
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder(
              future: getDataFrom(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Text("$error");
                } else if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      // Column is also a layout widget. It takes a list of children and
                      // arranges them vertically. By default, it sizes itself to fit its
                      // children horizontally, and tries to be as tall as its parent.
                      //
                      // Invoke "debug painting" (press "p" in the console, choose the
                      // "Toggle Debug Paint" action from the Flutter Inspector in Android
                      // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                      // to see the wireframe for each widget.
                      //
                      // Column has various properties to control how it sizes itself and
                      // how it positions its children. Here we use mainAxisAlignment to
                      // center the children vertically; the main axis here is the vertical
                      // axis because Columns are vertical (the cross axis would be
                      // horizontal).
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              style: TextStyle(
                                fontSize: 40,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Color.fromARGB(255, 31, 32, 31)!,
                              ),
                              'University ',
                            ),
                          ],
                        ),
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Container(
                              width: 500,
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  controller: namecon,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    hintText: 'Enter university',
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // ignore: avoid_print
                                universityFun();
                               if (formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
                              },
                              child: Container(
                                color: Color.fromARGB(255, 182, 216, 183),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Universities",
                              style: TextStyle(
                                height: 2,
                                fontSize: 40,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.blue[700]!,
                              ),
                            ),
                            Container(
                              width: 400,
                              height: 200,
                              child: ListView(
                                padding: const EdgeInsets.all(8),
                                children: List.generate(
                                  resps.length,
                                  (index) => ListTile(
                                    // title: Text('Item $index,${resps[index]}'),
                                    title: Text(' ${resps[index]["name"]}'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

// Second Screen

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

var respscour = [];
Future<List> getDataFromCourses() async {
  return Future.delayed(Duration(milliseconds: 500), () async {
    // Get Data for university

    //   var uril = 'http://localhost:5000/university';

    //   var urll = Uri.parse(uril);
    //   http.Response responses = await http.get(
    //     urll,
    //     headers: <String, String>{
    //       'Access-Control-Allow-Origin': '*',
    //       'Access-Control-Allow-Credentials': 'true',
    //       'Access-Control-Allow-Headers': '*',
    //       'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    //       "accept": "application/json",
    //       "content-type": "application/json"
    //     },
    //   );

    // return  resps = json.decode(responses.body);
    //   // List<String> _products = [''];
    //   // _products.add(resps.toString());
    //   print(resps.runtimeType);
    //   print(resps.length);
    //   // items.add(resps);
    //   // items.add(b.toString());

    //   // var a =  resps.forEach((val) {
    //   //   b= val['name'];
    //   //     print("b is $b");

    //   //   });

    //   //   print("List is $List");

    // Get Data for Courses

    var urilcour = 'http://localhost:5000/courses';

    var urllcour = Uri.parse(urilcour);
    http.Response responsescour = await http.get(
      urllcour,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        "accept": "application/json",
        "content-type": "application/json"
      },
    );
    // print(json.decode(responsescour.body)[0]['us']['name'].toString().runtimeType);
    return respscour = json.decode(responsescour.body);
    // List<String> _products = [''];
    // _products.add(resps.toString());
    print(respscour.runtimeType);
    print(respscour.length);

    // var a =  resps.forEach((val) {
    //     var b= val['name'];
    //     print("b is $b");

    //   });
  });
}

class _SecondScreenState extends State<SecondScreen> {
  var b;
  var select;
  final List<String> items = [];

  String? selectedValue;
  var courses;

  final coursescon = TextEditingController();

  void abcFun() async {
    setState(() {
      courses = coursescon.text;
      coursescon.clear();
      // print(courses.toString());
      // print(courses.toString());
    });

    var payload = {"name": courses, "us": select};

    print(payload);

// courses post
    var uri = 'http://localhost:5000/courses';

    var url = Uri.parse(uri);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        "accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode(payload),
    );

    var resp = json.decode(response.body);
    print("resp $resp");
    // items.add(resp);
  }

  void initState() {
    super.initState();
    getDataFromCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Portal"),

        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Container(
              color: Color.fromARGB(255, 182, 216, 183),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'University ',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            child: Container(
              color: Color.fromARGB(255, 182, 216, 183),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'Course',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/thired');
            },
            child: Container(
              color: Color.fromARGB(255, 182, 216, 183),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'Student',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
        ],
      ),
      //

      body: Center(
        child: FutureBuilder(
            future: getDataFromCourses(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text("$error");
              } else if (snapshot.hasData) {
                return Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
                    // Column is also a layout widget. It takes a list of children and
                    // arranges them vertically. By default, it sizes itself to fit its
                    // children horizontally, and tries to be as tall as its parent.
                    //
                    // Invoke "debug painting" (press "p" in the console, choose the
                    // "Toggle Debug Paint" action from the Flutter Inspector in Android
                    // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                    // to see the wireframe for each widget.
                    //
                    // Column has various properties to control how it sizes itself and
                    // how it positions its children. Here we use mainAxisAlignment to
                    // center the children vertically; the main axis here is the vertical
                    // axis because Columns are vertical (the cross axis would be
                    // horizontal).
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            style: TextStyle(
                              fontSize: 40,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Color.fromARGB(255, 31, 32, 31)!,
                            ),
                            'Courses ',
                          ),
                        ],
                      ),
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          DropdownButtonHideUnderline(
                            child: Column(
                              children: [
                                Container(
                                  //You can use EdgeInsets like above
                                  margin: EdgeInsets.all(5),
                                  width: 500,

                                  child: DropdownButton(
                                    hint: Text(
                                      'Select University',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: resps
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item["_id"],
                                              child: Text(
                                                item["name"],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                        select = selectedValue;

                                        print("selectedValue is $select");
                                      });
                                    },
                                    value: selectedValue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 500,
                            child: TextField(
                              controller: coursescon,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                hintText: 'Enter Courses',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => {
                              // ignore: avoid_print
                              abcFun()
                            },
                            child: Container(
                              margin: EdgeInsets.all(3),
                              color: Color.fromARGB(255, 182, 216, 183),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: const Text(
                                'Submit Courses',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Text(
                      //           "Universitys",
                      //           style: TextStyle(
                      //             height: 2,
                      //             fontSize: 40,
                      //             foreground: Paint()
                      //               ..style = PaintingStyle.stroke
                      //               ..strokeWidth = 2
                      //               ..color = Colors.blue[700]!,
                      //           ),
                      //         ),
                      //         Container(
                      //           width: 200,
                      //           height: 200,
                      //           child: ListView(
                      //             padding: const EdgeInsets.all(8),
                      //             children: List.generate(
                      //               respscour.length,
                      //               (index) => ListTile(
                      //                 // title: Text('Item $index,${resps[index]}'),
                      //                 title: Text(' ${respscour[index]["us"]} '),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           "Courses",
                      //           style: TextStyle(
                      //             height: 2,
                      //             fontSize: 40,
                      //             foreground: Paint()
                      //               ..style = PaintingStyle.stroke
                      //               ..strokeWidth = 2
                      //               ..color = Colors.blue[700]!,
                      //           ),
                      //         ),
                      //         Container(
                      //           width: 200,
                      //           height: 200,
                      //           child: ListView(
                      //             padding: const EdgeInsets.all(8),
                      //             children: List.generate(
                      //               respscour.length,
                      //               (index) => ListTile(
                      //                 // title: Text('Item $index,${resps[index]}'),
                      //                 title: Text(' ${respscour[index]["name"]} '),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),

                      //   ],
                      // )
                      Container(
                        //You can use EdgeInsets like above
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              width: 700,
                              height: 400,
                              child: ListView(
                                children: [_createDataTable()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      //  second
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Text(
        'University',
        style: TextStyle(
          height: 2,
          fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.blue[700]!,
        ),
      )),
      DataColumn(
          label: Text(
        'Courses',
        style: TextStyle(
          height: 2,
          fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.blue[700]!,
        ),
      )),
    ];
  }

  List<DataRow> _createRows() {
    return respscour
        .map((book) => DataRow(cells: [
              DataCell(Text(book['us']['name'])),
              DataCell(Text(book['name']))
            ]))
        .toList();
  }
}

// Thired Screen

class ThiredScreen extends StatefulWidget {
  const ThiredScreen({super.key});

  @override
  State<ThiredScreen> createState() => _ThiredScreenState();
}

var respsstud = [];
var respsuniversity = [];

Future<List> getDataFromStudent() async {
  return Future.delayed(Duration(milliseconds: 500), () async {
    //Get Data for Courses

    var urilcour = 'http://localhost:5000/courses';

    var urllcour = Uri.parse(urilcour);
    http.Response responsescour = await http.get(
      urllcour,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        "accept": "application/json",
        "content-type": "application/json"
      },
    );

    respscour = json.decode(responsescour.body);
    // List<String> _products = [''];
    // _products.add(resps.toString());
    print(respscour.runtimeType);
    print(respscour.length);
    print("nnn$respscour");
    // var a =  resps.forEach((val) {
    //     var b= val['name'];
    //     print("b is $b");

    //   });

    // // Get Data for student

    var urilstud = 'http://localhost:5000/student';

    var urllstud = Uri.parse(urilstud);
    http.Response responsesstud = await http.get(
      urllstud,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        "accept": "application/json",
        "content-type": "application/json"
      },
    );

    return respsstud = json.decode(responsesstud.body);
    // List<String> _products = [''];
    // _products.add(resps.toString());
    // print(respsstud.runtimeType);
    // print(respsstud.length);

    // var a =  resps.forEach((val) {
    //     var b= val['name'];
    //     print("b is $b");

    //   });
// get university

    // var uril = 'http://localhost:5000/university';

    // var urll = Uri.parse(uril);
    // http.Response responses = await http.get(
    //   urll,
    //   headers: <String, String>{
    //     'Access-Control-Allow-Origin': '*',
    //     'Access-Control-Allow-Credentials': 'true',
    //     'Access-Control-Allow-Headers': '*',
    //     'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    //     "accept": "application/json",
    //     "content-type": "application/json"
    //   },
    // );
    // respsuniversity = json.decode(responses.body);
    // return respsuniversity;
    // // List<String> _products = [''];
    // // _products.add(resps.toString());
    // print("respsuniversity $respsuniversity");
    // print(respsuniversity.runtimeType);
    // print(respsuniversity.length);

    // var a =  resps.forEach((val) {
    //     var b= val['name'];
    //     print("b is $b");

    //   });
  });
}

class _ThiredScreenState extends State<ThiredScreen> {
  final List<String> items = [];
  final List<String> itemsuni = [];
  String? selectedValue;
  String? selectedValueuni;

  var selectcourse;
  var student;
  var selectuniversity;

  final studentcon = new TextEditingController();
  void studen() async {
    setState(() {
      student = studentcon.text;
      studentcon.clear();
      print(student);
    });
    print("again $respscour");

    var payloadCourses = {
      "name": student,
      "courses": selectcourse,
      "us": selectuniversity
    };
    print("selectuniversity $payloadCourses");

    var uri = 'http://localhost:5000/student';

    var url = Uri.parse(uri);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        "accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode(payloadCourses),
    );

    var resp = json.decode(response.body);
    print("student $resp");
  }

  void initState() {
    super.initState();
    respscour;
    resps;
    print("respscour");
    getDataFromStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Portal"),

        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Container(
              color: Color.fromARGB(255, 182, 216, 183),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'University',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            child: Container(
              color: Color.fromARGB(255, 182, 216, 183),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'Course',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/thired');
            },
            child: Container(
              color: Color.fromARGB(255, 182, 216, 183),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'Student',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
        ],
      ),

      //

      body: Center(
        child: FutureBuilder(
            future: getDataFromStudent(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text("$error");
              } else if (snapshot.hasData) {
                return Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
                    // Column is also a layout widget. It takes a list of children and
                    // arranges them vertically. By default, it sizes itself to fit its
                    // children horizontally, and tries to be as tall as its parent.
                    //
                    // Invoke "debug painting" (press "p" in the console, choose the
                    // "Toggle Debug Paint" action from the Flutter Inspector in Android
                    // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                    // to see the wireframe for each widget.
                    //
                    // Column has various properties to control how it sizes itself and
                    // how it positions its children. Here we use mainAxisAlignment to
                    // center the children vertically; the main axis here is the vertical
                    // axis because Columns are vertical (the cross axis would be
                    // horizontal).
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            style: TextStyle(
                              fontSize: 40,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Color.fromARGB(255, 31, 32, 31)!,
                            ),
                            'Student',
                          ),
                        ],
                      ),
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // TextField(
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          //     hintText: 'University',
                          //   ),
                          // ),
                          Column(
                            children: [
                              DropdownButtonHideUnderline(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 500,
                                      margin: EdgeInsets.all(5),
                                      child: DropdownButton(
                                        hint: Text(
                                          'Select University',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: resps
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item["_id"],
                                                  child: Text(
                                                    item["name"],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedValueuni,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValueuni = value;
                                            selectuniversity = selectedValueuni;
                                            print(
                                                "selectuniversity  is $selectuniversity");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              DropdownButtonHideUnderline(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 500,
                                      margin: EdgeInsets.all(5),
                                      child: DropdownButton(
                                        hint: Text(
                                          'Select Course',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: respscour
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item["_id"],
                                                  child: Text(
                                                    item["name"],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value;
                                            selectcourse = selectedValue;
                                            print(
                                                "selectcourse  is $selectcourse");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 500,
                            child: TextField(
                              controller: studentcon,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintText: 'Enter Student Name',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => {
                              // ignore: avoid_print
                              studen()
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              color: Color.fromARGB(255, 182, 216, 183),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 13),
                              child: const Text(
                                'Submint Student',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Text(
                      //           "Courses",
                      //           style: TextStyle(
                      //             height: 2,
                      //             fontSize: 40,
                      //             foreground: Paint()
                      //               ..style = PaintingStyle.stroke
                      //               ..strokeWidth = 2
                      //               ..color = Colors.blue[700]!,
                      //           ),
                      //         ),
                      //         Container(
                      //           width: 200,
                      //           height: 200,
                      //           child: ListView(
                      //             padding: const EdgeInsets.all(8),
                      //             children: List.generate(
                      //               respscour.length,
                      //               (index) => ListTile(
                      //                 // title: Text('Item $index,${resps[index]}'),
                      //                 title: Text(' ${respscour[index]["name"]} '),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           "Students",
                      //           style: TextStyle(
                      //             height: 2,
                      //             fontSize: 40,
                      //             foreground: Paint()
                      //               ..style = PaintingStyle.stroke
                      //               ..strokeWidth = 2
                      //               ..color = Colors.blue[700]!,
                      //           ),
                      //         ),
                      //         Container(
                      //           width: 200,
                      //           height: 200,
                      //           child: ListView(
                      //             padding: const EdgeInsets.all(8),
                      //             children: List.generate(
                      //               respsstud.length,
                      //               (index) => ListTile(
                      //                 // title: Text('Item $index,${resps[index]}'),
                      //                 title: Text(' ${respsstud[index]["name"]} '),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // )

                      Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              width: 700,
                              height: 300,
                              child: ListView(
                                children: [_createDataTable()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),

      // thir
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      // DataColumn(
      //     label: Text(
      //   'University',
      //   style: TextStyle(
      //     height: 2,
      //     fontSize: 30,
      //     foreground: Paint()
      //       ..style = PaintingStyle.stroke
      //       ..strokeWidth = 2
      //       ..color = Colors.blue[700]!,
      //   ),
      // )),
      DataColumn(
          label: Text(
        'University',
        style: TextStyle(
          height: 2,
          fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.blue[700]!,
        ),
      )),
      DataColumn(
          label: Text(
        'Courses',
        style: TextStyle(
          height: 2,
          fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.blue[700]!,
        ),
      )),
      DataColumn(
          label: Text(
        'Student',
        style: TextStyle(
          height: 2,
          fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.blue[700]!,
        ),
      )),
    ];
  }

  List<DataRow> _createRows() {
    print("res stu$respsstud");
    return respsstud
        .map((book) => DataRow(cells: [
              // DataCell(Text(book['us'].toString())),
              DataCell(Text(book['us']["name"])),
              DataCell(Text(book['courses']["name"])),
              DataCell(Text(book['name']))
            ]))
        .toList();
  }
}
