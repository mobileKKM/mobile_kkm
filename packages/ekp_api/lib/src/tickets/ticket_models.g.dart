// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MkkmTicket _$MkkmTicketFromJson(Map<String, dynamic> json) => _MkkmTicket(
  ticketGuid: json['ticketGuid'] as String?,
  transactionCode: json['transactionCode'] as String?,
  status: json['status'] as String?,
  datePurchase: json['datePurchase'] == null
      ? null
      : DateTime.parse(json['datePurchase'] as String),
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  monthsPeriod: (json['monthsPeriod'] as num?)?.toInt(),
  daysPeriod: (json['daysPeriod'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  isAnyAssigned: json['isAnyAssigned'] as bool?,
  assigned: json['assigned'] as bool?,
  canAssign: json['canAssign'] as bool?,
  forCitizen: json['forCitizen'] as bool?,
  ticketKindCode: (json['ticketKindCode'] as num?)?.toInt(),
  ticketNumberOfLineCode: (json['ticketNumberOfLineCode'] as num?)?.toInt(),
  ticketPeriodCode: (json['ticketPeriodCode'] as num?)?.toInt(),
  specialTransportLine: json['specialTransportLine'] as String?,
  isNetwork: json['isNetwork'] as bool?,
  isMetropolitan: json['isMetropolitan'] as bool?,
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => TransportLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TransportLine>[],
  fivePlusOneTicket: json['fivePlusOneTicket'] as bool?,
  customerId: (json['customerId'] as num?)?.toInt(),
  customerCode: (json['customerCode'] as num?)?.toInt(),
  cityCardTypeCode: (json['cityCardTypeCode'] as num?)?.toInt(),
  productName: json['productName'] as String?,
  paymentStateId: (json['paymentStateId'] as num?)?.toInt(),
  paymentStateDescription: json['paymentStateDescription'] as String?,
  paymentTypeCode: (json['paymentTypeCode'] as num?)?.toInt(),
  paymentDescription: json['paymentDescription'] as String?,
  promotionName: json['promotionName'] as String?,
  cityCardTypeName: json['cityCardTypeName'] as String?,
);

Map<String, dynamic> _$MkkmTicketToJson(_MkkmTicket instance) =>
    <String, dynamic>{
      'ticketGuid': instance.ticketGuid,
      'transactionCode': instance.transactionCode,
      'status': instance.status,
      'datePurchase': instance.datePurchase?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'monthsPeriod': instance.monthsPeriod,
      'daysPeriod': instance.daysPeriod,
      'price': instance.price,
      'isAnyAssigned': instance.isAnyAssigned,
      'assigned': instance.assigned,
      'canAssign': instance.canAssign,
      'forCitizen': instance.forCitizen,
      'ticketKindCode': instance.ticketKindCode,
      'ticketNumberOfLineCode': instance.ticketNumberOfLineCode,
      'ticketPeriodCode': instance.ticketPeriodCode,
      'specialTransportLine': instance.specialTransportLine,
      'isNetwork': instance.isNetwork,
      'isMetropolitan': instance.isMetropolitan,
      'lines': instance.lines,
      'fivePlusOneTicket': instance.fivePlusOneTicket,
      'customerId': instance.customerId,
      'customerCode': instance.customerCode,
      'cityCardTypeCode': instance.cityCardTypeCode,
      'productName': instance.productName,
      'paymentStateId': instance.paymentStateId,
      'paymentStateDescription': instance.paymentStateDescription,
      'paymentTypeCode': instance.paymentTypeCode,
      'paymentDescription': instance.paymentDescription,
      'promotionName': instance.promotionName,
      'cityCardTypeName': instance.cityCardTypeName,
    };

_MkkmTicketsResponse _$MkkmTicketsResponseFromJson(Map<String, dynamic> json) =>
    _MkkmTicketsResponse(
      tickets:
          (json['tickets'] as List<dynamic>?)
              ?.map((e) => MkkmTicket.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MkkmTicket>[],
      code: json['code'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MkkmTicketsResponseToJson(
  _MkkmTicketsResponse instance,
) => <String, dynamic>{
  'tickets': instance.tickets,
  'code': instance.code,
  'message': instance.message,
};

_TicketHistoryEntry _$TicketHistoryEntryFromJson(Map<String, dynamic> json) =>
    _TicketHistoryEntry(
      transactionId: (json['transactionId'] as num?)?.toInt(),
      transactionCode: json['transactionCode'] as String?,
      imported: json['imported'] as bool?,
      transactionDate: json['transactionDate'] == null
          ? null
          : DateTime.parse(json['transactionDate'] as String),
      ticketStartDate: json['ticketStartDate'] == null
          ? null
          : DateTime.parse(json['ticketStartDate'] as String),
      ticketExpiryDate: json['ticketExpiryDate'] == null
          ? null
          : DateTime.parse(json['ticketExpiryDate'] as String),
      specialTransportLine: json['specialTransportLine'] as String?,
      isNetwork: json['isNetwork'] as bool?,
      isMetropolitan: json['isMetropolitan'] as bool?,
      cityLine1: (json['cityLine1'] as num?)?.toInt(),
      zoneLine1: (json['zoneLine1'] as num?)?.toInt(),
      cityLine2: (json['cityLine2'] as num?)?.toInt(),
      zoneLine2: (json['zoneLine2'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      transactionStateId: (json['transactionStateId'] as num?)?.toInt(),
      transactionStateDescription:
          json['transactionStateDescription'] as String?,
      paymentTypeCode: (json['paymentTypeCode'] as num?)?.toInt(),
      paymentDescription: json['paymentDescription'] as String?,
      paymentStateId: (json['paymentStateId'] as num?)?.toInt(),
      paymentStateDescription: json['paymentStateDescription'] as String?,
      paymentAccepted: json['paymentAccepted'] == null
          ? null
          : DateTime.parse(json['paymentAccepted'] as String),
      productIndex: json['productIndex'] as String?,
      productName: json['productName'] as String?,
      productType: (json['productType'] as num?)?.toInt(),
      productTypeName: json['productTypeName'] as String?,
      promotionName: json['promotionName'] as String?,
      isPayed: json['isPayed'] as bool?,
      ticketKindCode: (json['ticketKindCode'] as num?)?.toInt(),
      ticketPeriodCode: (json['ticketPeriodCode'] as num?)?.toInt(),
      ticketNumberOfLineCode: (json['ticketNumberOfLineCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TicketHistoryEntryToJson(_TicketHistoryEntry instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'transactionCode': instance.transactionCode,
      'imported': instance.imported,
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'ticketStartDate': instance.ticketStartDate?.toIso8601String(),
      'ticketExpiryDate': instance.ticketExpiryDate?.toIso8601String(),
      'specialTransportLine': instance.specialTransportLine,
      'isNetwork': instance.isNetwork,
      'isMetropolitan': instance.isMetropolitan,
      'cityLine1': instance.cityLine1,
      'zoneLine1': instance.zoneLine1,
      'cityLine2': instance.cityLine2,
      'zoneLine2': instance.zoneLine2,
      'price': instance.price,
      'transactionStateId': instance.transactionStateId,
      'transactionStateDescription': instance.transactionStateDescription,
      'paymentTypeCode': instance.paymentTypeCode,
      'paymentDescription': instance.paymentDescription,
      'paymentStateId': instance.paymentStateId,
      'paymentStateDescription': instance.paymentStateDescription,
      'paymentAccepted': instance.paymentAccepted?.toIso8601String(),
      'productIndex': instance.productIndex,
      'productName': instance.productName,
      'productType': instance.productType,
      'productTypeName': instance.productTypeName,
      'promotionName': instance.promotionName,
      'isPayed': instance.isPayed,
      'ticketKindCode': instance.ticketKindCode,
      'ticketPeriodCode': instance.ticketPeriodCode,
      'ticketNumberOfLineCode': instance.ticketNumberOfLineCode,
    };

_TicketStateChange _$TicketStateChangeFromJson(Map<String, dynamic> json) =>
    _TicketStateChange(
      nextNumber: (json['nextNumber'] as num?)?.toInt(),
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      stateDescription: json['stateDescription'] as String?,
    );

Map<String, dynamic> _$TicketStateChangeToJson(_TicketStateChange instance) =>
    <String, dynamic>{
      'nextNumber': instance.nextNumber,
      'createDate': instance.createDate?.toIso8601String(),
      'stateDescription': instance.stateDescription,
    };

_TicketDetailResponse _$TicketDetailResponseFromJson(
  Map<String, dynamic> json,
) => _TicketDetailResponse(
  customerId: (json['customerId'] as num?)?.toInt(),
  ticket: json['ticket'] == null
      ? null
      : TicketHistoryEntry.fromJson(json['ticket'] as Map<String, dynamic>),
  ticketEkp: json['ticketEkp'] == null
      ? null
      : MkkmTicket.fromJson(json['ticketEkp'] as Map<String, dynamic>),
  canChangeLine: json['canChangeLine'] as bool?,
  canReturn: json['canReturn'] as bool?,
  canEditByInternet: json['canEditByInternet'] as bool?,
  canChangeStorageMedium: json['canChangeStorageMedium'] as bool?,
  canGenerateInvoice: json['canGenerateInvoice'] as bool?,
  canBuyTheSame: json['canBuyTheSame'] as bool?,
  possibleRefundViaTpay: json['possibleRefundViaTpay'] as bool?,
  minExpireReturnDate: json['minExpireReturnDate'] == null
      ? null
      : DateTime.parse(json['minExpireReturnDate'] as String),
  invoiceHeaderId: (json['invoiceHeaderId'] as num?)?.toInt(),
  transactionStateList: (json['transactionStateList'] as List<dynamic>?)
      ?.map((e) => TicketStateChange.fromJson(e as Map<String, dynamic>))
      .toList(),
  paymentStateList: (json['paymentStateList'] as List<dynamic>?)
      ?.map((e) => TicketStateChange.fromJson(e as Map<String, dynamic>))
      .toList(),
  refundStateList: (json['refundStateList'] as List<dynamic>?)
      ?.map((e) => TicketStateChange.fromJson(e as Map<String, dynamic>))
      .toList(),
  changeLineList: (json['changeLineList'] as List<dynamic>?)
      ?.map((e) => TicketStateChange.fromJson(e as Map<String, dynamic>))
      .toList(),
  ticketReturns: json['ticketReturns'],
  storageMediumChanges: json['storageMediumChanges'],
  downloads: json['downloads'],
);

Map<String, dynamic> _$TicketDetailResponseToJson(
  _TicketDetailResponse instance,
) => <String, dynamic>{
  'customerId': instance.customerId,
  'ticket': instance.ticket,
  'ticketEkp': instance.ticketEkp,
  'canChangeLine': instance.canChangeLine,
  'canReturn': instance.canReturn,
  'canEditByInternet': instance.canEditByInternet,
  'canChangeStorageMedium': instance.canChangeStorageMedium,
  'canGenerateInvoice': instance.canGenerateInvoice,
  'canBuyTheSame': instance.canBuyTheSame,
  'possibleRefundViaTpay': instance.possibleRefundViaTpay,
  'minExpireReturnDate': instance.minExpireReturnDate?.toIso8601String(),
  'invoiceHeaderId': instance.invoiceHeaderId,
  'transactionStateList': instance.transactionStateList,
  'paymentStateList': instance.paymentStateList,
  'refundStateList': instance.refundStateList,
  'changeLineList': instance.changeLineList,
  'ticketReturns': instance.ticketReturns,
  'storageMediumChanges': instance.storageMediumChanges,
  'downloads': instance.downloads,
};

_SalesLineOption _$SalesLineOptionFromJson(Map<String, dynamic> json) =>
    _SalesLineOption(
      code: (json['code'] as num?)?.toInt(),
      description: json['description'] as String?,
      urbanLineQty: (json['urbanLineQty'] as num?)?.toInt(),
      suburbanLineQty: (json['suburbanLineQty'] as num?)?.toInt(),
      suburban2LineQty: (json['suburban2LineQty'] as num?)?.toInt(),
      isMetropolitan: json['isMetropolitan'] as bool?,
      isNetwork: json['isNetwork'] as bool?,
      selectableLines: json['selectableLines'] as bool?,
      sumLinesToSelection: (json['sumLinesToSelection'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SalesLineOptionToJson(_SalesLineOption instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'urbanLineQty': instance.urbanLineQty,
      'suburbanLineQty': instance.suburbanLineQty,
      'suburban2LineQty': instance.suburban2LineQty,
      'isMetropolitan': instance.isMetropolitan,
      'isNetwork': instance.isNetwork,
      'selectableLines': instance.selectableLines,
      'sumLinesToSelection': instance.sumLinesToSelection,
    };

_SalesPeriodOption _$SalesPeriodOptionFromJson(Map<String, dynamic> json) =>
    _SalesPeriodOption(
      code: (json['code'] as num?)?.toInt(),
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toInt(),
      unit: (json['unit'] as num?)?.toInt(),
      isMetropolitan: json['isMetropolitan'] as bool?,
      isNetwork: json['isNetwork'] as bool?,
      useDescription: json['useDescription'] as bool?,
    );

Map<String, dynamic> _$SalesPeriodOptionToJson(_SalesPeriodOption instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'value': instance.value,
      'unit': instance.unit,
      'isMetropolitan': instance.isMetropolitan,
      'isNetwork': instance.isNetwork,
      'useDescription': instance.useDescription,
    };

_SalesKindOption _$SalesKindOptionFromJson(Map<String, dynamic> json) =>
    _SalesKindOption(
      code: (json['code'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SalesKindOptionToJson(_SalesKindOption instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
    };

_SpecialTransportLine _$SpecialTransportLineFromJson(
  Map<String, dynamic> json,
) => _SpecialTransportLine(
  specialTransportLine: json['specialTransportLine'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  buttonName: json['buttonName'] as String?,
  isNetwork: json['isNetwork'] as bool?,
  isMetropolitan: json['isMetropolitan'] as bool?,
);

Map<String, dynamic> _$SpecialTransportLineToJson(
  _SpecialTransportLine instance,
) => <String, dynamic>{
  'specialTransportLine': instance.specialTransportLine,
  'name': instance.name,
  'description': instance.description,
  'buttonName': instance.buttonName,
  'isNetwork': instance.isNetwork,
  'isMetropolitan': instance.isMetropolitan,
};

_PriceListConfiguration _$PriceListConfigurationFromJson(
  Map<String, dynamic> json,
) => _PriceListConfiguration(
  ticketKindCode: (json['ticketKindCode'] as num?)?.toInt(),
  ticketNumberOfLineCode: (json['ticketNumberOfLineCode'] as num?)?.toInt(),
  ticketPeriodCode: (json['ticketPeriodCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$PriceListConfigurationToJson(
  _PriceListConfiguration instance,
) => <String, dynamic>{
  'ticketKindCode': instance.ticketKindCode,
  'ticketNumberOfLineCode': instance.ticketNumberOfLineCode,
  'ticketPeriodCode': instance.ticketPeriodCode,
};

_TicketSalesConfiguration _$TicketSalesConfigurationFromJson(
  Map<String, dynamic> json,
) => _TicketSalesConfiguration(
  hasCracovCardPrivilege: json['hasCracovCardPrivilege'] as bool?,
  firstDayOfValidity: json['firstDayOfValidity'] == null
      ? null
      : DateTime.parse(json['firstDayOfValidity'] as String),
  lastDayOfValidity: json['lastDayOfValidity'] == null
      ? null
      : DateTime.parse(json['lastDayOfValidity'] as String),
  ticketNumberOfLines:
      (json['ticketNumberOfLines'] as List<dynamic>?)
          ?.map((e) => SalesLineOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SalesLineOption>[],
  ticketPeriods:
      (json['ticketPeriods'] as List<dynamic>?)
          ?.map((e) => SalesPeriodOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SalesPeriodOption>[],
  ticketKinds:
      (json['ticketKinds'] as List<dynamic>?)
          ?.map((e) => SalesKindOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SalesKindOption>[],
  specialTransportLines:
      (json['specialTransportLines'] as List<dynamic>?)
          ?.map((e) => SpecialTransportLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SpecialTransportLine>[],
  priceListConfigurations:
      (json['priceListConfigurations'] as List<dynamic>?)
          ?.map(
            (e) => PriceListConfiguration.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <PriceListConfiguration>[],
  code: json['code'],
  message: json['message'] as String?,
);

Map<String, dynamic> _$TicketSalesConfigurationToJson(
  _TicketSalesConfiguration instance,
) => <String, dynamic>{
  'hasCracovCardPrivilege': instance.hasCracovCardPrivilege,
  'firstDayOfValidity': instance.firstDayOfValidity?.toIso8601String(),
  'lastDayOfValidity': instance.lastDayOfValidity?.toIso8601String(),
  'ticketNumberOfLines': instance.ticketNumberOfLines,
  'ticketPeriods': instance.ticketPeriods,
  'ticketKinds': instance.ticketKinds,
  'specialTransportLines': instance.specialTransportLines,
  'priceListConfigurations': instance.priceListConfigurations,
  'code': instance.code,
  'message': instance.message,
};

_TicketCalculation _$TicketCalculationFromJson(Map<String, dynamic> json) =>
    _TicketCalculation(
      commodityIndex: json['commodityIndex'] as String?,
      commodityName: json['commodityName'] as String?,
      symbol: json['symbol'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      validFrom: json['validFrom'] == null
          ? null
          : DateTime.parse(json['validFrom'] as String),
      validTo: json['validTo'] == null
          ? null
          : DateTime.parse(json['validTo'] as String),
      daysPeriod: (json['daysPeriod'] as num?)?.toInt(),
      forCitizen: json['forCitizen'] as bool?,
      ticketKindCode: (json['ticketKindCode'] as num?)?.toInt(),
      ticketNumberOfLineCode: (json['ticketNumberOfLineCode'] as num?)?.toInt(),
      ticketPeriodCode: (json['ticketPeriodCode'] as num?)?.toInt(),
      specialTransportLine: json['specialTransportLine'] as String?,
      isNetwork: json['isNetwork'] as bool?,
      isMetropolitan: json['isMetropolitan'] as bool?,
      lines: json['lines'] as List<dynamic>? ?? const <dynamic>[],
      hasSimilarTicket: json['hasSimilarTicket'] as bool?,
      commodityId: (json['commodityId'] as num?)?.toInt(),
      priceListPeriodId: (json['priceListPeriodId'] as num?)?.toInt(),
      customerCode: (json['customerCode'] as num?)?.toInt(),
      similarTickets:
          json['similarTickets'] as List<dynamic>? ?? const <dynamic>[],
    );

Map<String, dynamic> _$TicketCalculationToJson(_TicketCalculation instance) =>
    <String, dynamic>{
      'commodityIndex': instance.commodityIndex,
      'commodityName': instance.commodityName,
      'symbol': instance.symbol,
      'price': instance.price,
      'validFrom': instance.validFrom?.toIso8601String(),
      'validTo': instance.validTo?.toIso8601String(),
      'daysPeriod': instance.daysPeriod,
      'forCitizen': instance.forCitizen,
      'ticketKindCode': instance.ticketKindCode,
      'ticketNumberOfLineCode': instance.ticketNumberOfLineCode,
      'ticketPeriodCode': instance.ticketPeriodCode,
      'specialTransportLine': instance.specialTransportLine,
      'isNetwork': instance.isNetwork,
      'isMetropolitan': instance.isMetropolitan,
      'lines': instance.lines,
      'hasSimilarTicket': instance.hasSimilarTicket,
      'commodityId': instance.commodityId,
      'priceListPeriodId': instance.priceListPeriodId,
      'customerCode': instance.customerCode,
      'similarTickets': instance.similarTickets,
    };

_PurchaseUrls _$PurchaseUrlsFromJson(Map<String, dynamic> json) =>
    _PurchaseUrls(
      paymentUrl: json['paymentUrl'] as String?,
      returnUrl: json['returnUrl'] as String?,
      returnErrorUrl: json['returnErrorUrl'] as String?,
    );

Map<String, dynamic> _$PurchaseUrlsToJson(_PurchaseUrls instance) =>
    <String, dynamic>{
      'paymentUrl': instance.paymentUrl,
      'returnUrl': instance.returnUrl,
      'returnErrorUrl': instance.returnErrorUrl,
    };

_TicketPurchaseResponse _$TicketPurchaseResponseFromJson(
  Map<String, dynamic> json,
) => _TicketPurchaseResponse(
  ticket: json['ticket'] == null
      ? null
      : MkkmTicket.fromJson(json['ticket'] as Map<String, dynamic>),
  urls: json['urls'] == null
      ? null
      : PurchaseUrls.fromJson(json['urls'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TicketPurchaseResponseToJson(
  _TicketPurchaseResponse instance,
) => <String, dynamic>{'ticket': instance.ticket, 'urls': instance.urls};

_TicketReturnCalculation _$TicketReturnCalculationFromJson(
  Map<String, dynamic> json,
) => _TicketReturnCalculation(
  returnPrice: (json['returnPrice'] as num?)?.toDouble(),
  ticketStartDate: json['ticketStartDate'] == null
      ? null
      : DateTime.parse(json['ticketStartDate'] as String),
  newTicketExpiryDate: json['newTicketExpiryDate'] == null
      ? null
      : DateTime.parse(json['newTicketExpiryDate'] as String),
  code: json['code'],
  message: json['message'] as String?,
);

Map<String, dynamic> _$TicketReturnCalculationToJson(
  _TicketReturnCalculation instance,
) => <String, dynamic>{
  'returnPrice': instance.returnPrice,
  'ticketStartDate': instance.ticketStartDate?.toIso8601String(),
  'newTicketExpiryDate': instance.newTicketExpiryDate?.toIso8601String(),
  'code': instance.code,
  'message': instance.message,
};

_TicketReturnResult _$TicketReturnResultFromJson(Map<String, dynamic> json) =>
    _TicketReturnResult(
      createdCorrectionInvoice: json['createdCorrectionInvoice'] as bool?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$TicketReturnResultToJson(_TicketReturnResult instance) =>
    <String, dynamic>{
      'createdCorrectionInvoice': instance.createdCorrectionInvoice,
      'success': instance.success,
    };

_TicketAssignResponse _$TicketAssignResponseFromJson(
  Map<String, dynamic> json,
) => _TicketAssignResponse(
  assigned: json['assigned'] as bool?,
  code: json['code'],
  message: json['message'] as String?,
);

Map<String, dynamic> _$TicketAssignResponseToJson(
  _TicketAssignResponse instance,
) => <String, dynamic>{
  'assigned': instance.assigned,
  'code': instance.code,
  'message': instance.message,
};

_TicketContractResponse _$TicketContractResponseFromJson(
  Map<String, dynamic> json,
) => _TicketContractResponse(
  contract: json['contract'] as String?,
  code: json['code'],
  message: json['message'] as String?,
);

Map<String, dynamic> _$TicketContractResponseToJson(
  _TicketContractResponse instance,
) => <String, dynamic>{
  'contract': instance.contract,
  'code': instance.code,
  'message': instance.message,
};
