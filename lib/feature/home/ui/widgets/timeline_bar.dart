import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineProgress extends StatelessWidget {
  final List<Phase> phases = [
    Phase('UI/UX', DateTime(2023, 1, 25)),
    Phase('Development', DateTime(2023, 1, 30)),
    Phase('Testing', DateTime(2023, 2, 12)),
    Phase('Publish', DateTime(2023, 3, 25)),
  ];

  TimelineProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startDate = phases.first.date;
    final endDate = phases.last.date;
    final totalDays = endDate.difference(startDate).inDays;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Timeline bar
          SizedBox(
            height: 60,
            child: Stack(
              children: [
                // Background line
                Positioned(
                  top: 25,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    color: Colors.grey[300],
                  ),
                ),

                // Phases
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: phases.map((phase) {
                    final daysFromStart = phase.date.difference(startDate).inDays;
                    final position = daysFromStart / totalDays;

                    return PhaseDot(
                      phase: phase,
                      position: position,
                      isCompleted: phase.date.isBefore(now),
                      isCurrent: phase.date.isAfter(now.subtract(const Duration(days: 1))) &&
                          phase.date.isBefore(now.add(const Duration(days: 1))),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Dates
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: phases.map((phase) {
                return Text(
                  DateFormat('d/M').format(phase.date),
                  style: TextStyle(
                    color: phase.date.isBefore(now)
                        ? Colors.green
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PhaseDot extends StatelessWidget {
  final Phase phase;
  final double position;
  final bool isCompleted;
  final bool isCurrent;

  const PhaseDot({
    super.key,
    required this.phase,
    required this.position,
    required this.isCompleted,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          // Phase name
          Text(
            phase.name,
            style: TextStyle(
              color: isCompleted
                  ? Colors.green
                  : isCurrent
                  ? Colors.blue
                  : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Dot
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : isCurrent
                  ? Colors.blue
                  : Colors.grey,
              shape: BoxShape.circle,
            ),
            child: isCurrent
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
        ],
      ),
    );
  }
}

class Phase {
  final String name;
  final DateTime date;

  Phase(this.name, this.date);
}