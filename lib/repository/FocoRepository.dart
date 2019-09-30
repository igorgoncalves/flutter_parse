import 'dart:io';

import 'package:flutter_parse/parse_models/FocoModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class FocoRepository {
  Future add(String lat, String lng, [File imagem]) async {
    var parseFile = ParseFile(imagem);
    
    var item = FocoModel();
    item.set('lat', lat);
    item.set('lng', lng);
    item.set('imagem', parseFile);

    return await item.save();
  }

  Future getAll() async {
    return await FocoModel().getAll().then((response) {
      return response.results;
    }).catchError((e){
      print(e);
    });
  }

  Future getById(String id) async {
    return await FocoModel().getObject(id);
  }
}
