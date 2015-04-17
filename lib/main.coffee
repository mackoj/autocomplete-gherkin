path = require 'path'
fs = require 'fs'
request = require 'request'

provider = require './provider'

module.exports =
  activate: -> provider.loadStepsDescriptionJSON(getStepsDescriptionJSONLocalPath())
  getProvider: -> provider

# Tout le télechargement et chargement de la conf d'autocomplete ce fait ici

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

downloadConfigurationFile: (configurationFile) ->
        console.log("loadConfigurationFile")
        console.log(configurationFile)
        console.log("---")

        requestOptions =
          url: configurationFile
          json: true

        request requestOptions, (error, response, properties) ->
          if error?
            console.error(error.message)
            return process.exit(1)

          if response.statusCode isnt 200
            console.error("Request for configurationFile failed: #{response.statusCode}")
            return process.exit(1)

# sauvegarder dans le /tmp/atom/nomduplugin/hash.json
          fs.writeFileSync(path.join(__dirname, 'autocomplete.json'), "#{JSON.stringify(properties, null, 0)}\n")


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
