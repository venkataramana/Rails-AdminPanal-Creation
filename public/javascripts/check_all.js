
	        //var a = document.getElementById('f');

	        function check_all()
                {
                checked = false
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

