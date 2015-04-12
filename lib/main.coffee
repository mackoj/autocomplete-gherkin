fs = require 'fs'
path = require 'path'

provider = require './provider'

module.exports =
  activate: -> provider.loadStepsDescriptionJSON(getStepsDescriptionJSONLocalPath())
  getProvider: -> provider

getDirectories = (srcpath) ->
  fs.readdirSync(srcpath).filter (file) ->
    fs.statSync(path.join(srcpath, file)).isDirectory()


findFeatureFolder: (projectFolder) ->
      console.log("findFeatureFolder")
      console.log(projectFolder)
      console.log("---")
      dirs = getDirectories(projectFolder)
      if dirs.con
        # body...

findConfigurationFile: (featureFolder) ->
      console.log("findConfigurationFile")
      console.log(featureFolder)
      console.log("---")

loadConfigurationFile: (configurationFile) ->
        console.log("loadConfigurationFile")
        console.log(configurationFile)
        console.log("---")

getStepsDescriptionJSONLocalPath: ->
        console.log("getStepsDescriptionJSONLocalPath")
        console.log(stepsDescriptionJSON)
        console.log("---")
        # not the right folder at this time
        findFeatureFolder(__dirname)

updateStepsDescriptionJSONLocalCopy: (stepsDescriptionJSON) ->
        console.log("updateStepsDescriptionJSONLocalCopy")
        console.log(stepsDescriptionJSON)
        console.log("---")
