global = if window?
    window
  else
    require './mock/window'

steroids = if global.steroids?
    global.steroids
  else
    require './mock/steroids'

logger = require('./core/logger')(steroids, global)

module.exports = {
  logger
  debug: require('./core/debug')(steroids, logger)
  app: require('./core/app')(steroids, logger)
  media: require('./core/media')(steroids, logger)
  device: require('./core/device')(steroids, logger)
  ui: require('./core/ui')(steroids, logger, global)
  data: require('./core/data')(logger, global)
  internals:
    dust: require('dustjs-linkedin')
}

# Export to window as global if we're in the browser
if (window?)
  window.supersonic = module.exports
  window.supersonic.logger.autoFlush()
