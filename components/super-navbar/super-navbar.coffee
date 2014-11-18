###
 # @namespace components
 # @name super-navbar
 # @component
 # @description
 # Displays a view-specific native navigation bar. To set a title text and buttons for the navigation bar, use the `<super-navbar-title>` and `<super-navbar-button>` components.
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
observer = new MutationObserver (mutations) ->
  for mutation in mutations
    # Check attributes
    if mutation.type is "attributes"

      # Class changed
      if mutation.attributeName is "class"
        mutation.target.class = mutation.target.getAttribute("class")
      # Style changed
      if mutation.attributeName is "style"
        mutation.target.style = mutation.target.getAttribute("style")
      # id changed
      if mutation.attributeName is "id"
        mutation.target.id = mutation.target.getAttribute("id")

      if mutation.attributeName is "title"
        mutation.target.onTitleChanged()

      if mutation.target.isHidden()
        mutation.target.hide()
      else
        mutation.target.show()

SuperNavbarPrototype = Object.create HTMLElement.prototype

lazyUpdate = null

Object.defineProperty SuperNavbarPrototype, "title",
  set: (title) ->
    @_title = title
    @onTitleChanged()

  get: ->
    @_title

Object.defineProperty SuperNavbarPrototype, "buttons",
  set: (buttons) ->
    @setButtons buttons

  get: ->
    {
      left: @_leftButtons
      right: @_rightButtons
    }

Object.defineProperty SuperNavbarPrototype, "class",
  set: (className) ->
    className = "" if not className
    @_class = className
    @onClassNameChanged()

  get: ->
    @_class

Object.defineProperty SuperNavbarPrototype, "style",
  set: (inlineStyle) ->
    inlineStyle = "" if not inlineStyle
    @_style = inlineStyle
    @onInlineStyleChanged()

  get: ->
    @_style

Object.defineProperty SuperNavbarPrototype, "id",
  set: (styleId) ->
    styleId = "" if not styleId
    @_styleId = styleId
    @onStyleIdChanged()

  get: ->
    @_styleId

# Methods for navbar visibility

SuperNavbarPrototype.isHidden = ->
  style = window.getComputedStyle this
  return true if style.display is "none" or style.visibility is "hidden"

SuperNavbarPrototype.show = ->
  supersonic.ui.navigationBar.show()

SuperNavbarPrototype.hide = ->
  supersonic.ui.navigationBar.hide()

# Update navbar
SuperNavbarPrototype.updateNavBar = ->
  options = {}
  # Set base for options
  options.title = @getTitleForUpdate()
  options.buttons =
    left: @_leftButtons
    right: @_rightButtons
  # Update UI

  if lazyUpdate?
    clearTimeout lazyUpdate
    lazyUpdate = null

  lazyUpdate = setTimeout ->
    supersonic.ui.navigationBar.update options
  , 20

# Navbar title

SuperNavbarPrototype.getTitleForUpdate = ->
  if @title? && @title.length is 0
    @title = " " # hack for not being able to clear the title with empty string
  return @title

SuperNavbarPrototype.updateNavBarTitle = ->
  @updateNavBar()

# Methods for navbar buttons

SuperNavbarPrototype.addButton = (button, side="left") ->
  # Figure out the side where to add button
  if side is "right" then @_rightButtons.push button
  else @_leftButtons.push button
  # Update buttons on UI
  @onButtonsChanged()

SuperNavbarPrototype.updateButton = (button) ->
  # First check the left side for the button reference
  for candidate, idx in @_leftButtons when candidate is button
    @_leftButtons[idx] = button
    @onButtonsChanged()
    return
  # Check right side for the reference
  for candidate, idx in @_rightButtons when candidate is button
    @_rightButtons[idx] = button
    @onButtonsChanged()
    return

SuperNavbarPrototype.changeButtonSide = (button, side="left") ->
  @_removeButtonSilently button
  @addButton button, side

SuperNavbarPrototype.removeButton = (button) ->
  @_removeButtonSilently button
  @onButtonsChanged()

SuperNavbarPrototype._removeButtonSilently = (button) ->
  # First check the left side for the button reference
  for candidate, idx in @_leftButtons when candidate is button
    @_leftButtons.splice idx, 1
    return
  # Check right side for the reference
  for candidate, idx in @_rightButtons when candidate is button
    @_rightButtons.splice idx, 1
    return

# Batch set function
SuperNavbarPrototype.setButtons = (buttons) ->
  @_leftButtons = buttons.left
  @_rightButtons = buttons.right
  @onButtonsChanged()

SuperNavbarPrototype._updateButtons = ->
  @updateNavBar()


SuperNavbarPrototype.onTitleChanged = ->
  @updateNavBarTitle() unless @isHidden()

SuperNavbarPrototype.onButtonsChanged = ->
  @_updateButtons() unless @isHidden()

SuperNavbarPrototype.onClassNameChanged = ->
  supersonic.ui.navigationBar.setClass(@_class) unless @isHidden()

SuperNavbarPrototype.onInlineStyleChanged = ->
  supersonic.ui.navigationBar.setStyle(@_style) unless @isHidden()

SuperNavbarPrototype.onStyleIdChanged = ->
  supersonic.ui.navigationBar.setStyleId(@_styleId) unless @isHidden()

# What is the difference between attached and created?
SuperNavbarPrototype.attachedCallback = ->
  # Initiate button arrays
  @_leftButtons = []
  @_rightButtons = []

  # Back button settings
  @_backButtonAllowed = true
  @_backButton = undefined

  # Style
  @class = @getAttribute("class")
  @id = @getAttribute("id")
  @style = @getAttribute("style")

  # Observe attributes style and class
  observerConfiguration =
    attributes: true
    attributeFilter: ["style", "class", "id", "title"]

  observer.observe this, observerConfiguration

  # ensure visible (for androids sake)
  @_onViewVisible = =>
    if @isHidden()
      @hide()
    else
      @updateNavBar()
      @show()

  document.addEventListener "visibilitychange", @_onViewVisible, false

SuperNavbarPrototype.createdCallback = ->
  #console.log "Navigation bar createCallback"

SuperNavbarPrototype.detachedCallback = ->
  #console.log "Navigation bar detachedCallback"
  observer.disconnect()
  # Hide the navbar when this node leaves the DOM
  supersonic.ui.navigationBar.hide()
  document.removeEventListener "visibilitychange", @_onViewVisible, false

document.registerElement "super-navbar",
  prototype: SuperNavbarPrototype
