@minusMinutes = (date, minutes) ->
  new Date(date.getTime() - minutes * 60000)

@today = () ->
  now = new Date()
  month = now.getMonth() + 1
  year = now.getFullYear()
  day = now.getDate()
  date = year + "-" + month + "-" + day
  date

@dayBefore = (date) ->
  date = new Date(date)
  dayTime = date.setDate(date.getDate() - 1)
  dayBefore = new Date(dayTime)
  month = dayBefore.getMonth() + 1
  year = dayBefore.getFullYear()
  day = dayBefore.getDate()
  newDate = year + "-" + month + "-" + day
  newDate

@addMinutes = (date, minutes) ->
  new Date(date.getTime() + minutes * 60000)

@minusMinutes = (date, minutes) ->
  new Date(date.getTime() - minutes * 60000)

@addDays = (date, days) ->
  new Date(date.getTime() + days * 60000*60*24)

@minusDays = (date, days) ->
  new Date(date.getTime() - days * 60000*60*24)

@shuffle = (o) ->
  j = undefined
  x = undefined
  i = o.length
  while i
    j = Math.floor(Math.random() * i)
    x = o[--i]
    o[i] = o[j]
    o[j] = x
  o

