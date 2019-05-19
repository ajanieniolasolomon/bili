

class AddPost{

  final String postId;
  final String post;
  final String tweetBy;
  String retweetBy = '';
 String tweetImage='';
  int likeCount=0;
  int retweetCount=0;
  String postOn;
String retweetMessage='';


  AddPost(this.postId,this.post,this.tweetBy,this.retweetBy,this.tweetImage,this.likeCount,this.retweetCount,this.postOn,this.retweetMessage);



}