class window.AppView extends Backbone.View

  template: _.template '
    <div class="top">
    <h2 class="score">Your Score: <span></span></h2>
    <button class="hit-button btn btn-info">Hit</button>
    <button class="stand-button btn btn-info">Stand</button>
    <button class="newGame-button btn btn-info" style="display: none;">Start a New Game</button>
    </div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('dealerHand').stand()
    "click .newGame-button": -> @model.start()

  initialize: ->
    @model.on 'change:playerHand', => @render()
    @model.on 'change:dealerHand', => @render()
    @model.on 'gameEnded', => @showNewGameButton()
    @model.on 'dealerWon', => @dealerWon()
    @model.on 'showMessage:dealerWon', => @showMessageDealerWon()
    @model.on 'showMessage:playerWon', => @showMessagePlayerWon()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.score span').html(@model.get 'playerTotalScore')

  showNewGameButton: ->
    @render()
    @$('.newGame-button').toggle()
    @$('.hit-button').toggle()
    @$('.stand-button').toggle()

  showMessageDealerWon: ->
    $('.modal-title').html("<strong>Dealer won!!!</strong>")
    $('#myModal').modal('show')

  showMessagePlayerWon: ->
    $('.modal-title').html("<strong>You won!!!</strong>")
    $('#myModal').modal('show')
