# autocomplete-gherkin package

Full autocompletion for Gherkin based on Cucumber `_steps.rb` files.

This is made possible by **autocomplete-plus** through its [Provider Api](https://github.com/atom-community/autocomplete-plus/wiki/Provider-API).

A source of steps definition is necessary in order to make all of this work.

You have make it by executing this command `cucumber -f json` in the folder that contain the features folder and it will generate a **json** file that contain the required tokens.

This is designed this way in order to provide flexibility to the team that write most test and the one that develop.


### Remote

The last step is to add in your features folder a file named `.autoCompleteGherkin.json` witch contain the URL of the remote `_steps.json` file.

```json
{
  "url": "http://www.example.com/features_steps.json"
}
```

### Local

The last step is to add in your features folder a file named `.autoCompleteGherkin.json` witch contain the path of the feature `_steps.json` file.

```json
{
  "localPath": "../features_steps.json"
}
```

### Dependencies

* [language-gherkin-i18n](https://github.com/mackoj/language-gherkin-i18n)
* [autocomplete-plus](https://github.com/atom-community/autocomplete-plus)

### Todo

* Load configuration file `.autoCompleteGherkin.json` at the root of the `features` folder
* Download if necessary the `steps.json`(extract of cucumber steps) made with `cucumber -f json` in the folder that contain the features folder
* Write the interesting part of the code witch do the autocomplete stuff
* Support local `features_steps.json` file
* This should be language agnostic (support 64 languages)
* Be 100% compliant with autocomplete-plus and its [Provider Api](https://github.com/atom-community/autocomplete-plus/wiki/Provider-API) feed by `cucumber -f json`
* Do all documentation
* Release
* Test extensively
