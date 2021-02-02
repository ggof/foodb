import 'package:foodb/core/domain/entities/model.dart';

class Step extends Model {
  final String description;

  Step({String id, this.description}) : super(id: id);

  factory Step.fromJSON(Map<String, dynamic> json) => Step(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "description": description,
      };

  static bool isValid(Step s) => s.description.isNotEmpty;
}
