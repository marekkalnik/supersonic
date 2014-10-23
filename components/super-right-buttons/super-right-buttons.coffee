onContentChanged = (node)->
  children = node.children

  rightButtons = []

  for child in children
    if child.nodeName == "SUPER-NAVBAR-BUTTON"
      button = {}
      button.title = child.textContent
      rightButtons.push button

  node.setParentButtons rightButtons

observer = new MutationObserver (mutations)->
  for mutation in mutations
    # If the mutation is for children in this element
    if mutation.type is "childList"
      onContentChanged(mutation.target)

SuperRigthButtonsPrototype = Object.create HTMLElement.prototype

SuperRigthButtonsPrototype.setParentButtons = (rightButtons)->
  # Check for parent element existence
  if this.parentNode.nodeName == "SUPER-NAVBAR"
    # Inform parent node of change - it has a setter that triggers a change event
    this.parentNode.rightButtons = rightButtons
  else
    # Oops, we have a malformed DOM
    throw new Error "No super-navbar component as parent"

# When a new element is detected in the DOM
SuperRigthButtonsPrototype.createdCallback = ->
  # Which things to observe
  observerConfiguration =
    # Take text node inside into account
    childList: true

  observer.observe this, observerConfiguration

  # Trigger an initial event
  onContentChanged this

SuperRigthButtonsPrototype.detachedCallback = ->
  # Dispose of observer
  observer.disconnect()

document.registerElement "super-right-buttons",
  prototype: SuperRigthButtonsPrototype
