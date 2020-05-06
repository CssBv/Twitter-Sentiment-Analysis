class Tweet
{
  String createdAt;
  int id;
  String idStr;
  String fullText;
  
  Tweet(Map<String, dynamic> parsed_json)
  {
    this.createdAt = parsed_json["created_at"];
    this.id = parsed_json["id"];
    this.idStr = parsed_json["id_str"];
    this.fullText = parsed_json["full_text"];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Tweet { createdAt: $createdAt, id: $id, idStr: $idStr, fullText: $fullText }';
  }
}  

