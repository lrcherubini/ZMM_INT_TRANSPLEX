@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZI_PurchaseOrder
  as select from I_PurchaseOrderAPI01
  composition [1..*] of ZI_PurchaseOrderItem as _PurchaseOrderItem
{
  key PurchaseOrder,
      PurchaseOrderType,
      PurchaseOrderSubtype,
      PurchasingDocumentOrigin,
      CreatedByUser,
      CreationDate,
      PurchaseOrderDate,
      Language,
      CorrespncExternalReference,
      CorrespncInternalReference,
      PurchasingDocumentDeletionCode,
      ReleaseIsNotCompleted,
      PurchasingCompletenessStatus,
      PurchasingProcessingStatus,
      PurgReleaseSequenceStatus,
      ReleaseCode,
      CompanyCode,
      PurchasingOrganization,
      PurchasingGroup,
      Supplier,
      ManualSupplierAddressID,
      SupplierRespSalesPersonName,
      SupplierPhoneNumber,
      SupplyingSupplier,
      SupplyingPlant,
      InvoicingParty,
      Customer,
      SupplierQuotationExternalID,
      PaymentTerms,
      CashDiscount1Days,
      CashDiscount2Days,
      NetPaymentDays,
      CashDiscount1Percent,
      CashDiscount2Percent,
      DownPaymentType,
      DownPaymentPercentageOfTotAmt,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      DownPaymentAmount,
      DownPaymentDueDate,
      IncotermsClassification,
      IncotermsTransferLocation,
      IncotermsVersion,
      IncotermsLocation1,
      IncotermsLocation2,
      IsIntrastatReportingRelevant,
      IsIntrastatReportingExcluded,
      PricingDocument,
      PricingProcedure,
      DocumentCurrency,
      ValidityStartDate,
      ValidityEndDate,
      ExchangeRate,
      ExchangeRateIsFixed,
      LastChangeDateTime,
      TaxReturnCountry,
      VATRegistrationCountry,
      PurgReasonForDocCancellation,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PurgReleaseTimeTotalAmount,
      PurgAggrgdProdCmplncSuplrSts,
      PurgAggrgdProdMarketabilitySts,
      PurgAggrgdSftyDataSheetStatus,
      PurgProdCmplncTotDngrsGoodsSts,

      /* Associations */
      _PurchaseOrderItem
}
