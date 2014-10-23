onContentChanged = (node)->
  children = node.children

  leftButtons = []

  for child in children
    if child.nodeName == "SUPER-NAVBAR-BUTTON"
      button = {}
      button.title = child.textContent
      leftButtons.push button

  node.setParentButtons leftButtons

observer = new MutationObserver (mutations)->
  for mutation in mutations
    # If the mutation is for children in this element
    if mutation.type is "childList"
      onContentChanged(mutation.target)

SuperLeftButtonsPrototype = Object.create HTMLElement.prototype

SuperLeftButtonsPrototype.setParentButtons = (leftButtons)->
  # Check for parent element existence
  if this.parentNode.nodeName == "SUPER-NAVBAR"
    # Inform parent node of change - it has a setter that triggers a change event
    this.parentNode.leftButtons = leftButtons
  else
    # Oops, we have a malformed DOM
    throw new Error "No super-navbar component as parent"

# When a new element is detected in the DOM
SuperLeftButtonsPrototype.createdCallback = ->
  # Which things to observe
  observerConfiguration =
    # Take text node inside into account
    childList: true

  observer.observe this, observerConfiguration

  # Trigger an initial event
  onContentChanged this

SuperLeftButtonsPrototype.detachedCallback = ->
  # Dispose of observer
  observer.disconnect()

document.registerElement "super-left-buttons",
  prototype: SuperLeftButtonsPrototype
