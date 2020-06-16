class DeveloperInfo {
  final String label, text, urlStr, backup;

  DeveloperInfo({this.label, this.text, this.urlStr, this.backup});
}

final developerInfos = [
  DeveloperInfo(
    label: 'Email',
    text: 'kyawgyi16.knp@gmail.com',
    urlStr: 'mailto:<kyawgyi16.knp@gmail.com>',
  ),
  DeveloperInfo(
    label: 'Facebook',
    text: 'facebook.com/ygnCybernoob',
    urlStr: 'fb://facewebmodal/f?href=https://www.facebook.com/ygnCybernoob',
    backup: 'https://www.facebook.com/ygnCybernoob',
  ),
  DeveloperInfo(
    label: 'Github',
    text: 'github.com/ygnCybernoob',
    urlStr: 'https://github.com/ygnCybernoob',
  ),
  DeveloperInfo(
    label: 'PlayStore',
    text: 'play.google.com/store/apps/dev?id=9177873746963075204',
    urlStr: 'http://play.google.com/store/apps/dev?id=9177873746963075204',
  ),
];
