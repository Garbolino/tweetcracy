Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  trackPageView: true

Router.map ->
  # Home
  @route "/",
    name: 'home'
    waitOn: ->
      Meteor.subscribe "allPlayers"

  @route "/lideres",
    name: 'leaders'
    template: 'players'
    waitOn: ->
      Meteor.subscribe "players", 'person'
    data: ->
      players: Players.find()
      title: 'Líderes Políticos'

  @route "/partidos",
    name: 'parties'
    template: 'players'
    waitOn: ->
      Meteor.subscribe "players", 'party'
    data: ->
      players: Players.find()
      title: 'Partidos Políticos'

  @route "adminCrons",
    path: "/admin/crons/"
    # controller: adminPageController
    # controller: adminPageController
    waitOn: ->
      Meteor.subscribe 'crons'
    data: ->
      # console.log "route: adminJobs", QueueJobs:QueueJobs
      crons: Crons.find()
