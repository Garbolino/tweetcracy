
prepareChartData = (stats, type) ->
  datasets = []
  console.log(type)
  _.each stats, (obj) ->
    stat =
      name: getPlayerName(obj.playerId)
      party: getPlayerParty(obj.playerId)
      mentions: obj.mentions
      tag: if obj.bestTag? then obj.bestTag.text else ''
    if getPlayerType(obj.playerId) is type
      datasets.push(stat)

  ordered = _(datasets).sortBy (obj) ->
    -obj.mentions

  _.each ordered, (obj, index) ->
    obj.index = index + 1

  console.log(ordered)
  ordered

Template.lastStats.helpers
  'lastUpdate': () ->
    Session.get 'lastUpdate'

Template.chartStats.onCreated ->
  @subscribe "latestStats"


Template.chartStats.onRendered ->
  type = @data.type
  @autorun =>
    lastStats = PlayerStats.find({}, {sort:{'createdAt': -1}, limit:10}).fetch()
    Session.set "#{type}-latestStats", prepareChartData(lastStats, type)
    if lastStats[0]?
      Session.set "lastUpdate", lastStats[0].createdAt
    # Tracker.afterFlush ->


Template.chartStats.helpers
  'playerStats': () ->
    type = @type
    Session.get "#{type}-latestStats"



