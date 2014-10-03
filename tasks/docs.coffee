dox = require "dox"
_ = require "lodash"
path = require "path"

module.exports = (grunt)->

  #grunt.loadNpmTasks "grunt-extend-config"

  grunt.extendConfig
    docs:
      javascript:
        expand: true
        cwd: ""
        src: ["src/**/*.coffee", "components/**/*.coffee"]
        dest: ""
        ext: ""
      component:
        expand: true
        cwd: "components/"
        src: "**/*.coffee"
        dest: "components/"
        ext: ""
        rename: (dest, matchedSrcPath) ->
          betterSrcPath = matchedSrcPath.split("/")[0]
          betterSrcPath = path.join betterSrcPath, "index"
          return path.join(dest, betterSrcPath)

  cleanUpDoxObject = (object)->
    parseDefineTag = (defineTag) ->
      nameArray = defineTag.name.split "="
      betterName = nameArray[0]
      defaultValue = nameArray[1] || null

      returns = if defineTag.typeName.match /^=>/
        defineTag.typeName = defineTag.typeName.replace "=>", ""
        true
      else
        false

      {
        name: betterName
        defaultValue: defaultValue
        description: defineTag.description
        type: defineTag.typeName
        returns: returns
        properties: []
      }

    parseAttributeTag = (attributeTag) ->
      nameArray = attributeTag.name.split "="
      betterName = nameArray[0]
      defaultValue = nameArray[1] || null

      {
        name: betterName
        defaultValue: defaultValue
        description: attributeTag.description
        children: []
      }

    getNamespaceFromTag = (betterTag)->
      namespace = betterTag.name.split(".")[0]
      findTarget = if betterTag.returns
        betterObject.returns
      else
        betterObject.params

      _.find findTarget, (tagName)->
        tagName.name is namespace

    betterObject =
      params: []
      returns: []
      attributes: []

    for tag in object.tags
      switch tag.type
        when "define"
          betterTag = parseDefineTag tag
          namespaceObject = getNamespaceFromTag betterTag

          if namespaceObject
            betterTag.name = betterTag.name.split(".")[1]
            namespaceObject.properties.push betterTag
          else
            if betterTag.returns
              betterObject.returns.push betterTag
            else
              betterObject.params.push betterTag
        when "attribute"
          betterTag = parseAttributeTag tag
          betterObject.attributes.push betterTag
        when "syntax"
          betterObject.syntax = tag.string
        when "type"
          betterObject.type = tag.typeString
        when "description"
          betterObject.description = tag.string
        when "returnsDescription"
          betterObject.returnsDescription = tag.string
        when "name"
          betterObject.name = tag.string
        when "usage"
          betterObject.usage = tag.string
        when "overview"
          betterObject.overview = true
        when "category"
          betterObject.category = tag.string
        when "function"
          betterObject.function = true
        when "signature"
          betterObject.signature = tag.string
        when "usageCoffeeScript"
          betterObject.usageCoffeeScript = tag.string
        when "exampleCoffeeScript"
          betterObject.exampleCoffeeScript = tag.string
        when "usageJavaScript"
          betterObject.usageJavaScript = tag.string
        when "exampleJavaScript"
          betterObject.exampleJavaScript = tag.string
        when "usageHtml"
          betterObject.usageHtml = tag.string
        when "exampleHtml"
          betterObject.exampleHtml = tag.string
        when "apiCall"
          betterObject.apiCall = tag.string
        when "class"
          betterObject.class = true

    betterObject

  cleanUpDoxArray = (doxArray)->
    cleanedUpArray = []

    for doxObject in doxArray
      cleanedUpArray.push cleanUpDoxObject(doxObject)

    cleanedUpArray

  writeArrayToJson = (cleanedUpArray, folderPath) ->
    writeMethodToJson = (fileName, method) ->
      fileDestination = path.join folderPath, fileName
      prettyJSON = JSON.stringify method, undefined, 2
      grunt.file.write fileDestination, prettyJSON

    for method in cleanedUpArray
      methodName = if method.overview
        "overview.json"
      else
        "#{method.name}.json"

      writeMethodToJson methodName, method

  getStringsFromFile = (file) ->
    filePath = file.src[0]
    jsonDestFolderPath = "docs/_data/#{file.dest}/"
    {filePath, jsonDestFolderPath}

  grunt.registerMultiTask "docs", "Get comments from src/*. to docs/_data/*.json", ->
    @files.forEach (file) =>
      { filePath
        jsonDestFolderPath
        } = getStringsFromFile(file)

      coffee = grunt.file.read filePath

      doxArray = dox.parseCommentsCoffee(coffee)
      unless doxArray[0].tags.length > 0
        return

      cleanedUpArray = cleanUpDoxArray(doxArray)

      writeArrayToJson(cleanedUpArray, jsonDestFolderPath)
