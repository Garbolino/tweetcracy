Template.header.helpers
  'activeTab': () ->
    args = Array::slice.call(arguments, 0)
    args.pop()
    active = _.any(args, (name) ->
      Router.current() and (Router.current().route.getName().toLowerCase()).indexOf(name) isnt -1
    )
    active and 'active'
