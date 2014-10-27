###
 # @category webComponent
 # @name <super-navbar-button>
 # @component
 # @description
 # A button that will be displayed on the view navbar.
 # @attribute side="left" Used to set button position on navbar. Allowed values are "left" and "right".
 # @attribute location="moduleName#viewName" Simple way to use Supersonic UI navigation with your navbar button. If this is not set, any attached "click" callback will be used instead.
 # @usageHtml
 # <super-navbar-button location="moduleName#viewName" side="left">Title<super-navbar-button>
 # @exampleHtml
 # <super-navbar>
 #
 #   <!-- Button using Supersonic UI navigation -->
 #   <super-navbar-button location="moduleName#viewName">Title<super-navbar-button>
 #
 #   <!-- Button using Angular callback -->
 #   <super-navbar-button ng-click="myFunction()">Title<super-navbar-button>
 #
 #   <!-- Button on right side of navbar -->
 #   <super-navbar-button side="right">Title<super-navbar-button>
 #
 # </super-navbar>
###
observer = new MutationObserver (mutations) ->
  for mutation in mutations
    # If the mutation is for children in this element
    if mutation.type is "childList"
      mutation.target.updateOnNavbar mutation.target
    # If side changed
    if mutation.type is "attributes"
      console.log "mutation", mutation
      # Side
      if mutation.attributeName is "side"
        mutation.target._side = mutation.target.getAttribute("side")
        mutation.target.updatePositionOnNavbar()
        return
      # On-tap
      if mutation.attributeName is "on-tap"
        mutation.target._onTapOrig = mutation.target.getAttribute("on-tap")
        mutation.target._button.onTap = new Function(mutation.target._onTapOrig)
        mutation.target.updateOnNavbar()
        return

###
CREATE ELEMENT
###

SuperNavbarButtonPrototype = Object.create HTMLElement.prototype

###
DEFINE PROPERTIES
###

Object.defineProperty SuperNavbarButtonPrototype, "side",
  set: (side) ->
    this._side = side

  get: ->
    this._side

###
DEFINE METHODS
###

SuperNavbarButtonPrototype._callNavbar = (cmd) ->
  # Check for parent element existence
  if this.parentNode.nodeName == "SUPER-NAVBAR"
    cmd()
  else
    # Oops, we have a malformed DOM
    throw new Error "Component super-navbar-button must be an immediate child of super-navbar component"

SuperNavbarButtonPrototype.addToNavbar = ->
  this._callNavbar () =>
    @parentNode.addButton @_button, @_side

SuperNavbarButtonPrototype.updatePositionOnNavbar = ->
  this._callNavbar () =>
    @parentNode.changeButtonSide @_button, @_side

SuperNavbarButtonPrototype.removeFromNavbar = ->
  this._callNavbar () =>
    @parentNode.removeButton @_button

SuperNavbarButtonPrototype.updateOnNavbar = ->
  this._callNavbar () =>
    @parentNode.updateButton @_button

###
DEFINE CALLBACKS
###

# When a new element is detected in the DOM
SuperNavbarButtonPrototype.createdCallback = ->
  # Which things to observe
  observerConfiguration =
    childList: true
    attributes: true
    attributeFilter: ["style", "class", "side", "on-tap", "ng-click"]
  observer.observe this, observerConfiguration

  # Set side
  this._side = this.getAttribute("side")
  this._onTap = () =>
    this.click();

  if this.getAttribute("location") and this.getAttribute("location").match(/.+#.+/i)
    view = supersonic.ui.view this.getAttribute("location")
    view.start()
    this._onTap = () ->
      supersonic.ui.layer.push view

  # Create the button object
  this._button = new supersonic.ui.navigationButton
    title: this.textContent
    onTap: this._onTap

  # Initiate by adding to navbar
  this.addToNavbar()

  # Trigger an initial event
  #onContentChanged this

SuperNavbarButtonPrototype.detachedCallback = ->
  # Dispose of observer
  observer.disconnect()

###
REGISTER ELEMENT
###

document.registerElement "super-navbar-button",
  prototype: SuperNavbarButtonPrototype
