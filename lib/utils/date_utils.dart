String formatDate(DateTime d) {
  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return "${months[d.month - 1]} ${d.day.toString().padLeft(2, '0')}, ${d.year}";
}
