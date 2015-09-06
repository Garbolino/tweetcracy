twitter = Meteor.npmRequire('twitter')

getAppClient = () ->
  client = new twitter(
    consumer_key: twitterApi.api_key
    consumer_secret: twitterApi.api_secret
    access_token_key: twitterApi.access_token_key
    access_token_secret: twitterApi.access_token_secret
  )
  client

getFunction = (url, params, callback) ->
  client = getAppClient()
  client.get url, params, Meteor.bindEnvironment((errors, data, res) ->
    logger.debug "Twitter getFunction: called",
      url:url
      params:params
      x_rate_limit_limit: res.headers['x-rate-limit-limit']
      x_rate_limit_remaining: res.headers['x-rate-limit-remaining']
      x_rate_limit_reset: res.headers['x-rate-limit-reset']
    if errors? and errors?.length
      logger.error "Twitter getFunction: error", url:url, params:params, errors:errors, statusCode:res.statusCode
      callback and callback(null)
    else
      if res.statusCode is 200
        logger.debug "Twitter getFunction: success", userId:client.userId, url:url, params:params, statusCode:res.statusCode
        callback and callback(null, data)
      else
        logger.warn "Twitter getFunction: statusCode not 200", userId:client.userId, url:url, params:params, statusCode:res.statusCode
        callback and callback(null)
  )

@getTwitterUserInfo = (player) ->
  url = '/users/show.json'
  params = screen_name: player.twitter.screen_name
  getTwitterData = Meteor.wrapAsync(getFunction)
  userInfo = getTwitterData url, params
  if userInfo
    updateOptions =
      $set:
        'twitter.description': userInfo.description
        'twitter.name': userInfo.name
        'twitter.followers_count': userInfo.followers_count
        'twitter.followings_count': userInfo.friends_count
        'twitter.status_count': userInfo.statuses_count
        'twitter.profile_image_url': userInfo.profile_image_url
        'twitter.profile_background_image_url': userInfo.profile_background_image_url
        'twitter.id': userInfo.id

    Players.update({_id:player._id}, updateOptions)


@getTwitterUserMentions = (player) ->
  url = '/search/tweets.json'
  params =
    q: if player.type is 'person' then player.twitter.name else player.twitter.screen_name
    result_type: 'recent'
    count: 100

  getTwitterData = Meteor.wrapAsync(getFunction)
  tweets = getTwitterData url, params
  if tweets
    counter = 0
    tags = []
    now = new Date()
    before15m = minusMinutes(now, 10)
    _.each tweets['statuses'], (obj) ->
      createdAt = new Date(obj.created_at)
      if createdAt > before15m
        counter += 1
        hashtags = obj['entities'].hashtags
        _.each hashtags, (obj) ->
          thisTag = _.find tags, (tag) ->
            tag.text is obj.text

          if thisTag?
            thisTag.counter += 1
          else
            tags.push({text:obj.text, counter:1})

    ordered = _(tags).sortBy (obj) ->
      -obj.cnt

    statObj =
      playerId: player._id
      mentions: counter
      createdAt: now
      bestTag: ordered[0]
    PlayerStats.insert(statObj)

    console.log("player:#{params.q}, mentions:#{counter}, tags:#{tags.length}")
