class Note{
  String title;
  String date;
  String content;
  
  Note(this.title , this.date, this.content);
}

List<Note> notesData = [
  Note("Title 1", "1 May, 9:00", "some content"),
  Note("Title 2", "3 May, 8:30", "Some content that are notes made by the user to be read later by him which is his notes. Just writing to check overflow. Is the overflow working or not"),
  Note("Do something", "19 May, 1:20", "You have to do something."),
  Note("Title 2", "3 May, 8:30", "Some content that are notes made by the user to be read later by him which is his notes. Just writing to check overflow. Is the overflow working or not"),
];

List<Note> importantNotesData = [
  Note("Title 1", "1 May, 9:00", "some content"),
];

class User{
  String name;

  User(this.name);

}

List<User> usersData= [
  User("Padme Amadala"),
  User("Aniken Skywalker"),
  User("Han Solo"),
  User("Mace Windu"),
  User("Yoda")
];