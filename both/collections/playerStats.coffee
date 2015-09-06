@Schema = {}
@PlayerStats = new Meteor.Collection("player_stats")


Schema.bestTag = new SimpleSchema
  text:
    type: String
  counter:
    type: Number

PlayerStatsSchema = new SimpleSchema
  playerId:
    type: String
    index: true
  mentions:
    type: Number
  createdAt:
    type: Date
  bestTag:
    type: Schema.bestTag
    optional: true

PlayerStats.attachSchema PlayerStatsSchema
