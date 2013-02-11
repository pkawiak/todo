jQuery ->
  class AppView extends Backbone.View

    initialize: ->
      console.log("umm")

    events:
      'click': 'showPrompt'

    showPrompt: ->
      alert('lol')

  $(->
    view = new AppView({el: $('body')})
  )
