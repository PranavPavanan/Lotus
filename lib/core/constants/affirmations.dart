/// Daily affirmations for the Mirror interaction
class Affirmations {
  Affirmations._();

  static const List<String> daily = [
    "You are capable of amazing things.",
    "Progress, not perfection.",
    "Small steps lead to big changes.",
    "You deserve rest and growth equally.",
    "Your effort today matters.",
    "It's okay to take things one task at a time.",
    "You are stronger than you think.",
    "Every small win counts.",
    "Be patient with yourself.",
    "You're doing better than you realize.",
    "This moment is enough.",
    "Your pace is valid.",
    "You bring value simply by being.",
    "Breathe. You've got this.",
    "Tomorrow is a fresh start.",
  ];

  /// Gets a random affirmation
  static String getRandom() {
    final index = DateTime.now().millisecondsSinceEpoch % daily.length;
    return daily[index];
  }
}
