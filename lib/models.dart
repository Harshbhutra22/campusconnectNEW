class Event {
  // final _nameController = TextEditingController();
  // final _descController = TextEditingController();
  // final _dateController = TextEditingController();
  // final _timeController = TextEditingController();
  // final _venueController = TextEditingController();
  // final _organiserNameController = TextEditingController();
  // final _formLinkController = TextEditingController();
  // final _feedbackController = TextEditingController();
  // final _drivelinkController = TextEditingController();

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
