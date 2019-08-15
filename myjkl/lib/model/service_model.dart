//Modelfor services list.
class ServiceModel {
  String key;
  String name;
  String notice;
  bool isReviewed;
  List<String> ads;
  String statement;
  bool isnews;
  String privacy;

  ServiceModel(this.key, this.name, this.notice, this.isReviewed, this.ads,
      this.statement, this.isnews, this.privacy);

  bool getIsNews() {
    return this.isnews;
  }

  String getPrivacy() {
    return this.privacy;
  }

  String getStatement() {
    return this.statement;
  }

  String getNotice() {
    return this.notice;
  }

  String getKey() {
    return this.key;
  }

  String getName() {
    return this.name;
  }

  bool getReviewed() {
    return this.isReviewed;
  }

  List<String> getAds() {
    return this.ads;
  }
}
