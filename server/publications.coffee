Meteor.publish 'players', (type) ->
  Players.find({type:type})

Meteor.publish 'crons', () ->
  Crons.find()

Meteor.publish 'allPlayers', () ->
  Players.find()

Meteor.publish 'stats', () ->
  PlayerStats.find()

Meteor.publish 'latestStats', () ->
  PlayerStats.find({}, {sort:{'createdAt': -1}, limit:10})

Meteor.publish 'latestFollowers', () ->
  PlayerFollowers.find({}, {sort:{'createdAt': -1}, limit:30})
