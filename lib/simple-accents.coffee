{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  # TODO: Move to json
  vowels:
    [
      # Cyrillic
      { normal: "А", accented: "А́" },
      { normal: "а", accented: "а́" },
      { normal: "Е", accented: "Е́" },
      { normal: "е", accented: "е́" },
      { normal: "И", accented: "И́" },
      { normal: "и", accented: "и́" },
      { normal: "О", accented: "О́" },
      { normal: "о", accented: "о́" },
      { normal: "У", accented: "У́" },
      { normal: "у", accented: "у́" },
      { normal: "Ы", accented: "Ы́" },
      { normal: "ы", accented: "ы́" },
      { normal: "Э", accented: "Э́" },
      { normal: "э", accented: "э́" },
      { normal: "Ю", accented: "Ю́" },
      { normal: "ю", accented: "ю́" },
      { normal: "Я", accented: "Я́" },
      { normal: "я", accented: "я́" },

      # Latin
      { normal: "A", accented: "Á" },
      { normal: "a", accented: "á" },
      { normal: "E", accented: "É" },
      { normal: "e", accented: "é" },
      { normal: "I", accented: "Í" },
      { normal: "i", accented: "í" },
      { normal: "O", accented: "Ó" },
      { normal: "o", accented: "ó" },
      { normal: "U", accented: "Ú" },
      { normal: "u", accented: "ú" },
      { normal: "Y", accented: "Ý" },
      { normal: "y", accented: "ý" }
    ]

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'simple-accents:accent': => @accent()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'simple-accents:deaccent': => @deaccent()

  deactivate: ->
    @subscriptions.dispose()

  accent: ->
    @convert(no)

  deaccent: ->
    @convert(yes)

  convert: (reverse)->
    if editor = atom.workspace.getActiveTextEditor()
      text = editor.getSelectedText()
      editor.insertText(@replace(text, reverse))

  replace: (text, reverse = no, iterator = 0) ->
    if iterator > @vowels.length - 1
      return text
    vowel = @vowels[iterator];
    if reverse
      @replace(text, reverse, iterator + 1).split(vowel.accented).join(vowel.normal)
    else
      @replace(text, reverse, iterator + 1).split(vowel.normal).join(vowel.accented)

  # TODO: Solve issue of this way:
  # accented = (@vowels.map (vowel) -> vowel.accented).join("");
  # pattern = new RegExp("[#{accented}]", "i")
  # pattern.test(text)
  findAccent: (text) ->
    no
