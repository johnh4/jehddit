$(document).ready(function() {
  $(".comment_button").first().click(function(event){
      event.preventDefault();
      var comment_form = $(".new_comment form").serialize();
      console.log(comment_form);
      $.post('/posts/1/comments', comment_form, function(response){
        $("#comment_response").html(response);
      });
  });

  //****** Message notifications


  setInterval(function() {
      jsonReq();
  }, 2000);

  function jsonReq() {
    $.getJSON('unread_count', function(result){
      $('#unread-count').html(result);
    });
  }
  /*
  $('.aj-test').on('click', '#ajax_button', function(event) {
    event.preventDefault();
    $.getJSON('unread_count', function(result){
      $('#ntest').html(result);
    });
  });
  */

  //****** Message display filters

  $('.filters').on('click', '#filter-received', function(event){
      event.preventDefault();
      $('.sent-messages').fadeOut();
      $('.received-messages').slideDown();
  });

  $('.filters').on('click', '#filter-sent', function(event){
      event.preventDefault();
      $('.received-messages').slideUp();
      $('.sent-messages').fadeIn();
  });

  $('.filters').on('click', '#filter-all', function(event){
      event.preventDefault();
      $('.received-messages').fadeIn();
      $('.sent-messages').fadeIn();
  });

  //flashing new text is mark as read, updates server
  $('.received-message').on('click', '.new', function(event){
      event.preventDefault();
      $(this).fadeOut();

      //get to the correct form through the dom. will break if html structure changes
      var newLink = $(this);
      var markDiv = newLink.next();
      var form = $(markDiv.children());
      console.log(form);

      var action = form.attr('action');
      var user_id = action.split('/')[2];
      var message_id = form.attr('id').split('_')[2];
      console.log('message_id: ' + message_id);
      console.log('user_id: ' + user_id);
      
      //submit the form
      var data = form.serialize();
      //console.log('data: ' + data);
      //form.submit();
      
      //$('.mark-form form').submit();
      
      //do it with ajax
      
      $.ajax('users/'+user_id+'/messages/'+message_id, {
        method: 'PATCH',
        success: function(){
            console.log('ran patch');
        }
      }); 
  });

  $('.received-messages').on('click', '#mark-all', function(){
    $('.mark-form form').submit();
    $('.new').fadeOut();
  });

});