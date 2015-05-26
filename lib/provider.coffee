fs = require 'fs'
path = require 'path'

# l'autocomplete itself ce fera ici
# comparer avec le fonctionnement du package https://github.com/atom/autocomplete-css
 
propertyNameWithColonPattern = /^\s*(\S+)\s*:/
propertyNamePrefixPattern = /[a-zA-Z]+[-a-zA-Z]*$/

module.exports =
  selector: '.text.gherkin.feature*'
  inclusionPriority: 1
  excludeLowerPriority: true

  getSuggestions: (request) ->
    console.log("getSuggestions")
    console.log(request)
    console.log("---")
    if @isCompletingValue(request)
      @getPropertyValueCompletions(request)
    else if @isCompletingName(request)
      @getPropertyNameCompletions(request)
    else
      []

  loadStepsDescriptionJSON: (stepsDescriptionJSONLocalPath) ->
    @properties = {}
    fs.readFile path.resolve(stepsDescriptionJSONLocalPath), (error, content) =>
      @properties = JSON.parse(content) unless error?
      return

  isCompletingValue: ({scopeDescriptor}) ->
    scopes = scopeDescriptor.getScopesArray()
    console.log("isCompletingValue")
    console.log(scopes)
    console.log(scopes.indexOf('source.feature'))
    console.log(scopes.indexOf('entity.name.function.decorator.gherkin'))
    console.log("---")
    scopes.indexOf('source.feature') is 0 and scopes.indexOf('entity.name.function.decorator.gherkin') is 1

  isCompletingName: ({scopeDescriptor})->
    scopes = scopeDescriptor.getScopesArray()
    console.log("isCompletingName")
    console.log(scopes)
    console.log(scopes.indexOf('support.class.gherkin'))
    console.log(scopes.indexOf('keyword.gherkin'))
    console.log("---")
    scopes.indexOf('support.class.gherkin') isnt -1 or
    scopes.indexOf('keyword.gherkin') isnt -1

  isPropertyValuePrefix: (prefix) ->
    console.log("isPropertyValuePrefix")
    console.log(prefix)
    console.log("---")
    prefix = prefix.trim()
    prefix.length > 0 and prefix isnt ':'

  getPreviousPropertyName: (bufferPosition, editor) ->
    console.log("getPreviousPropertyName")
    console.log(bufferPosition)
    console.log(editor)
    console.log("---")
    {row} = bufferPosition
    while row >= 0
      line = editor.lineTextForBufferRow(row)
      propertyName = propertyNameWithColonPattern.exec(line)?[1]
      return propertyName if propertyName
      row--
    return

  getPropertyValueCompletions: ({bufferPosition, editor, prefix}) ->
    console.log("getPropertyValueCompletions")
    console.log(bufferPosition)
    console.log(editor)
    console.log(prefix)
    console.log("---")
    property = @getPreviousPropertyName(bufferPosition, editor)
    values = @properties[property]?.values
    return [] unless values?

    completions = []
    if @isPropertyValuePrefix(prefix)
      lowerCasePrefix = prefix.toLowerCase()
      for value in values when value.indexOf(lowerCasePrefix) is 0
        completions.push({text: value, replacementPrefix: prefix})
    else
      for value in values
        completions.push({text: value, replacementPrefix: ''})
    completions

  getPropertyNamePrefix: (bufferPosition, editor) ->
    console.log("getPropertyNamePrefix")
    console.log(bufferPosition)
    console.log(editor)
    console.log("---")
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])
    propertyNamePrefixPattern.exec(line)?[0]

  getPropertyNameSuffix: (bufferPosition, editor) ->
    console.log("getPropertyNameSuffix")
    console.log(bufferPosition)
    console.log(editor)
    console.log("---")
    line = editor.lineTextForBufferRow(bufferPosition.row)
    colonIndex = line.indexOf(':')
    if colonIndex >= bufferPosition.column
      ''
    else
      ': '

  getPropertyNameCompletions: ({bufferPosition, editor}) ->
    console.log("getPropertyNameCompletions")
    console.log(bufferPosition)
    console.log(editor)
    console.log("---")
    suffix = @getPropertyNameSuffix(bufferPosition, editor)
    prefix = @getPropertyNamePrefix(bufferPosition, editor)
    completions = []
    if prefix
      lowerCasePrefix = prefix.toLowerCase()
      for property, values of @properties when property.indexOf(lowerCasePrefix) is 0
        completions.push({text: property + suffix, replacementPrefix: prefix})
    else
      for property, values of @properties
        completions.push({text: property + suffix, replacementPrefix: ''})
    completions
