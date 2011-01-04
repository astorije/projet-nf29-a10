$(document).ready(function() {
  var current = 0;
  var count_questions = $('.question').size(); // Récupération du nombre total de questions
  var count_answerable_questions = $('.question ul').size();
  var score = 0;

  $('#footer').slideDown();
  $('h1').slideDown(function() {
    $('#questions').fadeIn();
  });

  $('#count_questions').text(count_questions);

  $('.question:first-child').show(); // Affiche la première question

  $('a#next').click(function() {
    if(current < count_questions)
      ++current;

    hide_solution();
    hide_indice();

    if(count_answerable_questions > 0
    && current >= count_questions) { // Si on a fini le questionnaire
      $('#indice_link').slideUp();
      $('li.center').animate({opacity: 0});
      $('a#next').animate({opacity: 0}); // Cache le bouton "Voir mon score"
      $('#questions').fadeOut(function() {
        score = compute_score(count_answerable_questions);
        $('#score_value').text(score);
        $('#score').removeClass('good bad');
        if(score >= 50)
          $('#score').addClass('good');
        else
          $('#score').addClass('bad');
        $('#score').fadeIn(); // Affichage du score
      });
    }
    else {
      $('a#previous').show();
      $('.question:visible').fadeOut();
      $('#question_number').text(current + 1);
      $('.question:eq('+current+')').fadeIn();

      if($('.question:eq('+current+') .indice').length)
        $('#indice_link').slideDown();
      else
        $('#indice_link').slideUp();

      if(current == count_questions - 1)
        if(count_answerable_questions == 0)
          $('a#next').hide();
        else
          $('a#next').text("Voir mon score");
    }
  });

  $('a#previous').click(function() {
    if(current >= 0)
      --current;

    if(current <= 0)
      $(this).hide();

    $('a#next').show();
    hide_solution();
    hide_indice();

    $('#score').fadeOut(function() {
      if($('.question:eq('+current+') .indice').length)
        $('#indice_link').slideDown();
      else
        $('#indice_link').slideUp();

      $('li.center').animate({opacity: 1});
      $('.question:visible').fadeOut();
      $('#question_number').text(current + 1);
      $('#questions').fadeIn();
      $('.question:eq('+current+')').fadeIn();

      if(current == count_questions - 1)
        $('a#next').animate({opacity: 1}); // Cache le bouton "Voir mon score"
      else
        $('a#next').text("Suivant");
    });
  });

  $('#toggle_solutions a').click(function() {
    if($('.solution:visible').length)
      hide_solution();
    else {
      $(this).text("Cacher les solutions");
      $('.solution').slideDown();
    }
  });

  hide_solution = function() {
    $('#toggle_solutions a').text("Afficher les solutions");
    $('.solution').slideUp(function() {
      $(this).hide();
    });
  };

  $('#indice_link').click(function() {
    if($('#indice_bloc #content:visible').length)
      hide_indice();
    else {
      $('#indice_bloc #content').html($('.question:eq('+current+') .indice').html());
      $('#indice_bloc #content').slideDown();
    }
  });

  hide_indice = function() {
    $('#indice_bloc #content').slideUp();
  }

  // Transformation des liens Youtube en vidéos embarquées
  $('a[href*="http://www.youtube.com"]').flash(
    { width: 340, height: 280 },
    { version: 8 },
    function(htmlOptions) {
      $this = $(this);
      htmlOptions.src = $this.attr('href').replace(/watch\?v=/, 'v/');
      $this.before($.fn.flash.transform(htmlOptions));
    }
  );

  compute_score = function(total) {
    var nb_good = 0;
    $('.question ul').each(function(i, dom) {
      var correct = true;
      $(dom).children('li').each(function(index, domEle) {
        if($(domEle).find('input:text').length) {
          if($(domEle).find('input:text').val() != $(this).find('.solution').text())
            correct = false;
        }
        else if($(domEle).find('input:checkbox').length) {
          if(($(domEle).find('input:checkbox:checked').length
            && $(domEle).find('.solution img').attr('alt') != 'Vrai')
          || ($(domEle).find('input:checkbox').not(':checked').length
            && $(domEle).find('.solution img').attr('alt') != 'Faux'))
            correct = false;
        }
        else if($(domEle).find('input:radio').length) {
          if(($(domEle).find('input:radio:checked').length
            && $(domEle).find('.solution img').attr('alt') != 'Vrai')
          || ($(domEle).find('input:radio').not(':checked').length
            && $(domEle).find('.solution img').attr('alt') != 'Faux'))
            correct = false;

        }
      });
      if(correct)
        nb_good++;
    });
    return Math.round(100*(nb_good / total));
  };
});
