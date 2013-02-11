jQuery ->
  class Todo extends Backbone.Model

    initialize: ->
      @urlRoot = "/todo"

    defaults:
      title: "Todo"
      description: "No description"
      done: false

  class TodoView extends Backbone.View

    tagName: "li"
    template: $("#todo_view_template").html()

    events:
      "click :checkbox": "doneChanged"

    render: ->
      @$el.html(_.template(@template, @model.attributes))

    initialize: (options) ->
      @todos = options.todos
      @listenTo(@model, "change", @render)
      @render()

    doneChanged: (e) ->
      @todos.remove @model
      @model.set(done: e.currentTarget.checked)


  class Todos extends Backbone.Collection
    initialize: ->
      @model = Todo
      @url = '/todos'
    done: ->
      @filter((todo)-> todo.get("done"))

  class TodosView extends Backbone.View
    initialize: ->
      @views = {}
      @listenTo(@model, "change", @render)
      @listenTo(@model, "reset", @onReset)
      @listenTo(@model, "add", @addView)
      @listenTo(@model, "remove", @removeView)
      @counter = @$el.children("span")
      @list = @$el.children("ul")
      @model.each _.bind(@addView, @)
      @render()
    onReset: ->
      @model.each _.bind(@addView, @)
    render: ->
      @counter.html @model.size()
    addView: (newModel) ->
      toAdd = new TodoView({model: newModel, todos: @model})
      @views[newModel.cid] = toAdd
      @list.append toAdd.el
      @render()
    removeView: (toRemove) ->
      @views[toRemove.cid].remove()
      delete @views[toRemove.cid]
      @render()

  class AddTodoView extends Backbone.View
    template: $("#add_todo_view_template").html()
    events:
      "click :button": "addTodo",
      "change #title": "updateTitle",
      "change #description": "updateDescription"
    initialize: (options) ->
      @todos = options.todos
      @listenTo(@model, "change", @render)
      @render()
    render: ->
      @$el.html(_.template(@template, @model.attributes))
    addTodo: ->
      toAdd = @model.clone()
      toAdd.save()
      @todos.add toAdd
    updateTitle: (e) ->
      @model.set({title: e.currentTarget.value})
    updateDescription: (e) ->
      @model.set({description: e.currentTarget.value})

  $ ->
    todos = new Todos
    todosView = new TodosView(el: $('#todos'), model: todos)
    addTodoView = new AddTodoView(el: $('#addTodo'), model: new Todo, todos: todos)
    todos.fetch()