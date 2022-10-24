import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: LocaleText("language"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("English"),
            onTap: () => LocaleNotifier.of(context)?.change('en'),
          ),
          ListTile(
            title: Text("Spanish"),
            onTap: () => LocaleNotifier.of(context)?.change('es'),
          ),
        ],
      ),
    );
  }
}