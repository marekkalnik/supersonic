###
 # @namespace components
 # @name super-data
 # @component
 # @description
 # Use data from a Supersonic Data record in HTML DOM. The attributes of the object can be accessed via double-mustache notation, e.g. {{ attributeName }} will render object.attributeName. Fetches the record based on the view's current `id` parameter.
 # @exampleHtml
 # <!-- In index.html -->
 # <super-navigate view-id="show" params="{id: 1}"
 #
 # <!-- In show.html, shows Name and Description of Task item with id 1 -->
 # <super-data model="Task">
 #   <h2>{{ Name }}</h2>
 #   <p>{{ Description }}</p>
 # </super-data>
###
SuperDataPrototype = Object.create HTMLElement.prototype

# What is the difference between attached and created?
SuperDataPrototype.attachedCallback = ->
  @__visibility_listener = supersonic.ui.views.current.whenHidden =>
    @shadowRoot.innerHTML = ""

  model_name = @getAttribute("model")
  if model_name?
    Model = supersonic.data.model(model_name)
    @__data_listener = supersonic.ui.views.current.params.onValue (params) =>
      Model.find(params.id).then (object) =>
        compiled = supersonic.internals.dust.compileFn "#{@__template}"
        dust.render "super-data-template", object, (err, out)->
          @shadowRoot.innerHTML = out

SuperDataPrototype.createdCallback = ->
  @__template = @innerHTML
  @innerHTML = ""
  @createShadowRoot()

SuperDataPrototype.detachedCallback = ->
  @__data_listener() if @__data_listener?
  @__visibility_listener() if @__visibility_listener()

document.registerElement "super-data",
  prototype: SuperDataPrototype
