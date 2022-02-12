import 'package:flutter/material.dart';
import 'package:santa/company_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String companyNameKey = "COMPANY_NAME";

void main() {
  _prepareAndRun();
}

Future<void> _prepareAndRun() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  final companyName = _prefs.getString(companyNameKey);

  runApp(MyApp(companyName: companyName));
}

class MyApp extends StatelessWidget {
  final String? companyName;
  const MyApp({Key? key, this.companyName}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        CompanyPage.routeName: (BuildContext context) => const CompanyPage(),
        MyHomePage.routeName: (BuildContext context) => const MyHomePage(title: 'Flutter Demo Home Page')
      },
      initialRoute: companyName == null ? MyHomePage.routeName : CompanyPage.routeName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = "/home";
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  final TextEditingController _controller = TextEditingController();

  Future<void> _goNext() async {
    Navigator.of(context).pushNamed(CompanyPage.routeName);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(companyNameKey, _controller.text);
  }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print("FFF: ${_controller.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Введите название компании',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                autofocus: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goNext,
        tooltip: 'Increment',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
