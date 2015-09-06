@Players = new Meteor.Collection("players")

if Meteor.isServer
  Meteor.methods
    'updatePlayersInfo': () ->
      players = Players.find().fetch()
      #twitter
      for player in players
        Meteor.call 'updateTwitterUser', player

    'updateTwitterUser': (player) ->
      data = getTwitterUserInfo(player)

    'getTwitterMentions': () ->
      players = Players.find().fetch()
      for player in players
        Meteor.call 'getTwitterPlayerMentions', player

    'getTwitterPlayerMentions': (player) ->
      getTwitterUserMentions(player)
