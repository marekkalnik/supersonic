before ->
  importsLoaded

fireAfterModalDidShow = (done) ->
  showListener = steroids.modal.on "didshow", ->
    steroids.modal.off "didshow", showListener
    done()

fireAfterModalDidHide = (done) ->
  hideListener = steroids.modal.on "didclose", ->
    steroids.modal.off "didclose", hideListener
    done()

fireAfterModalDidHideAndShow = (done) ->
  fireAfterModalDidShow ->
    fireAfterModalDidHide ->
      done()

describe "<super-navbar>", ->
  @timeout 4000

  it "should show modal by clicking on element with route", (done) ->
    fireAfterModalDidHideAndShow done
    clickElement "super-show-modal-route"

  it "should show modal with an URL", (done) ->
    fireAfterModalDidHideAndShow done
    clickElement "super-show-modal-url"

  it "should show modal after changing element's location attribute", (done) ->
    fireAfterModalDidHideAndShow done
    elem = document.getElementById "super-show-modal-change-location"
    elem.setAttribute "location", "web-components#super-hide-modal"
    elem.click()

  it "should navigate with a custom touchstart action", (done) ->
    fireAfterModalDidHideAndShow done
    elem = document.getElementById "super-show-modal-touchstart"
    fireTouchEvent elem, "touchstart"