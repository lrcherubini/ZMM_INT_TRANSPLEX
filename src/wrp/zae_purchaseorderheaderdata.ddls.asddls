@EndUserText.label: 'Action parameters PO Header'
define root abstract entity ZAE_PurchaseOrderHeaderData
{
  key PurchaseOrder          : vdm_purchaseorder;
      CompanyCode            : bukrs;
      PurchaseOrderType      : esart;
      Supplier               : md_supplier;
      PaymentTerms           : farp_dzterm;
      PurchasingOrganization : ekorg;
      PurchasingGroup        : bkgrp;
      DocumentCurrency       : waers;

      _PurchaseOrderItem     : composition [1..*] of ZAE_PurchaseOrderItemData;

}
