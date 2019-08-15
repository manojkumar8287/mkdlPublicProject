// Model for updates views.
class UpdateModel {
  String key;
  List<String> content;
  DateTime day;
  String image;
  bool isReviewed;

  UpdateModel(this.key, this.content, this.day, this.image, this.isReviewed);

  String getKey() {
    return this.key;
  }

  List<String> getContent() {
    return this.content;
  }

  DateTime getDay() {
    return this.day;
  }

  String getImage() {
    return this.image;
  }

  bool getIsReviewed() {
    return this.isReviewed;
  }
}
