// Model for service category details.
class CategoryModel {
  String key;
  String service;
  String name;
  String link;
  DateTime updated;
  bool isReviewed;
  String contact;
  String detail;
  String summary;
  List<String> detailLink;
  int views;
  String hotline;
  List<String> contactList;

  CategoryModel(this.key, this.service, this.name, this.link);

  int getViews() {
    return this.views;
  }

  void setViews(int views) {
    this.views = views;
  }

  List<String> getDetailLink() {
    return this.detailLink;
  }

  void setDetailLink(List<String> detailLink) {
    this.detailLink = detailLink;
  }

  String getService() {
    return this.service;
  }

  String getKey() {
    return this.key;
  }

  String getLink() {
    return this.link;
  }

  String getName() {
    return this.name;
  }

  DateTime getUpdated() {
    return this.updated;
  }

  void setUpdated(DateTime updated) {
    this.updated = updated;
  }

  bool getReviewed() {
    return this.isReviewed;
  }

  void setReviewed(bool isReviewed) {
    this.isReviewed = isReviewed;
  }

  String getSummary() {
    return this.summary;
  }

  void setSummary(String summary) {
    this.summary = summary;
  }

  String getContact() {
    return this.contact;
  }

  void setContact(String contact) {
    this.contact = contact;
  }

  String getDetail() {
    return this.detail;
  }

  void setDetail(String detail) {
    this.detail = detail;
  }

  String getHotline() {
    return this.hotline;
  }

  void setHotline(String hotline) {
    this.hotline = hotline;
  }

  List<String> getContactList() {
    return this.contactList;
  }

  void setContactList(List<String> contactList) {
    this.contactList = contactList;
  }
}
