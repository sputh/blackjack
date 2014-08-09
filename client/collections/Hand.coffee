class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    # if has ace + [10, jack, queen, king] --> blackJack!

  hit: ->
    @add(@deck.pop()).last()

  stand: ->
    @at(0).flip()
    while(@.scores()[0] < 17)
      @.hit()
    @trigger('compareScore')

  clear: ->
    console.log("before clear",@)
    # @reset(@.hand)
    # `console.log("after clear",@)`

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21
      console.log("bust")
      @trigger('bust')
    if score == 21 then @trigger('winner')
    if hasAce then [score, score + 10] else [score]
    # while (@isDealer)
    #   console.log('testing')

  start: ->
    # @.pop()
    # console.log("whyyyy")
    @trigger('startnow')
