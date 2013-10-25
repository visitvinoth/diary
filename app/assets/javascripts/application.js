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
var DATA_SAVE_FREQUENCY = 5000;
var FLASH_HIDE_INTERVAL = 6000;
var flash_hide_timer;
jQuery('document').ready(function(){
    associateLinks();
    triggerAutoSave();
    loginCheck();
    showFlashes();
});

function associateLinks () {
    associateSaveLink();
    associateSignLinks();
    // associateSignUpLink();
    // associateSignInLink();
    // associateOldEntriesLink();
}

function associateSaveLink(){
	jQuery('#save_li').live('click',function(e){
		e.preventDefault();
	    	savePost();
	});
}
// function associateSignUpLink(){
//     jQuery('#signup').live('click',function(e){
//         e.preventDefault();
//         jQuery.ajax({
//             url: '/sign_up',
//             type : 'POST',
//             data:{
//                 name: jQuery('#name').val(),
//                 email: jQuery('#email').val(),
//                 password: jQuery('#password').val()
//             },
//             success: function(data) {
//                 if (data.redirect) {
//                     window.location.href = data.redirect;
//                 }
//             },
//             failure: function(error){
//                 flash(error);
//             },
//             error: function(error){
//                 flash(error);
//             },
//             async:   false
//         });
//     });
// }

// function associateSignInLink(){
//     jQuery('#signin').live('click',function(e){
//         e.preventDefault();
//         jQuery.ajax({
//             url: '/sign_in',
//             type : 'POST',
//             data:{
//                 email: jQuery('#email').val(),
//                 password: jQuery('#password').val()
//             },
//             success: function(data) {
//                 if (data.redirect) {
//                     window.location.href = data.redirect;
//                 }
//             },
//             failure: function(error){
//                 flash(error);
//             },
//             error: function(error){
//                 flash(error);
//             },
//             async:   false
//         });
//     });
// }

function associateSignLinks(){
    jQuery('.sign_in').live('click',function(e){
        e.preventDefault();
        jQuery(this).addClass('sign_selected');
        jQuery(this).removeClass('sign_unselected');
        jQuery('.sign_up').removeClass('sign_selected');
        jQuery('.sign_up').addClass('sign_unselected');
        jQuery('.sign_ups').hide();
        jQuery('.sign_ins').show();
    });
    jQuery('.sign_up').live('click',function(e){
        e.preventDefault();
        jQuery(this).addClass('sign_selected');
        jQuery(this).removeClass('sign_unselected');
        jQuery('.sign_in').removeClass('sign_selected');
        jQuery('.sign_in').addClass('sign_unselected');
        jQuery('.sign_ups').show();
        jQuery('.sign_ins').hide();
    });
}
function savePost () {
    flash('Saving...');
    jQuery.ajax({
        url: '/save_post',
        type : 'POST',
        data:{
        	entry_text: jQuery('#entry_text').val()
        },
        success: function(data) {
         jQuery('#entry_text').attr('saved_data' , jQuery('#entry_text').val());
        	flash(data);
        },
        failure: function(error){
            flash(error);
        },
        error: function(error){
        	flash(error);
        },
        async:   true
    });
}
function triggerAutoSave () {
    setInterval(checkDirtyAndSave, DATA_SAVE_FREQUENCY);
}

function checkDirtyAndSave() {
    if (jQuery('#entry_text').attr('saved_data') != jQuery('#entry_text').val()) {
        savePost();
    }
}

function flash (flash_str) {
    jQuery('#flash_tag').html(flash_str);
    if(!jQuery('#flash_tag').is(':visible')){
        jQuery('#flash_tag').slideDown();
    }
    clearTimeout(flash_hide_timer);
    flash_hide_timer = setTimeout(hide_flash, FLASH_HIDE_INTERVAL);
}
function hide_flash () {
    jQuery('#flash_tag').slideUp();
}

function loginCheck () {
    if(jQuery('#logged_in_user_id').val() != ''){
        jQuery('#gateway_div').hide();
        jQuery('#shutter').hide();
    }
}

function showFlashes () {
    if (jQuery('#flash_notice').size()>0) {
        flash(jQuery('#flash_notice').val());
    } else if (jQuery('#flash_error').size()>0) {
        flash(jQuery('#flash_error').val());
    }
}
