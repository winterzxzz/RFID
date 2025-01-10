enum PartEnum {
  part1,
  part2,
  part3,
  part4,
  part5,
  part6,
  part7,
}

extension PartExtension on PartEnum {
  int get numValue => index + 1;

  String get name => switch (this) {
        PartEnum.part1 => 'Part 1',
        PartEnum.part2 => 'Part 2',
        PartEnum.part3 => 'Part 3',
        PartEnum.part4 => 'Part 4',
        PartEnum.part5 => 'Part 5',
        PartEnum.part6 => 'Part 6',
        PartEnum.part7 => 'Part 7',
      };
}

extension PartIntExtension on int {
  PartEnum get partValue => PartEnum.values[this - 1];
}
