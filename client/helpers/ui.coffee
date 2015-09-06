UI.registerHelper "prettifyDate", (date) ->
  moment(date).fromNow()

UI.registerHelper "compactDate", (date) ->
  moment(date).format("H:mm:ss DD/MM/YY")

UI.registerHelper "getPartyColor", (party) ->
  partyColorsString[party]

UI.registerHelper "getPlayerType", (type) ->
  if type is 'person'
    'Líder Político'
  else
    'Partido Político'

@partyColorsHEX =
  'pp': '#0073b7'
  'psoe': '#f56954'
  'podemos': '#8E24AA'
  'iu':'#00a65a'
  'cs': '#FF851B'

@partyColorsString =
  'pp': 'blue'
  'psoe': 'red'
  'podemos': 'purple'
  'iu': 'green'
  'cs': 'orange'
