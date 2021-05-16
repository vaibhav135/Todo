class TaskFields {
  TaskFields(
      {this.taskName,
      this.taskDate,
      this.aboutTask,
      this.priority,
      this.taskCategories,
      this.currentDateTime});
  final String taskName, aboutTask, taskCategories, currentDateTime;
  final int priority;
  final DateTime taskDate;
}
