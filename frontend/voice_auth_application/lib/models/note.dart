class Note {
  final String? id;
  final String title;
  final String body;
  final bool important; 
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Note({
    required this.id,
    required this.title,
    required this.body,
    this.important = false,
    this.createdAt,
    this.updatedAt,
});
  factory Note.fromJson(Map<String, dynamic> json) {
    DateTime? createdAt;
    DateTime? updatedAt;
    if (json['createdAt'] != null){
      createdAt = DateTime.parse(json['createdAt']);
      updatedAt = DateTime.parse(json['updatedAt']);
    } else {
      createdAt = null; updatedAt = null;
    }
    return Note(
      id: json['_id'],
      title: json['title'],
      body: json['body'],
      important: json['important'],
      createdAt: createdAt,
      updatedAt: updatedAt
    ); 
  }
}