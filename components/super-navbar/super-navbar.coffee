###
 # @category webComponent
 # @name <super-navbar>
 # @component
 # @description
 # Component used to display a view-specific native navbar. Navbar can contain super-navbar-title and super-navbar-button components.
 # @usageHtml
 # <super-navbar></super-navbar>
 # @exampleHtml
 # <!-- Navbar with a title -->
 # <super-navbar>
 #
 #   <super-navbar-title>I'm native!</super-navbar-title>
 #
 # </super-navbar>
###
onStyleChanged = (node)->
  if node.isHidden()
    node.hide()
  else
    node.show()

observer = new MutationObserver (mutations)->
  for mutation in mutations when mutation.type is "attributes" or mutation.attributeName in ["style", "class"]
    onStyleChanged(mutation.target)

###
CREATE ELEMENT
###

SuperNavbarPrototype = Object.create HTMLElement.prototype

###
DEFINE PROPERTIES
###

Object.defineProperty SuperNavbarPrototype, "title",
  set: (title)->
    this._title = title
    this.onTitleChanged()

  get: ->
    this._title

Object.defineProperty SuperNavbarPrototype, "buttons",
  set: (buttons)->
    this.setButtons buttons

  get: ->
    {
      left: this._leftButtons
      right: this._rightButtons
    }

###
DEFINE METHODS
###

# Methods for navbar visibility

SuperNavbarPrototype.isHidden = ->
  style = window.getComputedStyle this
  return true if style.display is "none" or style.visibility is "hidden"

SuperNavbarPrototype.show = ->
  supersonic.ui.navigationBar.show()

SuperNavbarPrototype.hide = ->
  steroids.view.navigationBar.hide()

# Navbar title

SuperNavbarPrototype.updateNavBarTitle = ->
  if this.title? && this.title.length is 0
    this.title = " " # hack for not being able to clear the title with empty string
  options =
    title: this.title
  supersonic.ui.navigationBar.update(options)

# Methods for navbar buttons

SuperNavbarPrototype.addButton = (button, side="left") ->
  # Figure out the side where to add button
  if side is "right" then this._rightButtons.push button
  else this._leftButtons.push button
  # Update buttons on UI
  this._updateButtons()

SuperNavbarPrototype.updateButton = (button) ->
  # First check the left side for the button reference
  for candidate, idx in this._leftButtons when candidate is button
    this._leftButtons[idx] = button
    this._updateButtons()
    return
  # Check right side for the reference
  for candidate, idx in this._rightButtons when candidate is button
    this._rightButtons[idx] = button
    this._updateButtons()
    return

SuperNavbarPrototype.changeButtonSide = (button, side="left") ->
  this._removeButtonSilently button
  this.addButton button, side

SuperNavbarPrototype.removeButton = (button) ->
  this._removeButtonSilently button
  this._updateButtons()

SuperNavbarPrototype._removeButtonSilently = (button) ->
  # First check the left side for the button reference
  for candidate, idx in this._leftButtons when candidate is button
    this._leftButtons.splice idx, 1
    return
  # Check right side for the reference
  for candidate, idx in this._rightButtons when candidate is button
    this._rightButtons.splice idx, 1
    return

# Batch set function
SuperNavbarPrototype.setButtons = (buttons) ->
  this._leftButtons = buttons.left
  this._rightButtons = buttons.right
  this._updateButtons()

SuperNavbarPrototype._updateButtons = ->
  return if this.isHidden()
  # Set base for options
  options =
    buttons:
      left: this._leftButtons
      right: this._rightButtons
  # Update UI
  supersonic.ui.navigationBar.update options

###
DEFINE CALLBACKS
###

SuperNavbarPrototype.onTitleChanged = ->
  this.updateNavBarTitle() unless this.isHidden()

# What is the difference between attached and created?
SuperNavbarPrototype.attachedCallback = ->
  # Initiate button arrays
  this._leftButtons = []
  this._rightButtons = []

  # Back button settings
  this._backButtonAllowed = true
  this._backButton = undefined

  # Observe attributes style and class
  observerConfiguration =
    attributes: true
    attributeFilter: ["style", "class"]

  observer.observe this, observerConfiguration

  onStyleChanged this

SuperNavbarPrototype.createdCallback = ->
  #console.log "Navigation bar createCallback"

SuperNavbarPrototype.detachedCallback = ->
  #console.log "Navigation bar detachedCallback"
  observer.disconnect()
  # Hide the navbar when this node leaves the DOM
  steroids.view.navigationBar.hide()

###
REGISTER ELEMENT
###

document.registerElement "super-navbar",
  prototype: SuperNavbarPrototype
