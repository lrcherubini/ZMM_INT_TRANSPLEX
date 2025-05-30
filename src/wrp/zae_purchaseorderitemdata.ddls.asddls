@EndUserText.label: 'Action parameters PO Items'
define abstract entity ZAE_PurchaseOrderItemData
{
  key PurchaseOrder             : vdm_purchaseorder;
  key PurchaseOrderItem         : vdm_purchaseorderitem;
      Plant                     : ewerk;
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      OrderQuantity             : bstmg;
      PurchaseOrderQuantityUnit : bstme;
      DocumentCurrency          : waers;
      @Semantics.amount.currencyCode:'DocumentCurrency'
      NetPriceAmount            : bprei;
      TaxCode                   : mwskz;
      Material                  : matnr;

      _PurchaseOrder            : association to parent ZAE_PurchaseOrderHeaderData on _PurchaseOrder.PurchaseOrder = $projection.PurchaseOrder;
}
