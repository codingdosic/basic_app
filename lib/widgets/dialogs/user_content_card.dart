import 'package:basic_app/models/customMarker.dart';
import 'package:basic_app/models/journey.dart';
import 'package:flutter/material.dart';

typedef MarkerCallback = void Function();
typedef JourneyCallback = void Function();

class MarkerCard extends StatelessWidget {
  final CustomMarker marker;
  final VoidCallback onToggleVisibility;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const MarkerCard({
    super.key,
    required this.marker,
    required this.onToggleVisibility,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      child: InkWell(
        
          onTap: onTap,
          
          child: ListTile(
          leading: const Icon(Icons.place),
          title: Text(marker.title),
          subtitle: Text(marker.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  marker.visibility ? Icons.visibility : Icons.visibility_off,
                  color: marker.visibility ? Colors.green : Colors.grey,
                ),
                tooltip: '가시성',
                onPressed: onToggleVisibility,
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: '수정',
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: '삭제',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      )
    );
  }
}

class JourneyCard extends StatelessWidget {
  final Journey journey;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const JourneyCard({
    super.key,
    required this.journey,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.map),
        title: Text(journey.title),
        subtitle: Text(journey.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: '수정',
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: '삭제',
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
