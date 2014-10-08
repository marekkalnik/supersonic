onContentChanged = (node)->
  node.setParentTitle node.textContent

observer = new MutationObserver (mutations)->
  for mutation in mutations
    # If the mutation is for children in this element
    if mutation.type is "childList"
      onContentChanged(mutation.target)

SuperNavigationBarTitlePrototype = Object.create HTMLElement.prototype

SuperNavigationBarTitlePrototype.setParentTitle = (title)->
  # Check for parent element existence
  if this.parentNode.nodeName == "SUPER-NAVIGATION-BAR"
    # Inform parent node of change - it has a setter that triggers a change event
    this.parentNode.title = title
  else
    # Oops, we have a malformed DOM
    throw new Error "No super-navigation-bar component as parent"

# When a new element is detected in the DOM
SuperNavigationBarTitlePrototype.createdCallback = ->
  # Which things to observe
  observerConfiguration =
    # Take text node inside into account
    childList: true

  observer.observe this, observerConfiguration

  # Trigger an initial event
  onContentChanged this

SuperNavigationBarTitlePrototype.detachedCallback = ->
  # Dispose of observer
  observer.disconnect()

document.registerElement "super-navigation-bar-title",
  prototype: SuperNavigationBarTitlePrototype
