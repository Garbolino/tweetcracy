@minusMinutes = (date, minutes) ->
  new Date(date.getTime() - minutes * 60000)


@getBestDictValue = (myDict) ->
  sortable = []
  for val of myDict
    sortable.push [
      val
      myDict[val]
    ]
  sortable.sort (a, b) ->
    a[1] - (b[1])

  console.log(sortable)
  sortable[0]
