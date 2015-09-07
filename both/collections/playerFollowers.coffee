@PlayerFollowers = new Meteor.Collection("player_followers")

PlayerFollowersSchema = new SimpleSchema
  playerId:
    type: String
    index: true
  date:
    type: String
  createdAt:
    type: Date
  twitter:
    type: Number
    optional: true
  facebook:
    type: Number
    optional: true

PlayerFollowers.attachSchema PlayerFollowersSchema
