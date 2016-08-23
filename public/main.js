$(document).ready(function() {
  if(window.location.pathname.replace(/^\/|\/$/g, "") === 'work') {
    Work.start();
  }
});

(function() {
  var self = window.Work = {
    currentId: null,

    start: function() {
      self.nextExample();
      self.bind();
    },

    bind: function() {
      $(document).on('click', '.selectable', function() {
        $(this).toggleClass('chosen');
      })

      $(document).on('click', '.submit-answer', function() {
        var hyponym = $('.chosen').map(function(idx, elem) { return $(elem).text() }).get().join(' ');

        $.post('/tasks/' + self.currentId + '/answer', {answer: hyponym}, function() {
          self.nextExample();
        })
      })
    },

    nextExample: function() {
      $.get('/tasks/get', function(data) {
        self.currentId = data.id;
        $('#hypernym').text(data.hypernym);

        var html = $.map(data.description.split(' '), function(word, idx) {
          return "<span class='selectable'>" + word + "</span>";
        }).join(' ');
        $('#description').html(html);
      }, 'json');
    }
  }
})()