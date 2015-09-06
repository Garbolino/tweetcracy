@Crons = new Meteor.Collection 'crons'

CronsSchema = new SimpleSchema
  name:
    type: String
    unique: true
  running:
    type: Boolean

Crons.attachSchema CronsSchema

cronsNames = [
  'twitterPlayerMentions'
  'twitterPlayerInfo'
]

Meteor.methods
  'startCron': (name) ->
    if Meteor.isServer
      logger.info "startCron", name
    user = Meteor.users.findOne({_id:this.userId});
    if Roles.userIsInRole(user, ['admin'])
      Crons.update({name:name},{$set: {running:true}})
    else
      throw new Meteor.Error 403, "Need to be and admin"
    return
  'stopCron': (name) ->
    if Meteor.isServer
      logger.info "stopCron", name
    user = Meteor.users.findOne({_id:this.userId});
    if Roles.userIsInRole(user, ['admin'])
      Crons.update({name:name},{$set:{running:false}})
    else
      throw new Meteor.Error 403, "Need to be and admin"
    return

  'startAllCrons': ->
    if Meteor.isServer
      logger.info "startAllCrons"
    user = Meteor.users.findOne({_id:this.userId});
    if Roles.userIsInRole(user, ['admin'])
      Crons.update({},{$set: {running:true}}, {multi:true})
    else
      throw new Meteor.Error 403, "Need to be and admin"
    return
  'stopAllCrons': ->
    if Meteor.isServer
      logger.info "stopAllCrons"
    user = Meteor.users.findOne({_id:this.userId});
    if Roles.userIsInRole(user, ['admin'])
      Crons.update({},{$set: {running:false}}, {multi:true})
    else
      throw new Meteor.Error 403, "Need to be and admin"
    return

if Meteor.isServer
  checkCronsExists = ->
    for cronName in cronsNames
      cron = Crons.findOne name:cronName
      if not cron then Crons.insert name:cronName, running: false

  Meteor.startup ->
    checkCronsExists()
