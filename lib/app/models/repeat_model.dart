// ignore_for_file: constant_identifier_names

enum Repeat { NOT_REPEAT, EVERY_DAY, SAME_DAY_EVERY_WEEK, SAME_DAY_EVERY_MONTH }

class RepeatTimeslot {
  String repeatText;
  Repeat repeat;
  RepeatTimeslot({
    required this.repeatText,
    required this.repeat,
  });
}
