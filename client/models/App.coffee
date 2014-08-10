#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'playerTotalScore', 0
    @set 'dealerTotalScore', 0
    @start()

  start: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # @get('dealerHand').on('bust', @compare, @)
    @get('dealerHand').on('compareScore', @compare, @)
    @get('playerHand').on('bust', @compare, @)
    @get('playerHand').on('blackjack', @blackjack, @)

  compare: ->
    playerHandScore = @maxScore('playerHand')
    dealerHandScore = @maxScore('dealerHand')
    if playerHandScore > 21
      @trigger('showMessage:dealerWon')
      @set 'playerTotalScore', @get('playerTotalScore') - 1
      @trigger('gameEnded')
    else if dealerHandScore > playerHandScore and dealerHandScore <= 21
      @trigger('showMessage:dealerWon')
      @set 'playerTotalScore', @get('playerTotalScore') - 1
      @trigger('gameEnded')
    else
      @trigger('showMessage:playerWon')
      @set 'playerTotalScore', @get('playerTotalScore') + 1
      @trigger('gameEnded')

  maxScore: (person)->
    if (@get(person).scores().length > 1)
      if (@get(person).scores()[1] < 22)
        @get(person).scores()[1]
      else
        @get(person).scores()[0]
    else
      @get(person).scores()[0]

  blackjack: ->
    @trigger('showMessage:playerWon')
    @trigger('gameEnded')
