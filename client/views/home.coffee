getDaysLabels = () ->
  labels = []
  now = new Date()
  # minusDays

getPlayerDataSet = (player) ->
  followers = PlayerFollowers.find({playerId:player._id}).fetch()
  data = []
  _.each followers, (obj) ->
    data.push(obj.twitter)
  dataset =
    data: data
    label: player.name
    strokeColor: partyColorsHEX[player.party]
  return dataset

prepareChartData = () ->
  datasets = []
  chartData =
    labels: ['antes','ayer', 'hoy']
    datasets: null

  players = Players.find().fetch()
  _.each players, (obj) ->
    data = getPlayerDataSet(obj)
    datasets.push(data)

  # chartData.labels = labels
  chartData.datasets = datasets
  # lineChartData['datasets'].fi = "#{service} conversions"
  chartData


prepareRankingData = (stats, type) ->
  datasets = []
  _.each stats, (obj) ->
    stat =
      name: getPlayerName(obj.playerId)
      party: getPlayerParty(obj.playerId)
      mentions: obj.mentions
      tag: if obj.bestTag? then "#{obj.bestTag.text}: #{obj.bestTag.counter}" else ''
    if getPlayerType(obj.playerId) is type
      datasets.push(stat)

  ordered = _(datasets).sortBy (obj) ->
    -obj.mentions

  _.each ordered, (obj, index) ->
    obj.index = index + 1

  ordered

Template.lastStats.helpers
  'lastUpdate': () ->
    Session.get 'lastUpdate'

Template.rankingMentions.onCreated ->
  @subscribe "latestStats"


Template.rankingMentions.onRendered ->
  type = @data.type
  @autorun =>
    lastStats = PlayerStats.find({}, {sort:{'createdAt': -1}, limit:10}).fetch()
    Session.set "#{type}-latestStats", prepareRankingData(lastStats, type)
    if lastStats[0]?
      Session.set "lastUpdate", lastStats[0].createdAt
    # Tracker.afterFlush ->


Template.rankingMentions.helpers
  'playerStats': () ->
    type = @type
    Session.get "#{type}-latestStats"

Template.rankingFollowers.helpers
  'playerFollowers': () ->
    type = @type
    players = Players.find({type:type},{sort:{'twitter.followers_count': -1}}).fetch()
    _.each players, (obj, index) ->
      obj.index = index + 1
    players


Template.chartFollowers.onCreated ->
  @subscribe "latestFollowers"

Template.chartFollowers.onRendered ->
  @autorun ->
    Session.set "lastFollowers", prepareChartData()
    Tracker.afterFlush ->
      data = Session.get "lastFollowers"
      console.log(data)
      drawCanvasLine data, "chart-followers"
