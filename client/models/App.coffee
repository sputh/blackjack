#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @start()
    # @on('start', console.log("heloooo"))
    @get('dealerHand', @).on 'compareScore', =>
      playerScore = Math.max(@get('playerHand').scores())
      dealerScore = Math.max(@get('dealerHand').scores())
      if dealerScore > playerScore and dealerScore <= 21
        alert("Sorry, dealer wins")
      else
        alert("You win")
    # @get('playerHand', @).on 'bust', =>
    #   alert("sorry you lost")
    #   @start()
      # console.log(@get('AppView'))
    @get('playerHand', @).on 'winner', =>
      alert(@get('playerHand').name() + "won!")
      @start()
    @get('playerHand', @).on 'startnow', =>
      # console.log("start", @get('playerHand', @))
      @start()

  start: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @start, @)
