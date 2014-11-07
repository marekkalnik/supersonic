###
 # @namespace components
 # @name super-tabs
 # @component
 # @description
 # Container for super-tab nodes. All super-tabs must be placed inside this container node.
 # @usageHtml
 # <super-tabs><super-tab>Hello</super-tab></super-tabs>

 # @exampleHtml
 # <super-tabs>
 # </super-tabs>
###
observer = new MutationObserver (mutations) ->
  for mutation in mutations
    # If content changed
    if mutation.type is "childList"
      console.log "Mutation to childList:", mutation
    # If attribute changed
    if mutation.type is "attributes"
      console.log "Mutation to attributes:", mutation
      if mutation.attributeName in ["class", "style"]
        # for example class changes effect on css so:
        mutation.target.onStylesChanged()
    if mutation.type is "style"
      console.log "Mutation to style:", mutation
      mutation.target.onStylesChanged()

SuperTabsPrototype = Object.create HTMLElement.prototype


SuperTabsPrototype.isHidden = ->
  style = window.getComputedStyle @
  return true if style.display is "none" or style.visibility is "hidden"

SuperTabsPrototype._hide = ->
  supersonic.ui.tabs.hide()

SuperTabsPrototype._show = ->
  supersonic.ui.tabs.show()

SuperTabsPrototype.onStylesChanged = ->
  if @isHidden()
    @_hide()
  else
    @_show()

# When a new element is detected in the DOM
SuperTabsPrototype.createdCallback = ->
  # Which things to observe
  observerConfiguration =
    childList: true
    attributes: true
    attributeFilter: ["style", "class"]
  observer.observe this, observerConfiguration

SuperTabsPrototype.attachedCallback = ->
  @onStylesChanged()


SuperTabsPrototype.detachedCallback = ->
  # Dispose of observer
  observer.disconnect()

document.registerElement "super-tabs",
  prototype: SuperTabsPrototype
