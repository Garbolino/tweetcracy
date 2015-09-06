CronJob = Meteor.npmRequire("cron").CronJob


jobTwitterPlayersMetions = new CronJob(
  cronTime: "0 */10 * * * *"
  onTick: Meteor.bindEnvironment(->
    logger.info "jobTwitterPlayersMetions: called"
    is_running = Crons.findOne(name:"twitterPlayerMentions").running
    if is_running
      logger.info "***jobTwitterPlayersMetions: running"
      Meteor.call "getTwitterMentions"
    else
      logger.warn "jobTwitterPlayersMetions: NOT running"
    return
  , (error) ->
    logger.error "jobTwitterPlayersMetions: error", error: error
    return
  )
  start: false
)
jobTwitterPlayersMetions.start()

jobTwitterPlayersInfo = new CronJob(
  cronTime: "0 10 0 * * *"
  onTick: Meteor.bindEnvironment(->
    logger.info "jobTwitterPlayersInfo: called"
    is_running = Crons.findOne(name:"twitterPlayerInfo").running
    if is_running
      logger.info "***jobTwitterPlayersInfo: running"
      Meteor.call "updatePlayersInfo"
    else
      logger.warn "jobTwitterPlayersInfo: NOT running"
    return
  , (error) ->
    logger.error "jobTwitterPlayersInfo: error", error: error
    return
  )
  start: false
)
jobTwitterPlayersInfo.start()
