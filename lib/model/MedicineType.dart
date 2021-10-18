enum MedicineType {
  Liquid,
  Pill,
  Syringe,
  Tablet,
  Other,
}

class StringToEnum {
  static MedicineType toEnum(String string) {
    switch (string) {
      case 'Liquid':
        return MedicineType.Liquid;
      case 'Pill':
        return MedicineType.Pill;
      case 'Syringe':
        return MedicineType.Syringe;
      case 'Tablet':
        return MedicineType.Tablet;
      case 'Other':
        return MedicineType.Other;
      default:
        return null;
    }
  }
}

extension MedicineString on String {
  MedicineType get medicineType {
    switch (this) {
      case 'Liquid':
        return MedicineType.Liquid;
      case 'Pill':
        return MedicineType.Pill;
      case 'Syringe':
        return MedicineType.Syringe;
      case 'Tablet':
        return MedicineType.Tablet;
      case 'Other':
        return MedicineType.Other;
      default:
        return null;
    }
  }
}

extension MedicineExtension on MedicineType {
  String get string {
    switch (this) {
      case MedicineType.Liquid:
        return 'Liquid';
      case MedicineType.Pill:
        return 'Pill';
      case MedicineType.Syringe:
        return 'Syringe';
      case MedicineType.Tablet:
        return 'Tablet';
      case MedicineType.Other:
        return 'Other';
    }
  }
}
