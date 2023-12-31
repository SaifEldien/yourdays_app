import '../const/vars.dart';
import 'highlight.dart';
import 'mood.dart';

class Day {
  Mood ?mood;
  String ?name;
  String ?date;
  String ?details;
  String ? lastUpdateDate;
  String ? status;
  List<Highlight>? highlights;
  String ? userEmail;
  Day(this.mood,this.name ,this.date, this.details, this.userEmail, this.highlights, this.lastUpdateDate , this.status);


  Day.fromJson(Map<String, dynamic> day,List<Highlight> this.highlights) {
    mood = moods[day["mood"]];
    date = day["date"];
    details = day["details"];
    userEmail = day["userEmail"];
    name = day["name"];
    status = day ["status"];
    lastUpdateDate = day["lastUpdateDate"];
  }

}