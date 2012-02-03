        jQuery.noConflict();
        jQuery(document).ready(function($){
        });


        function checkAll()
        {
	        var rs = ($('checkall').checked)?true:false;
	        var chkBoxArr = $$('input[type="checkbox"]');

	        for(i=0;i<chkBoxArr.length;i++)
	        {
	          	if(chkBoxArr[i].id == 'iId')
          		{
			           chkBoxArr[i].checked = rs;
		          }

	        }
        }

        function doAsAction(obj)
        {
	        val = obj.value;
	        if(val!='')
	        {
		        if (val == 'ViewAll')
		        {
			        $('frmlist').submit();
		        }
		        else
		        {
			        tot = getCheckCount();
			        //alert(tot);
			        if(tot>0)
			        {
				        $('frmlist').submit();
			        }
			        else
			        {
				        alert('Please select any record')
				        obj.options[0].selected=true;
			        }
			        return false;
		        }
	        }
        }

        function getCheckCount()
        {
	        var chkBoxArr = $$('input[type="checkbox"]');
          	var tot=0;
          	for(i=0;i<chkBoxArr.length;i++)
          	{
          	  	if(chkBoxArr[i].id == 'iId' && chkBoxArr[i].checked)
		        {
			        tot++;
		        }

          	}
            return tot;
        }

        function checknull()
        {
	        if($('keyword').value=='')
	        {
		        alert('Plese enter any keyword to Search');
		        $('keyword').focus();
		        return false;
	        }
        }

        function validate_search()
        {
	        checknull();

	        if($('keyword').value!='' &&  $('option').value=='')
	        {
		        alert('Plese select Field to search records');
		        $('option').focus();
		        return false;
	        }
        }



        function reset1(frm)
        {
	        frm.reset();
        }

