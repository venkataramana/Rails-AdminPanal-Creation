$(document).ready(function(){
   $("#search_admin").focus(function(){
          $(this).val('');
        });
        $("#search_admin").blur(function(){
          $(this).val('Enter Value');
        });
   });

