(function() {
  var afterNode, element, insertAfter;

  insertAfter = function(referenceNode, node) {
    return referenceNode.parentNode.insertBefore(node, referenceNode.nextSibling);
  };

  element = function(elementName) {
    return function(attrs) {
      return (function(e) {
        var key, value;
        for (key in attrs) {
          value = attrs[key];
          e[key] = value;
        }
        return e;
      })(document.createElement(elementName));
    };
  };

  afterNode = function(focusElement) {
    return {
      insertNext: function(another) {
        console.log("inserting", another, "after", focusElement);
        insertAfter(focusElement, another);
        return afterNode(another);
      }
    };
  };

  afterNode(document.getElementsByTagName("script")[0]).insertNext(element("script")({
    src: "http://localhost/cordova.js",
    async: false
  })).insertNext(element("script")({
    src: "/components/steroids-js/steroids.js",
    async: false
  })).insertNext(element("script")({
    src: "/components/angular/angular.js",
    async: false
  })).insertNext(element("script")({
    src: "/components/supersonic/dist/supersonic.js",
    async: false
  })).insertNext(element("script")({
    src: "/components/platform/platform.js",
    async: false
  })).insertNext(element("link")({
    rel: "import",
    href: "/components/supersonic/dist/components/import.html"
  }));

}).call(this);
