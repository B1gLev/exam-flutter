class Helper {
  static const String apiURL = "localhost:3000";

  static String formatDuration(int duration) {
    switch (duration) {
      case 1:
        return "24 órás bérlet";
      case 7:
        return "Heti bérlet (7 napos)";
      case 30:
        return "Havi bérlet (30 napos)";
      default:
        return "$duration napos bérlet";
    }
  }

  static String _extractHungarianInitial(String word) {
    var specialCases = ["Gy", "Sz", "Cs", "Ny", "Ty", "Dz", "Zs"];
    String firstTwoLetters = word.substring(0, 2);
    return specialCases.contains(firstTwoLetters) ? firstTwoLetters : word[0];
  }

  static String getInitials(String? lastName, String? firstName) {
    if (firstName == null || lastName == null) return "Hiba";
    return _extractHungarianInitial(lastName).toUpperCase() + _extractHungarianInitial(firstName).toUpperCase();
  }
}