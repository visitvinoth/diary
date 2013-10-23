// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require_tree .
jQuery('document').ready(function(){
	associate_links();
});

function associate_links () {
	jQuery('#save_li').live('click',function(e){
		e.preventDefault();
	    	jQuery.ajax({
	        url: '/save_post',
	        type : 'POST',
	        data:{
	        	entry_text: jQuery('#entry_text').val()
	        },
	        success: function(data) {
	        	alert(data);
	        },
	        failure: function(error){
			alert(error);
	        },
	        error: function(error){
	        	alert(error);
	        },
	        async:   false
	    });
	});
}
