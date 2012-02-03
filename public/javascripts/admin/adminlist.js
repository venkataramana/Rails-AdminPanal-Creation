
                   checked = false
	        function check_all()
                {

		        var a = document.getElementById('f');
		        if(checked==false)
		        {
			        checked = true;
		        }
		        else
		        {
			        checked = false;
		        }
		        for(var i=0;i<a.elements.length;i++)
		        {
			        a.elements[i].checked=checked;
		        }
	        }

                function change(event)
	        {

                        var checkboxarr = new Array();

		        if(document.getElementById('f').length>0)
		        {

			        for(var i=29; i<document.getElementById('f').length; i++)
			        {
				        if(document.getElementById('f').admin_id[i].id.checked=true)
				        {
					checkboxarr[i] = document.getElementById('f').admin_id[i].value;
				        }
				        alert(checkboxarr);
                                 }

			                if(checkboxarr.length==0)
			                {
				                alert(checkboxarr.length);
			                }
			                else
			                {
                                                alert(checkboxarr.length);
			                }
		        }
		        else
		        {
		        alert("False");
		        }
	      }

