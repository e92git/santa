import 'dart:math';

import 'package:flutter/material.dart';
import 'package:santa/company.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);
  static const routeName = "/company";

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {

  String? _companyName;
  final List<Company> _companies = [];
  final List<Color> _photos = [
    Colors.white,
    Colors.red,
    Colors.yellow,
    Colors.blueGrey,
    Colors.pinkAccent,
  ];

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  void _loadName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final companyName = _prefs.getString(companyNameKey);

    setState(() {
      _companyName = companyName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_companyName ?? ''),
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: _companies.length,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _itemBuilder(BuildContext context, int index){
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: _companies[index].color,
                shape: BoxShape.circle
            ),
          ),
          const SizedBox(width: 20),
          Text(_companies[index].name, style: const TextStyle(color: Colors.white),)
        ],
      ),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index){
    return const SizedBox(height: 10);
  }

  Future<void> _add() async {
    int photoKey = Random().nextInt(_photos.length);
    final company = Company(
      'id',
      'Name',
      _photos[photoKey],
    );
    setState(() {
      _companies.add(company);
    });
  }
}
