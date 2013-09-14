$(document).ready(function() {
  $(".comment_button").first().click(function(event){
      event.preventDefault();
      var comment_form = $(".new_comment form").serialize();
      console.log(comment_form);
      $.post('/posts/1/comments', comment_form, function(response){
        $("#comment_response").html(response);
      });
  });

  $('.filters').on('click', '#filter-sent', function(event){
      event.preventDefault();
      $('.received-messages').fadeOut();
      $('.sent-messages').slideDown();
  });

  $('.filters').on('click', '#filter-received', function(event){
      event.preventDefault();
      $('.sent-messages').slideUp();
      $('.received-messages').fadeIn();
  });

  $('.filters').on('click', '#filter-all', function(event){
      event.preventDefault();
      $('.received-messages').fadeIn();
      $('.sent-messages').fadeIn();
  });
});