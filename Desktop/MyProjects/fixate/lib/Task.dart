class Task { 
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final String frequency; //eg every monday, every tuesday...
  Task(this.title, this.startDate, this.endDate, this.startTime, this.endTime, this.frequency);
}
