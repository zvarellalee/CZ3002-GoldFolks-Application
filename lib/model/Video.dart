class Video {
  String _videoId;
  String _title;
  String _description;

  Video({
    String videoId,
    String title,
    String description,
  }) :  _videoId = videoId,
        _title = title,
        _description = description;

  String get videoId => _videoId;
  String get title => _title;
  String get description => _description;

  set videoId(String videoId) => _videoId = videoId;
  set title(String title) => _title = title;
  set description(String description) => _description = description;
}