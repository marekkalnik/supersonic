
insertAfter = (referenceNode, node) ->
  referenceNode.parentNode.insertBefore node, referenceNode.nextSibling

element = (elementName) -> (attrs) ->
  do (e = document.createElement elementName) ->
    for key, value of attrs
      e[key] = value
    e

afterNode = (focusElement) ->
  insertNext: (another) ->
    console.log "inserting", another, "after", focusElement
    insertAfter focusElement, another
    afterNode another

afterNode(document.getElementsByTagName("script")[0])
  .insertNext(element("script") {
    src: "http://localhost/cordova.js"
    async: false
  })
  .insertNext(element("script") {
    src: "/components/steroids-js/steroids.js"
    async: false
  })
  .insertNext(element("script") {
    src: "/components/angular/angular.js"
    async: false
  })
  .insertNext(element("script") {
    src: "/components/supersonic/dist/supersonic.js"
    async: false
  })
  .insertNext(element("script") {
    src: "/components/platform/platform.js"
    async: false
  })
  .insertNext(element("link") {
    rel: "import"
    href: "/components/supersonic/dist/components/import.html"
  })
