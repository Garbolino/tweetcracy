Template.adminCrons.events
  'click .start-all-crons': (e, t) ->
    console.log "click .start-all-crons"
    Meteor.call "startAllCrons"

  'click .stop-all-crons': (e, t) ->
    console.log "click .stop-all-crons"
    Meteor.call "stopAllCrons"

  'change input': (e, t) ->
    # console.log("changed:", this.name);
    checkbox = $(e.target)
    console.log 'e:', e
    # console.log($('.auto-unmatch').prop('checked'));
    checked = checkbox.prop('checked')
    console.log("checked:", checked);
    console.log 'this', this
    # console.log 'template', t
    if checked
      Meteor.call "startCron", @name
    else
      Meteor.call "stopCron", @name
    return



Template.cronControls.events
  'click .restart-queue': (e, t) ->
    console.log "restart all"


Template.adminCrons.helpers
  'cronInputAttributes': ->
    # console.log('cronAttributes:', this);
    cronInputAttributes = {}
    if @running
      cronInputAttributes['checked'] = true
    cronInputAttributes

  'cronRowAttributes': ->
    # console.log('cronAttributes:', this);
    cronRowAttributes = {}
    if @running
      cronRowAttributes['class'] = 'success'
    else
      cronRowAttributes['class'] = 'danger'
    cronRowAttributes

