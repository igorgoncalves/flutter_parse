import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_parse/Pages/create_form.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'Pages/home.dart';

Future main() async {
  await DotEnv().load('.env'); 
  await Parse().initialize('SX2ylA47RTX5L9fow22kAoJ052WDJ10rkTEwA74H',
        'https://hacktour.back4app.io',
        clientKey: 'V6v5nbx5wTJWiVGCYTDClPh2ckhvQOJozsezo25c'); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  CupertinoTabController controller = CupertinoTabController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {    
    return CupertinoApp(
      title: 'App test integração',
      home: CupertinoTabScaffold(
        controller: controller,
        resizeToAvoidBottomInset: true,        
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Place bid', ),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {          
          assert(index >= 0 && index <= 3);
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                    child: MyHomePage(title: 'Listagem de Focos'));
              });
              break;
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: CreateForm(title: 'Adicionar Foco'),
                  );
                },
              );
              break;
          }
          return null;
        },
      )
    );
  }
  @override
  void dispose() {
    controller.dispose();    
  }
}
