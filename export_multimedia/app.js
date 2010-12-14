$(document).ready(function() {
  var current = 0;
  var question_total = $('#question_total').text(); // Récupération du nombre total de questions

  $('.question:first-child').show(); // Affiche la première question

  $('a#next').click(function() {
    if(current == question_total) { // Si on a fini le questionnaire
      $('#score').show(); // Affichage du score

      $('a#next').hide(); // Cache le bouton "Voir mon score"
    }
    else {
      $('a#previous').show();
      $('.question:visible').fadeOut();
      ++current;
      $('#question_number').text(current + 1);
      $('.question:eq('+current+')').fadeIn();

      if(current == question_total - 1)
        $('a#next').text("Voir mon score");
    }
  });

  $('a#previous').click(function() {
    if(current + 1 <= 0)
      $(this).hide();

      $('.question:visible').fadeOut();
      --current;
      $('#question_number').text(current + 1);
      $('.question:eq('+current+')').fadeIn();

  });

});