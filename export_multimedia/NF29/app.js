$(document).ready(function() {
  var current = 0;
  var count_questions = $('.question').size(); // Récupération du nombre total de questions
  var count_answerable_questions = $('.question ul').size();
  var score = 0;

  $('count_questions').text(count_questions);

  $('.question:first-child').show(); // Affiche la première question

  $('a#next').click(function() {
    if(current < count_questions)
      ++current;

    if(count_answerable_questions > 0
    && current >= count_questions) { // Si on a fini le questionnaire
      $('#questions').fadeOut(function() {
        score = 81;
        //score = Math.round(100*(??? / count_answerable_questions);
        $('#score_value').text(score);
        $('#score_sentence').removeClass();
        if(score >= 50)
          $('#score_sentence').addClass('good');
        else
          $('#score_sentence').addClass('bad');
        $('#score').fadeIn(); // Affichage du score
        $('a#next').hide(); // Cache le bouton "Voir mon score"
      });
    }
    else {
      $('a#previous').show();
      $('.question:visible').fadeOut();
      $('#question_number').text(current + 1);
      $('.question:eq('+current+')').fadeIn();

      if(current == count_questions - 1)
        if(count_answerable_questions == 0)
          $('a#next').hide();
        else
        $('a#next').text("");
    }
  });

  $('a#previous').click(function() {
    if(current >= 0)
      --current;

    if(current <= 0)
      $(this).hide();

    $('a#next').show();

    $('#score').fadeOut(function() {
      $('.question:visible').fadeOut();
      $('#question_number').text(current + 1);
      $('#questions').fadeIn();
      $('.question:eq('+current+')').fadeIn();

      if(current == count_questions - 1)
        $('a#next').text("Voir mon score");
      else
        $('a#next').text("Suivant");
    });
  });

  $('#toggle_solutions a').toggle(function() {
    $(this).text("Cacher les solutions");
    $('.solution').slideDown(function() {

    });
  }, function() {
    $(this).text("Afficher les solutions");
    $('.solution').slideUp(function() {
      $(this).hide();
    });
  });

});
