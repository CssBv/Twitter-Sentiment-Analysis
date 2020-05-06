import 'dart:convert';
 
Future main() async {
  final String body = '''
 [{
    "created_at": "Fri Feb 07 16:47:55 +0000 2020",
    "id": 1225823517771354113,
    "id_str": "1225823517771354113",
    "full_text": "It's happening! https://t.co/EHTWnflNaE",
    "truncated": false,
    "display_text_range": [0, 15],
    "entities": {
        "hashtags": [],
        "symbols": [],
        "user_mentions": [],
        "urls": [],
        "media": [{
            "id": 1225823515950997504,
            "id_str": "1225823515950997504",
            "indices": [16, 39],
            "media_url": "http:\/\/pbs.twimg.com\/media\/EQL__jmUYAAB7uw.jpg",
            "media_url_https": "https:\/\/pbs.twimg.com\/media\/EQL__jmUYAAB7uw.jpg",
            "url": "https:\/\/t.co\/EHTWnflNaE",
            "display_url": "pic.twitter.com\/EHTWnflNaE",
            "expanded_url": "https:\/\/twitter.com\/LewisOfTime\/status\/1225823517771354113\/photo\/1",
            "type": "photo",
            "sizes": {
                "thumb": {
                    "w": 150,
                    "h": 150,
                    "resize": "crop"
                },
                "large": {
                    "w": 1280,
                    "h": 720,
                    "resize": "fit"
                },
                "small": {
                    "w": 680,
                    "h": 383,
                    "resize": "fit"
                },
                "medium": {
                    "w": 1200,
                    "h": 675,
                    "resize": "fit"
                }
            }
        }]
    },
    "extended_entities": {
        "media": [{
            "id": 1225823515950997504,
            "id_str": "1225823515950997504",
            "indices": [16, 39],
            "media_url": "http:\/\/pbs.twimg.com\/media\/EQL__jmUYAAB7uw.jpg",
            "media_url_https": "https:\/\/pbs.twimg.com\/media\/EQL__jmUYAAB7uw.jpg",
            "url": "https:\/\/t.co\/EHTWnflNaE",
            "display_url": "pic.twitter.com\/EHTWnflNaE",
            "expanded_url": "https:\/\/twitter.com\/LewisOfTime\/status\/1225823517771354113\/photo\/1",
            "type": "photo",
            "sizes": {
                "thumb": {
                    "w": 150,
                    "h": 150,
                    "resize": "crop"
                },
                "large": {
                    "w": 1280,
                    "h": 720,
                    "resize": "fit"
                },
                "small": {
                    "w": 680,
                    "h": 383,
                    "resize": "fit"
                },
                "medium": {
                    "w": 1200,
                    "h": 675,
                    "resize": "fit"
                }
            }
        }]
    },
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
        "id": 2930993051,
        "id_str": "2930993051"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 5,
    "favorited": false,
    "retweeted": false,
    "possibly_sensitive": false,
    "lang": "en"
}, {
    "created_at": "Wed Jan 22 10:09:20 +0000 2020",
    "id": 1219925001970880512,
    "id_str": "1219925001970880512",
    "full_text": "Coordinating with everyone on my desk at work to have them refreshing Ticketmaster for me on Friday morning",
    "truncated": false,
    "display_text_range": [0, 107],
    "entities": {
        "hashtags": [],
        "symbols": [],
        "user_mentions": [],
        "urls": []
    },
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
        "id": 2930993051,
        "id_str": "2930993051"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 2,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
}]
  ''';
 
 var tweets = json.decode(body);
 //print(tweets);
 
 var Texto = new Tweet(tweets[0]);
 
 print(Texto.createdAt);
 print(Texto.id);
 print(Texto.idStr);
 print(Texto.fullText);  
}
 
class Tweet
{
 String createdAt;
 int id;
 String idStr;
 String fullText;
 
 Tweet(Map<String, dynamic> parsed_json){
   this.createdAt = parsed_json["created_at"];
   this.id = parsed_json["id"];
   this.idStr = parsed_json["id_str"];
   this.fullText = parsed_json["full_text"];
 }
}