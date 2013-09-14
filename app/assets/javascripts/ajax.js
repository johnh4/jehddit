$(document).ready(function() {
  $(".comment_button").first().click(function(event){
      event.preventDefault();
      var comment_form = $(".new_comment form").serialize();
      console.log(comment_form);
      $.post('/posts/1/comments', comment_form, function(response){
        $("#comment_response").html(response);
      });
  });
});