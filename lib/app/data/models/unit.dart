
const _unitId = 'id';
const _unitName = 'name';
const _unitWeight = 'weight';

class Unit {
  final int id;
  String name;
  final double weight;

  Unit({required this.id, required this.name, required this.weight});
  Unit.fromJson(Map<String, dynamic> unit)
      : id = unit[_unitId],
        name = unit[_unitName],
        weight = (unit[_unitWeight] as num).toDouble();
}
