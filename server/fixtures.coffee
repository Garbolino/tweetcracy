
players = [
  {"twitter":"marianorajoy", "facebook":"54212446406", "party": "pp", "type": "person", "name": "Mariano Rajoy"},
  {"twitter":"sanchezcastejon", "facebook":"pedro.sanchezperezcastejon", "party": "psoe", "type": "person", "name": "Pedro Sánchez"},
  {"twitter":"Pablo_Iglesias_", "facebook":"IglesiasTurrionPablo", "party": "podemos", "type": "person", "name": "Pablo Iglesias"},
  {"twitter":"Albert_Rivera", "facebook":"Albert.Rivera.Diaz", "party": "cs", "type": "person", "name": "Albert Rivera"},
  {"twitter":"agarzon", "facebook":"alberto.garzon.espinosa", "party": "iu", "type": "person", "name": "Alberto Garzón"},
  {"twitter":"PPopular","facebook":"pp", "party":"pp", "type": "party", "name": "Partido Popular"},
  {"twitter":"PSOE","facebook":"psoe","party":"psoe", "type": "party", "name": "Partido Socialista"},
  {"twitter":"ahorapodemos","facebook":"269212336568846","party":"podemos", "type": "party", "name": "Podemos"},
  {"twitter":"iunida","facebook":"izquierda.unida", "party":"iu", "type": "party", "name": "Izquiera Unida"},
  {"twitter":"CiudadanosCs","facebook":"Cs.Ciudadanos", "party":"cs", "type": "party", "name": "Ciudadanos"},
]

Meteor.startup ->
  if Players.find().count() is 0
    _.each players, (obj) ->
      player =
        name: obj.name
        twitter: {screen_name: obj.twitter}
        facebook: {id: obj.facebook }
        party: obj.party
        type: obj.type

      Players.insert(player)
