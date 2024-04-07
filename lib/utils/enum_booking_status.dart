enum BookingTypes { NEW, ACCEPTED, REJECTED }

extension BookingTypesExtension on BookingTypes {
  String get value {
    switch (this) {
      case BookingTypes.NEW:
        return 'NEW';
      case BookingTypes.ACCEPTED:
        return 'ACCEPTED';
      case BookingTypes.REJECTED:
        return 'REJECTED';
    }
  }
}
