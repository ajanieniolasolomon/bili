import 'package:http/http.dart' show Client, Response;
import 'dart:convert';
import 'dart:async';
import '../model/item.dart';

class NewApiProvider{
 final Client client = Client();

 final String _url= 'https://hacker-news.firebaseio.com/v0';

 Future<List<int>> fetchTopIds() async{

 final response =  await client.get('$_url/topstories.json');
 final ids = json.decode(response.body);

 return ids.cast<int>();

  }

 Future<itemModel> fetchItems(int id) async{

 final response =  await  client.get('$_url/item/$id.json');

 final parsedJson = json.decode(response.body);

 return itemModel.fromJson(parsedJson);

  }
}