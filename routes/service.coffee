# CMS

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
