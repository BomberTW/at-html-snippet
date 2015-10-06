AtHtmlSnippetView = require './at-html-snippet-view'
{CompositeDisposable} = require 'atom'

module.exports = AtHtmlSnippet =
  atHtmlSnippetView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atHtmlSnippetView = new AtHtmlSnippetView(state.atHtmlSnippetViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atHtmlSnippetView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'at-html-snippet:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atHtmlSnippetView.destroy()

  serialize: ->
    atHtmlSnippetViewState: @atHtmlSnippetView.serialize()

  toggle: ->
    console.log 'AtHtmlSnippet was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
