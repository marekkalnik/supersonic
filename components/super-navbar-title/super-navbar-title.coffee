###
 # @category webComponent
 # @name <super-navbar-title>
 # @component
 # @description
 # Component used to add title on app navigation bar. Must be a child of <super-navbar>.
 # @usageHtml
 # <super-navbar-title>This is the title</super-navbar-title>
 # @exampleHtml
 # <!-- Full example including the navbar itself -->
 # <super-navbar>
 #   <super-navbar-title>This is the title</super-navbar-title>
 # </super-navbar>
 #
 # <!-- Full example using ng-bind for title value -->
 # <super-navbar>
 #   <super-navbar-title ng-bind="titleFromScope"></super-navbar-title>
 # </super-navbar>
###
onContentChanged = (node)->
  node.setParentTitle node.textContent

observer = new MutationObserver (mutations)->
  for mutation in mutations
    # If the mutation is for children in this element
    if mutation.type is "childList"
      onContentChanged(mutation.target)

###
CREATE ELEMENT
###

SuperNavbarTitlePrototype = Object.create HTMLElement.prototype

###
DEFINE METHODS
###

SuperNavbarTitlePrototype.setParentTitle = (title)->
  # Check for parent element existence
  if this.parentNode.nodeName == "SUPER-NAVBAR"
    # Inform parent node of change - it has a setter that triggers a change event
    this.parentNode.title = title
  else
    # Oops, we have a malformed DOM
    throw new Error "Component super-navbar-title must be an immediate child of super-navbar component"

###
DEFINE CALLBACKS
###

# When a new element is detected in the DOM
SuperNavbarTitlePrototype.createdCallback = ->
  # Which things to observe
  observerConfiguration =
    # Take text node inside into account
    childList: true

  observer.observe this, observerConfiguration

  # Trigger an initial event
  onContentChanged this

SuperNavbarTitlePrototype.detachedCallback = ->
  # Dispose of observer
  observer.disconnect()

###
REGISTER ELEMENT
###

document.registerElement "super-navbar-title",
  prototype: SuperNavbarTitlePrototype
