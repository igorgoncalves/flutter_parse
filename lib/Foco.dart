import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class Foco extends StatelessWidget {
  final String lat;
  final String lng;
  final String imagem;

  const Foco({
    Key key,
    @required this.lat,
    @required this.lng,
    @required this.imagem,
  })  : assert(lat != null),
        assert(lng != null),
        assert(imagem != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(        
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(                
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  imagem,
                                    
                  fit: BoxFit.cover,
                ),
              ),
              Text('Coordenadas',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                'Latitude: $lat | Longitude: $lng',
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ));
  }
}
