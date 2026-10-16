import 'package:ekp_api/ekp_api.dart';

/// What the ticket control code holds in demo mode: nothing anyone could
/// check a ticket with.
const demoTicketCode = 'mobileKKM demo';

/// What the Karta Krakowska status code holds in demo mode.
const demoCityCardCode = 'mobileKKM demo';

/// [data] with a made-up person in place of the user's: name, e-mail, PESEL,
/// date of birth, phone, address and customer number, and no photo (the
/// initials stand in). What the account has (a card, a detached one, the
/// Karta Krakowska status and its dates) stays as it is, so the screens look
/// as they really would.
UserDataResponse? demoUserData(UserDataResponse? data) {
  if (data == null) {
    return null;
  }
  final user = data.userData;
  final mkkm = data.mkkmData;
  return data.copyWith(
    userData: user?.copyWith(
      pesel: '90010100000',
      birthDate: DateTime(1990),
      email: 'anna.kowalska@example.com',
      firstName: 'Anna',
      lastName: 'Kowalska',
      phoneNumber: '600000000',
      photoUrl: null,
      registeredAddress: const Address(
        city: 'Kraków',
        postalCode: '30-001',
        street: 'ul. Przykładowa',
        buildingNumber: '1',
        apartmentNumber: '2',
      ),
    ),
    mkkmData: mkkm?.copyWith(customerCode: mkkm.customerCode == null ? null : '123456'),
  );
}
