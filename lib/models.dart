class Event {
  Event({
    required this.name,
    required this.desc,
    required this.date,
    required this.driveLink,
    required this.feedback,
    required this.formLink,
    required this.organisation,
    required this.time,
    required this.venue,
    required this.imgName,
  });
  String name,
      desc,
      date,
      time,
      venue,
      organisation,
      formLink,
      feedback,
      imgName;

  String? driveLink;
}

class CCUser {
  CCUser(
      {required this.role,
      required this.name,
      required this.email,
      required this.uID});
  String name, role, email;
  int uID;
}
