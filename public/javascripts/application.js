// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var std_wallcomment_val = "Escribe aqui..."
var slideshows = new Array(1000);
var slideshows_pointer = new Array(1000);
var slideshows_counter = 0;


function create_simple_bubble(url, id) {
    var str = "<div style='border:4px solid black; display:none;'  id='simple_bubble_"+id+"'><img id='simple_bubble_image_"+id+"' class='a_img'  src='"+url+"' /></div>";
    $("body").append(str);
}

function show_simple_bubble(id, where_element) {
    var pos = $(where_element).offset();

    var img = $("#simple_bubble_"+id+ " > img.a_img");
    var src = $(img).attr("src");
    //var width = img.width();
    //var height = img.height();

    var img = new Image();
    img.src =  src;

    var pos_left = 0;//pos.left - (width/2) + "px";
    var pos_top = 0;//pos.top - height - 50 + "px";
    pos_left = pos.left - (img.width/2);
    pos_top = pos.top - 50 - (img.height);



    $("#simple_bubble_"+id).css({position: "absolute", left: pos_left, top: pos_top, "z-index":10000});
    $("#simple_bubble_"+id).show();
}

function hide_simple_bubble(id) {
    $("#simple_bubble_"+id).hide();
}


function my_highlight(selector) {
    $(selector).each(function (){
        $(this).highlight("slow");
    });
}

function showCampConvocatoriaData(camp_id, data_id) {

    $("#convocatoriaunitdata_title_camp_"+camp_id).html($("#camp_unit_title_"+camp_id+"_"+data_id).html());
    $("#convocatoriaunitdata_content_camp_"+camp_id).html($("#camp_unit_content_"+camp_id+"_"+data_id).html());
}

function showCampaignConvoc(camp_id, title) {
    $.ajax({
		type: "GET",
		url: "/campaigns/" + camp_id.toString(),
		data: "mode=convocatoria",
		dataType: "script",
		success: function(myhtml){
			var mybox = new Boxy(myhtml, {title: title,closeable: true, fixed: false, closeText: "Cerrar", unloadOnHide: true });
			var pos = mybox.getPosition();
			//setTimeout(function() {
				//if(pos[0] < 0 || pos[1] < 0) {
					mybox.moveTo(50,50);
				//}
			//}, 200);
		}
	});


}

function slideElementFromSlideshow(ss_id, new_point, old_point) {

    //if(ismsie()) {
    
    $(slideshows[ss_id][old_point]).hide();
    $(slideshows[ss_id][new_point]).show();

    /*} else {
        $(slideshows[ss_id][old_point]).fadeOut("fast", function() {
           $(slideshows[ss_id][new_point]).fadeIn("fast");
        });
    } */
}

function nextSlideshowElement(ss_id) {
    sse_count = slideshows[ss_id].length;
    old_point = slideshows_pointer[ss_id]
    new_point = old_point + 1;
    if(new_point >= sse_count) {
       new_point = 0;
    }
    slideshows_pointer[ss_id] = new_point;
    slideElementFromSlideshow(ss_id, new_point, old_point);
}

function initSlideshow(selector) {
    slideshows[slideshows_counter] = $(selector);
    slideshows_pointer[slideshows_counter] = 0;
    new_ss_id =  slideshows_counter;
    slideshows_counter++;

    return new_ss_id;
    
}

function wall_comment_got_focus(where) {

    where = where || '#wall_comment_textarea';

    var cur_val =  $(where).val();
    $(where).addClass("wall_textarea_focus");

    if(cur_val == std_wallcomment_val) {
        $(where).val("");    
    }
}

function wall_comment_lost_focus(where) {

    where = where || '#wall_comment_textarea';

    var cur_val =  $(where).val();
    $(where).removeClass("wall_textarea_focus");

    if (cur_val == "") {
        $(where).val(std_wallcomment_val);
    }
}


function respond_friendrequest(fr_id, action) {
	$.ajax({
	   type: "POST",
	   url: "/friend_requests/" + action + "/" + fr_id,
	   success: function(data) {
	   		var action_text = "Aceptado";
			if (action == "ignore") {
				action_text = "Ignorado";
			} else if (action == "block") {
				action_text = "Bloqueado";
			}
				
	   		$("#friend_request_"+fr_id+"_content").html("<i>"+ action_text + "</i>")
	   }
	});
}

function loadBoxyConvoc(run_id) {
	$.ajax({
		type: "GET",
		url: "/runs/" + run_id.toString(),
		data: "mode=convocatoria",
		dataType: "script",
		success: function(myhtml){
			var mybox = new Boxy(myhtml, {title: "Convocatoria",closeable: true, fixed: false, closeText: "Cerrar", unloadOnHide: true });
			var pos = mybox.getPosition();
			//setTimeout(function() {
				//if(pos[0] < 0 || pos[1] < 0) {
					mybox.moveTo(50,50);
				//}	
			//}, 200);
		}
	});
}

function showConvocatoriaData(run_id, unit_id){
	$("#convocatoriaunitdata_run_" + run_id).fadeOut("slow", function(){
		
		$("#convocatoriaunitdata_title_run_" + run_id).html($("#convocatoriaunit_title_"+run_id+"_"+unit_id).html());
		
		$("#convocatoriaunitdata_content_run_" + run_id).html($("#convocatoriaunit_content_"+run_id+"_"+unit_id).html());
		
		$("#convocatoriaunitdata_run_" + run_id).fadeIn("slow");

	});
}

function hideallfromaboutandshowother(id) {

	$('.aboutcontentdiv').each(function(i) {
		if($(this).is(':visible')) {
			$(this).fadeOut(1000, function (f) {
				$('#' + id).fadeIn(2000);
			});
			return false;
		}
	});

}

function get_paycond(cond_arr, age) {
	for(var i = 0; i< cond_arr.length; i++) {
		if(age >= cond_arr[i].from_age && age <= cond_arr[i].to_age ) {
			return cond_arr[i];
		}
	}
	return false;
}

function get_paycond_array_from_var(runevent_id) {
	var arr = [];
	for(var i = 0; i < payconds.length; i++) {
		if(payconds[i].runevent_id == runevent_id) {
			arr.push(payconds[i]);
		}
	}
	return arr;
}

function get_user_age() {
	if(typeof user_age != "undefined") {
		return user_age;
	} else {
		// better to return value from text_field???
		return 30;
	}
}

function change_inscription_amount(runevent_id) {
	if(typeof payconds != "undefined") { // just if payconds is given
		var pcond_arr = get_paycond_array_from_var(runevent_id);
		var age = get_user_age();
		var pcond = get_paycond(pcond_arr, age);
		
		if(pcond == false) {
			alert("idiot");
		} else {
			var amount = pcond.amount;
			var amount_extra = pcond.amount_extra;
			var amount_total = amount + amount_extra;
			
			alert(amount_total);
		}
	}
}

function isfirefox() {
	if(navigator.userAgent.toLowerCase().indexOf('firefox/') > -1) {
		return true;
	}
	return false;
}

function ischrome() {
	if(navigator.userAgent.toLowerCase().indexOf('chrome') > -1) {
		return true;
	}
	return false;
}

function issafari() {
	if(navigator.userAgent.toLowerCase().indexOf('safari/') > -1) {
		return true;
	}
	return false;
}

function ismsie() {
	if ("Microsoft Internet Explorer" == navigator.appName) {
		return true;
	} 
	return false;
}

function hide_hidden() {
	$('.hidden').hide();
}
		
function map_to_bottom(run_id) {
	var convocbottomcont_height = jQuery('#convocatoriaunitbottomcontainer_run_'+run_id).height();
	var convoclisttable_height = jQuery('#convoclisttable_run_'+run_id).height();
	var convoclist_height = jQuery('#convoclist_run_'+run_id).height();
	var dif = convoclist_height - convoclisttable_height - convocbottomcont_height;
	dif = dif + "px";
	$('#convocatoriaunitbottomcontainer_run_'+run_id).css({
		"position": "relative",
		"top": dif
	});	
}
		
function init_convoc(run_id) {
	setTimeout("hide_hidden()",10);
	setTimeout("hide_hidden()",100);
	setTimeout("hide_hidden()",200);
						
	setTimeout("map_to_bottom("+run_id+")",10);
}
