(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  this.ElectricCalculator = SC.Application.create();
  this.ElectricCalculator.ElectricBill = SC.Object.extend({
    kwh: null,
    result: null,
    getResult: (function() {
      var kwh;
      if (kwh = this.get("kwh")) {
        return $.getJSON("/electric_bills/calculate?kwh=" + kwh, __bind(function(json) {
          return this.set("result", json);
        }, this));
      }
    }).property('kwh')
  });
  this.ElectricCalculator.ElectricBillListController = SC.ArrayController.create({
    content: [],
    createElecticBill: function(kwh) {
      var electricBill;
      electricBill = ElectricCalculator.ElectricBill.create({
        kwh: kwh
      });
      electricBill.getResult();
      return this.pushObject(electricBill);
    },
    clearBills: function() {
      return this.forEach(this.removeObject, this);
    }
  });
  this.ElectricCalculator.CreateElectricBillView = SC.TemplateView.create(SC.TextFieldSupport, {
    insertNewline: function() {
      var value;
      value = this.get('value');
      if (value) {
        ElectricCalculator.ElectricBillListController.createElecticBill(value);
        return this.set('value', '');
      }
    }
  });
  this.ElectricCalculator.ElectricBillListView = SC.TemplateCollectionView.create({
    contentBinding: 'ElectricCalculator.ElectricBillListController'
  });
  this.ElectricCalculator.ClearBillsView = SC.TemplateView.create({
    mouseUp: function() {
      return ElectricCalculator.ElectricBillListController.clearBills();
    }
  });
  SC.ready(function() {
    return ElectricCalculator.mainPane = SC.TemplatePane.append({
      layerId: 'electric_calculator',
      templateName: 'electric_calculator'
    });
  });
}).call(this);
