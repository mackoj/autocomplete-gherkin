packagesToTest =
  Gherkin:
    name: 'language-gherkin'
    file: 'test.feature'

describe "Gherkin autocompletions", ->
  [editor, provider] = []

  getCompletions = ->
    cursor = editor.getLastCursor()
    start = cursor.getBeginningOfCurrentWordBufferPosition()
    end = cursor.getBufferPosition()
    prefix = editor.getTextInRange([start, end])
    request =
      editor: editor
      bufferPosition: end
      scopeDescriptor: cursor.getScopeDescriptor()
      prefix: prefix
    provider.getSuggestions(request)

  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage('autocomplete-gherkin')

    runs ->
      provider = atom.packages.getActivePackage('autocomplete-gherkin').mainModule.getProvider()

    waitsFor -> Object.keys(provider.properties).length > 0
