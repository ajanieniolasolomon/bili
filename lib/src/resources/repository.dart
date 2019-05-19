import '../model/item.dart';

import 'newsapi.dart';
import 'newsapidb.dart';

class Repository{
  NewApiProvider _apiP = NewApiProvider();
  NewsApiDb _dbP = NewsApiDb();


 Future<List<int>> fetchTopIds(){

    return _apiP.fetchTopIds();

  }
 Future<itemModel> fetchItem(int id) async{
var item = await _dbP.fetchItems(id);

if(item!=null){
  return item;
}

item = await _apiP.fetchItems(id);

 _dbP.addItem(item);

return item;

  }
}