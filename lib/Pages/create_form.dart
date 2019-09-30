import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parse/parse_models/FocoModel.dart';
import 'package:flutter_parse/repository/FocoRepository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';


class CreateForm extends StatefulWidget {
  CreateForm({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  FocoRepository repository = new FocoRepository();
  final foco = FocoModel();
  File _image;
  Position _currentPosition;

  Future<void> _neverSatisfied() async {
    return showCupertinoDialog<void>(
      context: context,      
      builder: (BuildContext context) {
        print("etca");
        return CupertinoAlertDialog(
          title: Text('Sucesso!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Os dados foram enviados ao servidor.'),
                Text('Retorne a página anterior e atualize a lista'),
              ],
            ),
          ),
          actions: <Widget>[
             CupertinoDialogAction(child: 
            CupertinoButton(
              child: Text('Entendi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ),
          ],
        );
      },
    );
  }
  
  void _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
  
  Future _getImage() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((img) {
      setState(() {
        _image = img;
      });
    });
  }  

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Container(
                      child: Text('$_currentPosition', textAlign: TextAlign.center,),
                    ),
                    Container(
                      height: 250.0,
                      padding: EdgeInsets.all(16.0),
                      child: _image == null
                          ? OutlineButton(
                              borderSide: BorderSide(color: Colors.red[200], width: 4),                                                            
                              onPressed:  () {
                                _getImage();
                              },
                              child: Center(
                                heightFactor: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.camera_alt),
                                    Text('Tire uma foto do foco')
                                  ],
                                ),
                              ),
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.scaleDown,
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                      child: FlatButton(
                        disabledColor: Colors.transparent,
                        color: Colors.pink[200],
                        textColor: Colors.white,
                        onPressed: _image == null ? null :() {                          
                          repository.add(_currentPosition.latitude.toString(), _currentPosition.longitude.toString(), _image).then((r) {
                            _neverSatisfied().then((re){
                              setState(() {
                                _image = null;
                              });
                            });                            
                          }).catchError((err) {
                            print(err);
                          });
                        },
                        child: Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
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
