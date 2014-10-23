onStyleChanged = (node)->
  if node.isHidden()
    node.hideNavBar()
  else
    node.showNavBar()

observer = new MutationObserver (mutations)->
  for mutation in mutations when mutation.type is "attributes" or mutation.attributeName in ["style", "class"]
    onStyleChanged(mutation.target)

SuperNavigationBarPrototype = Object.create HTMLElement.prototype

Object.defineProperty SuperNavigationBarPrototype, "title",
  set: (title)->
    this._title = title
    this.onTitleChanged()

  get: ->
    this._title

Object.defineProperty SuperNavigationBarPrototype, "leftButtons",
  set: (leftButtons)->
    this._leftButtons = leftButtons
    this.onLeftButtonsChanged()

  get: ->
    this._leftButtons

Object.defineProperty SuperNavigationBarPrototype, "rightButtons",
  set: (rightButtons)->
    this._rightButtons = rightButtons
    this.onRightButtonsChanged()

  get: ->
    this._rightButtons

SuperNavigationBarPrototype.createSupersonicButtons = (buttons) ->
  supersonicButtons = []
  for button in buttons
    options =
      title: button.title
    supersonicButton = new supersonic.ui.navigationButton(options)
    supersonicButtons.push(supersonicButton)
  supersonicButtons

SuperNavigationBarPrototype.updateNavBarTitle = ->
  if this.title? && this.title.length is 0
    this.title = " " # hack for not being able to clear the title with empty string
  options =
    title: this.title
  supersonic.ui.navigationBar.update(options)

SuperNavigationBarPrototype.updateNavBarLeftButtons = ->
  leftButtons = this.createSupersonicButtons(this.leftButtons)
  options =
    buttons:
      left: leftButtons
  supersonic.ui.navigationBar.update(options)

SuperNavigationBarPrototype.updateNavBarRightButtons = ->
  rightButtons = this.createSupersonicButtons(this.rightButtons)
  options =
    buttons:
      right: rightButtons
  supersonic.ui.navigationBar.update(options)

SuperNavigationBarPrototype.isHidden = ->
  style = window.getComputedStyle this
  return true if style.display is "none" or style.visibility is "hidden"

SuperNavigationBarPrototype.showNavBar = ->
  supersonic.ui.navigationBar.show()

SuperNavigationBarPrototype.hideNavBar = ->
  steroids.view.navigationBar.hide()

SuperNavigationBarPrototype.onTitleChanged = ->
  this.updateNavBarTitle() unless this.isHidden()

SuperNavigationBarPrototype.onLeftButtonsChanged = ->
  this.updateNavBarLeftButtons() unless this.isHidden()

SuperNavigationBarPrototype.onRightButtonsChanged = ->
  this.updateNavBarRightButtons() unless this.isHidden()

# What is the difference between attached and created?
SuperNavigationBarPrototype.attachedCallback = ->
  # Observe attributes style and class
  observerConfiguration =
    attributes: true
    attributeFilter: ["style", "class"]

  observer.observe this, observerConfiguration

  onStyleChanged this

SuperNavigationBarPrototype.createdCallback = ->
  #console.log "Navigation bar createCallback"

SuperNavigationBarPrototype.detachedCallback = ->
  #console.log "Navigation bar detachedCallback"
  observer.disconnect()
  # Hide the navbar when this node leaves the DOM
  steroids.view.navigationBar.hide()

document.registerElement "super-navbar",
  prototype: SuperNavigationBarPrototype
