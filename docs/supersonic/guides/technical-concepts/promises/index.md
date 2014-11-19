---
layout: docs_overview
title: Supersonic Documentation
header_title: Supersonic App Logic and Structure
header_sub_title: Learn how Supersonic utilizes promises
parent_id: supersonic
section_id: promises
---
<section class="docs-section" id="promises">
# Promises

Since WebViews are an asynchronous platform, the various events happening in the app such as button clicks, data arriving from the backend etc, are handled by callback functions. Quite often callbacks have to be deeply nested, which often result as a 'callback hell', that makes it hard to follow application logic and troublesome to implement error handling.

_Promise_ is a proxy object for an event that is not necessary yet happened. A success and failure callback functions can be given to a promise, and once the promise is _resolved_ (i.e. the 'promised' event happens successfully) or _rejected_ (the 'promised' event fails), the corresponding callback gets called.

Most of the Supersonic core API's return a promise. Callback functions can be added to a promise with the method `then`. The first parameter to `then` is a success callback that gets called if promise is resolved, the optinonal second parameter is called if promise is rejected.

In a simple scenario, use of an API that returns promise does not differ much from usage of a API call that takes a callback as parameter. In the following example Supersonic [dialog][dialog-api] is opened. Dialog returns a promise, that resolves with the user inputed value:

```js
myController = ($scope, supersonic) ->
  labels =
    buttonLabels: ["Yes", "No"]

  supersonic.ui.dialog.confirm("Like Angular?", labels)
  .then (answer) ->
    if ( answer==0 )
      $scope.answer = "Yes"
    else
      $scope.answer = "No"
```

In the following we have a more complicated example, where the program logic calls in succession four Supersonic functions (two calls to dialog and two to [load data records from backend][data-model-api]), each of which return a promise.

Instead of nesting callbacks, the use of promises makes it possible to _chain_ the callbacks so that their execution appears to be sequential. If any of the chained promises is rejected (i.e. some of the events is unsuccessful), the error is propagated to the error handler that is registered to the last promise:

```js
myController = ($scope, supersonic) ->
  Task = supersonic.data.model('task')
  User = supersonic.data.model('user')

  supersonic.ui.dialog.prompt("give a task number")
  .then
    (input) -> Task.find(parseInt(input))
  .then
    (task) -> User.find(task.assignee_id)
  .then
    (user) -> supersonic.ui.dialog.alert "Task was assigned to #{user.name}"
  .then
    () -> supersonic.logger.log "completed",
    (error) -> supersonic.logger.error "something wrong..."

```

With APIs using normal callbacks this code would have lead to extremely complicated structure with nested callbacks and error handling code that would have to been replicated to each of the callback functions.

## Learn more about promises

 - [https://docs.angularjs.org/api/ng/service/$q](https://docs.angularjs.org/api/ng/service/$q)
 - [https://github.com/kriskowal/q](https://github.com/kriskowal/q)

</section>

[data-model-api]: /supersonic/api-reference/stable/supersonic/data/model/model-class/
[dialog-api]: /supersonic/api-reference/stable/supersonic/ui/dialog/confirm