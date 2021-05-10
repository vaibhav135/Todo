class TaskFields {
  TaskFields(
      {this.taskName,
      this.taskDate,
      this.aboutTask,
      this.priority,
      this.taskCategories});
  final String taskName, aboutTask, taskCategories;
  final int priority;
  final DateTime taskDate;
}
