# CMS Service Endpoint
exports.cms = (req, res) ->
  cmsUpdates =
    lessons: [
      {
        id: 1
        date: '01-14'
        pubDate: '2013-01-14'
        topic: 'Introduction'
      }, {
        id: 2
        date: '01-21'
        pubDate: '2013-01-21'
        topic: 'HTML5 Semantics and Structure'
      }, {
        id: 3
        date: '01-28'
        pubDate: '2013-01-28'
        topic: 'CSS3'
      }
    ]
    updated: Date()

  res.json cmsUpdates

# Feed Service Endpoint
exports.feed = (req, res) ->
  feedData =
    submissions: [
      {
        exercise: 1
        user: 'Noah Freitas'
        url: 'https://github.com/noah-freitas/learning-node-js/tree/master/1'
        date: '2013-01-21'
      }
    ]
  req.socket.setTimeout Infinity
  res.type 'text/event-stream'
  res.set 'Cache-Control', 'no-cache'
  res.write '\n'
  res.write 'id: 1\n'
  res.write "data: #{JSON.stringify feedData}\n\n"
