@ElectricCalculator = SC.Application.create();

@ElectricCalculator.ElectricBill = SC.Object.extend({
  kwh: null
  result: null
  
  getResult: (->
    if kwh = @get("kwh")
      $.getJSON("/electric_bills/calculate?kwh=#{kwh}", (json) =>
        @set("result", json)
      )
  ).property('kwh')
})

@ElectricCalculator.ElectricBillListController = SC.ArrayController.create({
  content: [],
  
  createElecticBill: (kwh) ->
    electricBill = ElectricCalculator.ElectricBill.create({kwh: kwh})
    electricBill.getResult()
    @pushObject(electricBill)
  
  clearBills: ->
    @forEach(@removeObject, @)
})


@ElectricCalculator.CreateElectricBillView = SC.TemplateView.create(SC.TextFieldSupport, {
  insertNewline: ->
    value = @get('value')
    if (value)
      ElectricCalculator.ElectricBillListController.createElecticBill(value)
      @set('value', '')
})


@ElectricCalculator.ElectricBillListView = SC.TemplateCollectionView.create({
  contentBinding: 'ElectricCalculator.ElectricBillListController'
})

@ElectricCalculator.ClearBillsView = SC.TemplateView.create({
  mouseUp: ->
    ElectricCalculator.ElectricBillListController.clearBills()
})

SC.ready ->
    ElectricCalculator.mainPane = SC.TemplatePane.append({
      layerId: 'electric_calculator',
      templateName: 'electric_calculator'
    })
