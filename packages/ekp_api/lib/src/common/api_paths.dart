/// All EKP API endpoint paths observed in the wild.
abstract final class EkpApiPaths {
  EkpApiPaths._();

  static const String apiRoot = '/api/v1';

  // ---------------------------------------------------------------- auth
  static const String login = '$apiRoot/auth/login';
  static const String logout = '$apiRoot/auth/logout';
  static const String register = '$apiRoot/auth/register';
  static const String activate = '$apiRoot/auth/activate';
  static const String changePassword = '$apiRoot/auth/change-password';
  static const String resetPassword = '$apiRoot/auth/reset-password';
  static const String resetPasswordLinkRequest = '$apiRoot/auth/reset-password-link-request';
  static const String tokenRecover = '$apiRoot/auth/token/recover';
  // Deliberately NOT implemented: `auth/token/refresh`. It carries no
  // credential of its own — it authenticates via the `access-token` cookie
  // persisted by an earlier login/recover, so it needs a pre-loaded cookie
  // jar (ours is in-memory; after an app restart the endpoint 401s).
  // `token/recover` is the single token-rotation path.
  static const String passwordPolicy = '$apiRoot/auth/password-policy';
  static const String authMarketingConsents = '$apiRoot/auth/marketing-consents';

  // ------------------------------------------------------------- account
  static const String userData = '$apiRoot/account/user-data';
  static const String inhabitantStatus = '$apiRoot/account/inhabitant-status';
  static const String inhabitantContract = '$apiRoot/account/inhabitant-contract';
  static const String streetAutocomplete = '$apiRoot/account/street-autocomplete';
  static const String accountPhoto = '$apiRoot/account/photo';
  static const String accountAnonymise = '$apiRoot/account/anonymise';

  // ------------------------------------------------------- storage medium
  static const String storageMediumList = '$apiRoot/storage-medium/list';
  static const String storageMediumCreateMkkm = '$apiRoot/storage-medium/create-mkkm';

  // ---------------------------------------------------------- dictionary
  static const String ticketKindList = '$apiRoot/dictionary/ticket-kind-list';
  static const String ticketNumberOfLineList = '$apiRoot/dictionary/ticket-number-of-line-list';
  static const String ticketPeriodList = '$apiRoot/dictionary/ticket-period-list';
  static const String transportLine = '$apiRoot/dictionary/transport-line';
  static const String cityCardTypes = '$apiRoot/dictionary/city-card-types';

  // -------------------------------------------------------------- tickets
  static const String mkkmTicketsList = '$apiRoot/mkkm/tickets/list';
  static const String mkkmTicketsAssignE = '$apiRoot/mkkm/tickets/assign-e';
  static const String mkkmTicketsContractE = '$apiRoot/mkkm/tickets/contract-e';
  static const String tickets = '$apiRoot/tickets';
  static const String ticketsCalculate = '$apiRoot/tickets/calculate';
  static const String ticketsBuy = '$apiRoot/tickets/buy';
  static const String ticketsPay = '$apiRoot/tickets/pay';
  static const String ticketsLineChangeEdit = '$apiRoot/tickets/line-change/edit';
  static const String ticketSalesConfiguration = '$apiRoot/tickets/ticket-sales-configuration';
  static const String ticketReturns = '$apiRoot/ticket-returns';
  static const String ticketReturnsCalculate = '$apiRoot/ticket-returns/calculate';

  // ------------------------------------------------------------ payments
  static const String paymentsBanks = '$apiRoot/payments/banks';
  static const String paymentsCheck = '$apiRoot/payments/check';
  static const String paymentsResult = '$apiRoot/payments/result';
  static const String paymentsChangePaymentCard = '$apiRoot/payments/change-payment-card';
  static const String paymentsAddPaymentCard = '$apiRoot/payments/add-payment-card';

  // -------------------------------------------------------- subscriptions
  static const String subscriptionsDetails = '$apiRoot/subscriptions/details';
  static const String subscriptionsAvailableActions = '$apiRoot/subscriptions/available-actions';
  static const String subscriptionsMarketingConsents = '$apiRoot/subscriptions/marketing-consents';
  static const String subscriptionsSignIn = '$apiRoot/subscriptions/sign-in';
  static const String subscriptionsCancel = '$apiRoot/subscriptions/cancel';
  // The paths below were never captured: they come from the official
  // client's path table and call sites.
  static const String subscriptionsEdit = '$apiRoot/subscriptions/edit';

  /// Base of `subscriptions/tickets/{ticketGuid}/remove`.
  static const String subscriptionsTickets = '$apiRoot/subscriptions/tickets';
  static const String subscriptionsTicketsBuyingDetails = '$apiRoot/subscriptions/tickets/buying-ticket-details';
  static const String subscriptionsTicketsBuy = '$apiRoot/subscriptions/tickets/buy';
  static const String subscriptionsTicketsPay = '$apiRoot/subscriptions/tickets/pay';
  // Deliberately NOT implemented: `subscriptions/is_signed_in` and
  // `subscriptions/tickets/return`. Both are in the official client's path
  // table but nothing calls them, so their method and shapes are unknown.

  // ------------------------------------------------------------ invoices
  static const String invoices = '$apiRoot/invoices';

  // ---------------------------------------------------------------- misc
  static const String serviceStatus = '$apiRoot/service-status';
  static const String mobileAppConfig = '$apiRoot/client/mobile-app/config';
}
