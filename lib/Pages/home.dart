import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_parse/Pages/create_form.dart';
import 'package:flutter_parse/repository/FocoRepository.dart';
import '../Foco.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Foco> pontosDeFoco = new List<Foco>();
  FocoRepository repository = FocoRepository();

  void navigateToCreateForm() {
    Navigator.push(
      context,
      CupertinoPageRoute<void>(builder: (BuildContext context) {
        return CreateForm(
          title: 'Adicionar Foco',
        );
      }),
    );
  }

  Widget _buildListFocos(List<Foco> pontosDeFoco) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => pontosDeFoco[index],
      itemCount: pontosDeFoco.length,
    );
  }

  void _fetchFocos() {
    print("fetch-1");
    repository.getAll().then((r) {
      print("fetch");
      pontosDeFoco = new List<Foco>();
      for (var item in r) {
        pontosDeFoco.add(item.serielizeToView());
      }
      setState(() {
        pontosDeFoco = List.from(pontosDeFoco);
      });
    }).catchError((onError) {
      print(onError);
    }).timeout(Duration(seconds: 5), onTimeout: () {
      // _fetchFocos();
    });
  }

  void _createFoco() {
    repository.add('-13.44566', '-32.55466').then((f) {
      _fetchFocos();
    });
  }

 

  @override
  void initState() {
    super.initState();     
      _fetchFocos(); 
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        CupertinoNavigationBar(
          middle: Text(widget.title, style: TextStyle(color: Colors.red[200], fontWeight: FontWeight.bold, fontSize: 21.0),),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              FlatButton(              
                  child: Text('Atualizar'),  
                  disabledColor: Colors.transparent,
                  color: Colors.pink[200],
                  textColor: Colors.white,                                    
                  onPressed: () {
                    _fetchFocos();
                  }),                  
              Expanded(
                child: _buildListFocos(pontosDeFoco),
              ),
              CupertinoNavigationBar(
                middle: CupertinoButton(
                  child: Text("Cam"),
                  onPressed: () {
                    navigateToCreateForm();
                  },
                ),
              )
            ],
          ),

          // floatingActionButton: FloatingActionButton(
          //   // onPressed: () => navigateToCreateForm(),
          //   onPressed: () => _fetchFocos(),
          //   child: Icon(Icons.add),
          // ),
        )
      ],
    );
  }
}
