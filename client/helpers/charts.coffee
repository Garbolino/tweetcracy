@drawCanvasLine = (data, element) ->
  drawElement = $("##{element}")
  ctx = $("##{element}").get(0).getContext("2d")
  myNewChart = new Chart(ctx)
  options =
    pointDot: true
    showScale: true
    scaleShowGridLines: false
    bezierCurveTension: 0.3
    bezierCurve: true
    responsive: true
    maintainAspectRatio: false
  new Chart(ctx).Line(data, options)

@drawCanvasBar = (data, element) ->
  drawElement = $("##{element}")
  ctx = $("##{element}").get(0).getContext("2d")
  myNewChart = new Chart(ctx)
  options =
    pointDot: true
    showScale: true
    scaleShowGridLines: false
    bezierCurveTension: 0.3
    bezierCurve: true
    responsive: true
    maintainAspectRatio: false
  new Chart(ctx).Bar(data, options)


@getPlayerName = (playerId) ->
  player = Players.findOne playerId
  player.name

@getPlayerParty = (playerId) ->
  player = Players.findOne playerId
  player.party

@getPlayerType = (playerId) ->
  player = Players.findOne playerId
  player.type

@getPlayerColor = (playerId) ->
  player = Players.findOne playerId
  partyColors[player.party]
