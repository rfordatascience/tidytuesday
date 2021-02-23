// JavaScript Document

/*
This file is a combination of the following files:
- Thickbox 3.1 (thickbox-compressed.js)
*/
$(document).ready(function(){
$('form[action*="redirect.asp"]').on("submit",function(e){
e.preventDefault();
l = decodeURIComponent(String($(this).serialize()).replace(/^target=/i,""));
window.location = ((l.match(/^\//))?window.location.origin:"") + l;
return false;
});
})
/* globally used javascript */

var ie = (function(){
    var undef,
        v = 3,
        div = document.createElement('div'),
        all = div.getElementsByTagName('i');
    while (
        div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->',
        all[0]
    );
	if(!undef){
		ctx = navigator.appVersion;
		vm = ctx.replace(/.*?MSIE ([\d]*?)[^\d].*$/gi,"$1");
		if(!isNaN(vm)){v=vm}
		vm = ctx.replace(/.*?rv:([\d]*?)[^\d].*$/gi,"$1");
		if(!isNaN(vm)){v=vm}
		vm = ctx.replace(/.*?Edge\/([\d]*?)[^\d].*$/gi,"$1");
		if(!isNaN(vm)){v=12}
	}
    return v > 4 ? v : undef;
}());

Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};
function getUrlVars() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

function bls_setCookie(name,value,days) {
	if(days){
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}else{
		var expires = "";
	}
	document.cookie = name+"="+value+expires+"; path=/";
}
function bls_getCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}
function bls_deleteCookie(name) {
	bls_setCookie(name,"",-1);
}

function getScreenWidth(){
    xWidth = null;
    if(window.screen != null){
      xWidth = window.screen.availWidth;
      }
 
    if(window.innerWidth != null){
      xWidth = window.innerWidth;
      }
 
    if(document.body != null){
      xWidth = document.body.clientWidth;
      }
 
    return xWidth;
  }


function deviceIsMobile(){

	if (/(Android|iPhone|iPod|webOS|NetFront|Opera Mini|SEMC-Browser|PlayStation Portable|Nintendo Wii|BlackBerry|BB)/.test(navigator.userAgent) && (!(getScreenWidth() > 600)|| /Mobile/.test(navigator.userAgent))){
		return true;
	}
	else{
		return false;	
	}

}

function get_month_long_name(month_index){
	switch(Number(month_index)){
		case 0: return "January";
		break;
		case 1: return "February";
		break;
		case 2: return "March";
		break;
		case 3: return "April";
		break;
		case 4: return "May";
		break;
		case 5: return "June";
		break;
		case 6: return "July";
		break;
		case 7: return "August";
		break;
		case 8: return "September";
		break;
		case 9: return "October";
		break;
		case 10: return "November";
		break;
		case 11: return "December";
		break;
	}
}

/*
 * Thickbox 3.1
 * By Cody Lindley (http://www.codylindley.com)
 * Copyright (c) 2007 cody lindley
 * Licensed under the MIT License: http://www.opensource.org/licenses/mit-license.php
*/
		  
var tb_pathToImage = "/images/thickbox/loadingAnimation.gif";

/*!!!!!!!!!!!!!!!!! edit below this line at your own risk !!!!!!!!!!!!!!!!!!!!!!!*/

//on page load call tb_init
$(document).ready(function(){   
	tb_init('a.thickbox, area.thickbox, input.thickbox');//pass where to apply thickbox
	imgLoader = new Image();// preload image
	imgLoader.src = tb_pathToImage;
});

//add thickbox to href & area elements that have a class of .thickbox
function tb_init(domChunk){
	$(domChunk).click(function(){
	var t = this.title || this.name || null;
	var a = this.href || this.alt;
	var g = this.rel || false;
	tb_show(t,a,g);
	this.blur();
	return false;
	});
}

function tb_show(caption, url, imageGroup) {//function called when the user clicks on a thickbox link

	try {
		if (typeof document.body.style.maxHeight === "undefined") {//if IE 6
			$("body","html").css({height: "100%", width: "100%"});
			$("html").css("overflow","hidden");
			if (document.getElementById("TB_HideSelect") === null) {//iframe to hide select elements in ie6
				$("body").append("<iframe id='TB_HideSelect'></iframe><div id='TB_overlay'></div><div id='TB_window'></div>");
				$("#TB_overlay").click(tb_remove);
			}
		}else{//all others
			if(document.getElementById("TB_overlay") === null){
				$("body").append("<div id='TB_overlay'></div><div id='TB_window'></div>");
				$("#TB_overlay").click(tb_remove);
			}
		}
		
		if(tb_detectMacXFF()){
			$("#TB_overlay").addClass("TB_overlayMacFFBGHack");//use png overlay so hide flash
		}else{
			$("#TB_overlay").addClass("TB_overlayBG");//use background and opacity
		}
		
		if(caption===null){
			caption="";
		}
		$("body").append("<div id='TB_load'><img src='"+imgLoader.src+"' /></div>");//add loader to the page
		$('#TB_load').show();//show loader
		
		var baseURL;
	   if(url.indexOf("?")!==-1){ //ff there is a query string involved
			baseURL = url.substr(0, url.indexOf("?"));
	   }else{ 
	   		baseURL = url;
	   }
	   
	   var urlString = /\.jpg$|\.jpeg$|\.png$|\.gif$|\.bmp$/;
	   var urlType = baseURL.toLowerCase().match(urlString);

		if(urlType == '.jpg' || urlType == '.jpeg' || urlType == '.png' || urlType == '.gif' || urlType == '.bmp'){//code to show images
				
			TB_PrevCaption = "";
			TB_PrevURL = "";
			TB_PrevHTML = "";
			TB_NextCaption = "";
			TB_NextURL = "";
			TB_NextHTML = "";
			TB_imageCount = "";
			TB_FoundURL = false;
			if(imageGroup){
				TB_TempArray = $("a[@rel="+imageGroup+"]").get();
				for (TB_Counter = 0; ((TB_Counter < TB_TempArray.length) && (TB_NextHTML === "")); TB_Counter++) {
					var urlTypeTemp = TB_TempArray[TB_Counter].href.toLowerCase().match(urlString);
						if (!(TB_TempArray[TB_Counter].href == url)) {						
							if (TB_FoundURL) {
								TB_NextCaption = TB_TempArray[TB_Counter].title;
								TB_NextURL = TB_TempArray[TB_Counter].href;
								TB_NextHTML = "<span id='TB_next'>&nbsp;&nbsp;<a href='#'>Next &gt;</a></span>";
							} else {
								TB_PrevCaption = TB_TempArray[TB_Counter].title;
								TB_PrevURL = TB_TempArray[TB_Counter].href;
								TB_PrevHTML = "<span id='TB_prev'>&nbsp;&nbsp;<a href='#'>&lt; Prev</a></span>";
							}
						} else {
							TB_FoundURL = true;
							TB_imageCount = "Image " + (TB_Counter + 1) +" of "+ (TB_TempArray.length);											
						}
				}
			}

			imgPreloader = new Image();
			imgPreloader.onload = function(){		
			imgPreloader.onload = null;
				
			// Resizing large images - orginal by Christian Montoya edited by me.
			var pagesize = tb_getPageSize();
			var x = pagesize[0] - 150;
			var y = pagesize[1] - 150;
			var imageWidth = imgPreloader.width;
			var imageHeight = imgPreloader.height;
			if (imageWidth > x) {
				imageHeight = imageHeight * (x / imageWidth); 
				imageWidth = x; 
				if (imageHeight > y) { 
					imageWidth = imageWidth * (y / imageHeight); 
					imageHeight = y; 
				}
			} else if (imageHeight > y) { 
				imageWidth = imageWidth * (y / imageHeight); 
				imageHeight = y; 
				if (imageWidth > x) { 
					imageHeight = imageHeight * (x / imageWidth); 
					imageWidth = x;
				}
			}
			// End Resizing
			
			TB_WIDTH = imageWidth + 30;
			TB_HEIGHT = imageHeight + 60;
			$("#TB_window").append("<a href='' id='TB_ImageOff' title='Close'><img id='TB_Image' src='"+url+"' width='"+imageWidth+"' height='"+imageHeight+"' alt='"+caption+"'/></a>" + "<div id='TB_caption'>"+caption+"<div id='TB_secondLine'>" + TB_imageCount + TB_PrevHTML + TB_NextHTML + "</div></div><div id='TB_closeWindow'><a href='#' id='TB_closeWindowButton' title='Close'>close</a> or Esc Key</div>"); 		
			
			$("#TB_closeWindowButton").click(tb_remove);
			
			if (!(TB_PrevHTML === "")) {
				function goPrev(){
					if($(document).unbind("click",goPrev)){$(document).unbind("click",goPrev);}
					$("#TB_window").remove();
					$("body").append("<div id='TB_window'></div>");
					tb_show(TB_PrevCaption, TB_PrevURL, imageGroup);
					return false;	
				}
				$("#TB_prev").click(goPrev);
			}
			
			if (!(TB_NextHTML === "")) {		
				function goNext(){
					$("#TB_window").remove();
					$("body").append("<div id='TB_window'></div>");
					tb_show(TB_NextCaption, TB_NextURL, imageGroup);				
					return false;	
				}
				$("#TB_next").click(goNext);
				
			}

			document.onkeydown = function(e){ 	
				if (e == null) { // ie
					keycode = event.keyCode;
				} else { // mozilla
					keycode = e.which;
				}
				if(keycode == 27){ // close
					tb_remove();
				} else if(keycode == 190){ // display previous image
					if(!(TB_NextHTML == "")){
						document.onkeydown = "";
						goNext();
					}
				} else if(keycode == 188){ // display next image
					if(!(TB_PrevHTML == "")){
						document.onkeydown = "";
						goPrev();
					}
				}	
			};
			
			tb_position();
			$("#TB_load").remove();
			$("#TB_ImageOff").click(tb_remove);
			$("#TB_window").css({display:"block"}); //for safari using css instead of show
			};
			
			imgPreloader.src = url;
		}else{//code to show html
			
			var queryString = url.replace(/^[^\?]+\??/,'');
			var params = tb_parseQuery( queryString );

			TB_WIDTH = (params['width']*1) + 30 || 630; //defaults to 630 if no paramaters were added to URL
			TB_HEIGHT = (params['height']*1) + 40 || 440; //defaults to 440 if no paramaters were added to URL
			ajaxContentW = TB_WIDTH - 30;
			ajaxContentH = TB_HEIGHT - 45;
			
			if(url.indexOf('TB_iframe') != -1){// either iframe or ajax window		
					urlNoQuery = url.split('TB_');
					$("#TB_iframeContent").remove();
					if(params['modal'] != "true"){//iframe no modal
						$("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton' title='Close'>close</a> or Esc Key</div></div><iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContentW + 29)+"px;height:"+(ajaxContentH + 17)+"px;' > </iframe>");
					}else{//iframe modal
					$("#TB_overlay").unbind();
						$("#TB_window").append("<iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContentW + 29)+"px;height:"+(ajaxContentH + 17)+"px;'> </iframe>");
					}
			}else{// not an iframe, ajax
					if($("#TB_window").css("display") != "block"){
						if(params['modal'] != "true"){//ajax no modal
						$("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton'>close</a> or Esc Key</div></div><div id='TB_ajaxContent' style='width:"+ajaxContentW+"px;height:"+ajaxContentH+"px'></div>");
						}else{//ajax modal
						$("#TB_overlay").unbind();
						$("#TB_window").append("<div id='TB_ajaxContent' class='TB_modal' style='width:"+ajaxContentW+"px;height:"+ajaxContentH+"px;'></div>");	
						}
					}else{//this means the window is already up, we are just loading new content via ajax
						$("#TB_ajaxContent")[0].style.width = ajaxContentW +"px";
						$("#TB_ajaxContent")[0].style.height = ajaxContentH +"px";
						$("#TB_ajaxContent")[0].scrollTop = 0;
						$("#TB_ajaxWindowTitle").html(caption);
					}
			}
					
			$("#TB_closeWindowButton").click(tb_remove);
			
				if(url.indexOf('TB_inline') != -1){	
					$("#TB_ajaxContent").append($('#' + params['inlineId']).children());
					$("#TB_window").unload(function () {
						$('#' + params['inlineId']).append( $("#TB_ajaxContent").children() ); // move elements back when you're finished
					});
					tb_position();
					$("#TB_load").remove();
					$("#TB_window").css({display:"block"}); 
				}else if(url.indexOf('TB_iframe') != -1){
					tb_position();
					if($.browser.safari){//safari needs help because it will not fire iframe onload
						$("#TB_load").remove();
						$("#TB_window").css({display:"block"});
					}
				}else{
					$("#TB_ajaxContent").load(url += "&random=" + (new Date().getTime()),function(){//to do a post change this load method
						tb_position();
						$("#TB_load").remove();
						tb_init("#TB_ajaxContent a.thickbox");
						$("#TB_window").css({display:"block"});
					});
				}
			
		}

		if(!params['modal']){
			document.onkeyup = function(e){ 	
				if (e == null) { // ie
					keycode = event.keyCode;
				} else { // mozilla
					keycode = e.which;
				}
				if(keycode == 27){ // close
					tb_remove();
				}	
			};
		}
		
	} catch(e) {
		//nothing here
	}
}

//helper functions below
function tb_showIframe(){
	$("#TB_load").remove();
	$("#TB_window").css({display:"block"});
}

function tb_remove() {
 	$("#TB_imageOff").unbind("click");
	$("#TB_closeWindowButton").unbind("click");
	$("#TB_window").fadeOut("fast",function(){$('#TB_window,#TB_overlay,#TB_HideSelect').trigger("unload").unbind().remove();});
	$("#TB_load").remove();
	if (typeof document.body.style.maxHeight == "undefined") {//if IE 6
		$("body","html").css({height: "auto", width: "auto"});
		$("html").css("overflow","");
	}
	document.onkeydown = "";
	document.onkeyup = "";
	return false;
}

function tb_position() {
$("#TB_window").css({marginLeft: '-' + parseInt((TB_WIDTH / 2),10) + 'px', width: TB_WIDTH + 'px'});
	if ( !(ie<7)) { // take away IE6
		$("#TB_window").css({marginTop: '-' + parseInt((TB_HEIGHT / 2),10) + 'px'});
	}
}

function tb_parseQuery ( query ) {
   var Params = {};
   if ( ! query ) {return Params;}// return empty object
   var Pairs = query.split(/[;&]/);
   for ( var i = 0; i < Pairs.length; i++ ) {
      var KeyVal = Pairs[i].split('=');
      if ( ! KeyVal || KeyVal.length != 2 ) {continue;}
      var key = unescape( KeyVal[0] );
      var val = unescape( KeyVal[1] );
      val = val.replace(/\+/g, ' ');
      Params[key] = val;
   }
   return Params;
}

function tb_getPageSize(){
	var de = document.documentElement;
	var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
	var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
	arrayPageSize = [w,h];
	return arrayPageSize;
}

function tb_detectMacXFF() {
  var userAgent = navigator.userAgent.toLowerCase();
  if (userAgent.indexOf('mac') != -1 && userAgent.indexOf('firefox')!=-1) {
    return true;
  }
}


/* main-nav dropdowns*/

var show_main_nav_timeout = "";
var current_tab_focus = -1;
  
$(document).ready(function() {
	$(".nojs").removeClass("nojs");   
	$("ul#main-nav .sub ul li").find("a").parent().css("borderBottom","1px solid #384D5B");
	$("#main-nav > li a").focusin(function(){
	$("#main-nav li.focus").removeClass("focused");
	$("#main-nav > li.focused").removeClass("focused");
    $(this).parent().addClass("focused");
	}); // end focusin

	$("#main-nav li div ul:last-child li:last-child").focusout(function() {  
    $("#main-nav > li.focus").removeClass("focus");
    $("#main-nav > li.focused").removeClass("focused");
   }); // end focusout
   
	$("#main-nav > li:first-child").focusout(function() {	  
		$("input").not("#main-nav > a").focusin(function() {
	   $("#main-nav li.focus").removeClass("focus");
	   $("#main-nav li.focused").removeClass("focused");		
	  }); // end focusin
   }); // end focusout

   $(document).on("mouseover", "ul#main-nav > li > a",function() {		
		if(show_main_nav_timeout != "") {
		   clearTimeout(show_main_nav_timeout);
		   }
		   this_element = $(this);
			
		if(current_tab_focus != $("ul#main-nav > li").index($(this).closest("li"))) {
			   show_main_nav_timeout = setTimeout(function(){show_main_nav(this_element);current_tab_focus = $("ul#main-nav > li").index($(this).closest("li"));}, 500);
			  }else{
			   clearTimeout(show_main_nav_timeout);	
			  }
			  
		$(document).on("mouseover", ".focused div.sub",function() {	
			if(show_main_nav_timeout != ""){
			 clearTimeout(show_main_nav_timeout);
		     }
			 this_element = $(this);
			
			if(current_tab_focus != $("ul#main-nav > li").index($(this).closest("li"))) {
			 show_main_nav_timeout = setTimeout(function(){show_main_nav(this_element);current_tab_focus = $("ul#main-nav > li").index($(this).closest("li"));}, 500);
			 }else{
			 clearTimeout(show_main_nav_timeout);	
			 }
		   }); 
		
		$(document).on("mouseleave", ".focused",function() {	
		    clearTimeout(show_main_nav_timeout);
		    show_main_nav_timeout = setTimeout(function(){show_main_nav(null);current_tab_focus = -1;}, 500);
		    });
		
		$(document).on("mouseleave", "ul#main-nav > li > a",function() {	
			clearTimeout(show_main_nav_timeout);
		    show_main_nav_timeout = setTimeout(function(){show_main_nav(null);current_tab_focus = -1;}, 500);
		    }); 
	  }); // end on mouseover
	

	function show_main_nav(element) {
		$(".focused").find("div.sub").css("display","none");	
		$(".focused").removeClass("focused");
		
		if(element != null) {
		   element.parent().find("div.sub").css("display","block");
		   element.parent().addClass("focused");
    	  }
		  show_main_nav_timeout= "";
    }
	$("ul#main-nav div.sub a ").click(function(e) {
		$("div.sub").css("display","none");
		$(".focused").removeClass("focused");
		$(".focus").removeClass("focus");
		clearTimeout(show_main_nav_timeout);
	   }); //end click
}); //end ready  


/* Keyboard Navigation on main-nav */
$(document).ready( function(){
$("#main-nav > li").focusin(function(){
	$("#main-nav li.focus").removeClass("focus");
    $(this).addClass("focus");
});
$("#main-nav li div ul:last-child li:last-child").focusout(function(){  
	$("#main-nav li.focus").removeClass("focus");
});
$("#main-nav > li:first-child").focusout(function(){	  
	$("input").not("#main-nav a").focusin(function(){
		$("#main-nav li.focus").removeClass("focus");
	});
});
$("body").not("#main-nav").click(function(){
	$("#main-nav li.focus").removeClass("focus");
});
$("#main-nav").hover(function(){
	$("#main-nav li.focus").removeClass("focus");
	
});
});

/*social media bindings*/
$(document).ready(function(){
		$(".share_facebook").click(function(){
			shareURL = encodeURIComponent(window.location);
			window.open('http://www.facebook.com/sharer.php?u=' + shareURL, 'facebook', 'toolbar=0,status=0,height=436,width=646,scrollbars=yes,resizable=yes');
			
		});
		$(".share_twitter").click(function(){
			shareTitle = document.title;
			shareURL = encodeURIComponent(window.location);
			window.open('https://twitter.com/intent/tweet?text=' + encodeURIComponent(shareTitle) + ' ' + shareURL, 'twitter', 'toolbar=0,status=0,height=436,width=646,scrollbars=yes,resizable=yes');
			
		});
		$(".share_linkedin").click(function(){
			shareTitle = document.title;
			shareURL = encodeURIComponent(window.location);
			shareDescription = document.title;
			shareSource = "U.S. Bureau of Labor Statistics";
			window.open('http://www.linkedin.com/shareArticle?mini=true&url=' + shareURL + '&title=' + shareTitle + '&summary=' + shareDescription + '&source=' + shareSource, 'linkedin', 'toolbar=0,status=0,height=436,width=646,scrollbars=yes,resizable=yes');	
		});
		$(".share_googleplus").click(function(){
		 	shareTitle = document.title;
			shareURL = encodeURIComponent(window.location);
			window.open('https://plusone.google.com/_/+1/confirm?hl=en&url=' + shareURL + '&title=' + shareTitle, 'google+', 'toolbar=0,status=0,height=436,width=646,scrollbars=yes,resizable=yes');	
			
		});
	
});

/* urchin 7 custom jquery - removed 4/30/2019*/
/*if (typeof $ != 'undefined') {
	   $(document).ready(function() {
	   	var filetypes = /\.(zip|pdf|doc|docx|xls|xlsx|ppt|pptx|mp3|db|nr0|rss|rtf|txd|txg|txl|txs|txt|wav)$/i;
	   	$('a[href]').each(function() {
	   		var href = $(this).attr('href');
	   		//file downloads
	           if (href.match(filetypes)) {
	               $(this).click(function() {
	                   urchinTracker(href);
	                   if ($(this).attr('target') == undefined || $(this).attr('target').toLowerCase() != '_blank') {
	                       setTimeout(function() { location.href =  href; }, 200);
	                       return false;
	                   }
	               });
	           }
	   	});
   });
}*/

/* remove social media on data */
$(document).ready(function() {
	if(String(window.location.href).match(/data(.*?|\.bls.\gov)\/search.*?$/gi)){
		$('.social-media').css("display","none");
		$('.social-media').parent('.article-tools-box').css("display","none");
	}
});
/* faster YouTube page load */
var _YTplayer, _YTcurrentPlayer;
var _YTplayerRegister = {};
function _initYTPlayers(selector){
	var offset = 0;
	if(selector){
		$(selector).find('div[id^=ytplayer]').remove();
		$(".youtube-player div[id^=ytplayer]").each(function(){
			offset = Number($(this).attr("data-player-number")) > offset ? Number($(this).attr("data-player-number")) : offset;
		});
	}else{
		selector = ".youtube-player";
	}

	$(selector).each(function(index){
		$(this).append('<div data-id="'+$(this).attr("data-id")+'" tabindex="0" id="ytplayer'+(index+1+offset)+'" data-player-number="'+(index+1+offset)+'"><img src="https://i.ytimg.com/vi/'+$(this).attr("data-id")+'/hqdefault.jpg" alt="YouTube Video"><div class="play"></div></div>');
		$(this).find('div[id^="ytplayer"]').click(function(){
			_YTPlayerClick.call(this);
		}).keypress(function(e){
			if(e.keyCode == 13){
				_YTPlayerClick.call(this);
				$(this).focus();
			}
	});
	
	$(".youtube-player > div").each(function(){
		$(this).focus(function(){
			$(this).parent().css("outline","1px dotted #fff");
		}).blur(function(){
			$(this).parent().css("outline","");
		});
	});
});

}
function _YTPlayerClick(){
		if (ie < 9){
			var iframe = document.createElement("embed");
			var embed = "https://www.youtube.com/v/ID?autoplay=1";
			iframe.setAttribute("src", embed.replace("ID", this.getAttribute("data-id")));
			iframe.setAttribute("allowfullscreen", "true");
			iframe.setAttribute("allowscriptaccess", "true");
			this.parentNode.replaceChild(iframe, this);
			
		} else {
			pauseAllPlayers();
			var registerIndex = this.getAttribute("data-player-number");
			_YTplayer = new YT.Player(this.getAttribute("id"), {
				videoId: this.getAttribute("data-id"),
				playerVars: {
					allowfullscreen: '1',
				frameborder: '0',
				rel: '0'
			},
			events: {
				onReady: function(){
					_YTplayer.playVideo();
					
				},
				onStateChange:function(e){
					if(e.target.getPlayerState() == 1){
						_YTcurrentPlayer = registerIndex;
						$(e.target.getIframe()).next(".ytduration").remove();
						pauseOtherPlayers();
					}				
					onBLSPlayerStateChange(e);
				}
			}
		});
		_YTplayerRegister[this.getAttribute("data-player-number")] = _YTplayer;
	};
};
function pauseOtherPlayers(){
	for(key in _YTplayerRegister){
		if(_YTcurrentPlayer != key){
			_YTplayerRegister[key].pauseVideo();
		}
	}
};
function pauseAllPlayers(){
	for(key in _YTplayerRegister){
		_YTplayerRegister[key].pauseVideo();
	}
};
$(window).on('load',function(){
	$(".youtube-player").each(function(){
		$(this).css({"height":$(this).find("img").height()});
	});
});
$(document).ready(function(){
	_initYTPlayers();
	$(".youtube-player p").hide();
});

function onBLSPlayerStateChange(e){
	var videoURL = YTUrlHandler_fed(e.target.getVideoUrl());
	var videoId = e.target.a.attributes["data-id"].value;
	_thisDuration = ((parseInt(e.target.getCurrentTime()) / parseInt(e.target.getDuration())) * 100).toFixed();
	if (typeof onPlayerStateChange != "undefined") { onPlayerStateChange(event); }
	if (parseInt(e.data) == parseInt(YT.PlayerState.PLAYING)) {
		if (_thisDuration == 0) {
			_f33 = false;
			_f66 = false;
			_f90 = false;
		}
		_sendEvent('YouTube Video', 'play', videoURL, 0);
	} else if (e.data == YT.PlayerState.ENDED) {
		_sendEvent('YouTube Video', 'finish', videoURL, 0);
	} else if (e.data == YT.PlayerState.PAUSED) {
		_sendEvent('YouTube Video', 'pause', videoURL, 0);
		var duration = _thisDuration;
		if (duration < 100) {
			var precentage = _thisDuration;
			if (precentage > 0 && precentage <= 33 && _f33 == false) {
				_sendEvent('YouTube Video', '33%', videoURL, 0);
			} else if (precentage > 0 && precentage <= 66 && _f66 == false) {
				_sendEvent('YouTube Video', '66%', videoURL, 0);
			} else if (precentage > 0 && precentage <= 90 && _f90 == false) {
				_sendEvent('YouTube Video', '90%', videoURL, 0);
			}
		}
	}
}

/*custom audio player*/
$(document).ready(function(){
	if (ie < 9 ) {
		$(".audioPlayer").hide();
	}
});

	function checkIfSamePlayer( btnClicked ) {
		_audioPlayerRegisterIndex = $(btnClicked)[0].parentNode.getAttribute("data-index");
		if (_audioPlayerRegisterIndex != _prevAudioPlayerRegisterIndex) {
			pauseAllPlayers(_audioPlayerRegister);
			hideAllPopupMenus(_audioPlayerRegister);
		};
	};

	function setPlayerPointerPosition(pointerElement, value, maxValue, ind) {
		$(pointerElement).css("left", ((value / maxValue) * ($(pointerElement).parent().width() - $(pointerElement).width())) + "px");
	};

	function outputPlayerTime(timeInSeconds) {
		var time = timeInSeconds;
		var hours = Math.floor(time / 3600);
		var minutes = Math.floor((time - (hours * 3600)) / 60);
		var seconds = Math.floor((time - (hours * 3600) - (minutes * 60)));
		hours = hours < 10 ? "" : hours;
		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;
		hours = hours < 1 ? hours : hours + ":";
		minutes = minutes + ":";
		return hours + minutes + seconds;
	};

	function getClickLocationRelativeToPlayerControlPercent(e, jqElement, ind) {
		return Math.round(((e.pageX - jqElement.offset().left) / (jqElement.width() - 1) * 100)) / 100;
	};

	function audioClassUpdate(currentClass, classToAdd, ind, newText, currentPopupClass, classPopupToAdd) {
		$("." + currentClass + "[data-index=" + ind + "]").removeClass(currentClass).addClass(classToAdd);
		$("." + currentPopupClass + "[data-index=" + ind + "]").text(newText);
		$("." + currentPopupClass + "[data-index=" + ind + "]").removeClass(currentPopupClass).addClass(classPopupToAdd);
	};

	function updatePointerPosition(event, jqElement, playerProperty, maxOfPlayerProperty, ind, object) {
		var clickLocationVal = getClickLocationRelativeToPlayerControlPercent(event, jqElement);
		if (clickLocationVal < 0){
			clickLocationVal = 0;
		} else if (clickLocationVal > maxOfPlayerProperty){
			clickLocationVal = maxOfPlayerProperty;
		} else {
		};
		
		$("audio[data-index=" + ind + "]")[0][playerProperty] = clickLocationVal * maxOfPlayerProperty;

		if (playerProperty == "volume" && clickLocationVal * maxOfPlayerProperty > 0) {
			$("audio")[ind].muted = false; 
			object[ind]["muted"] = false;
			audioClassUpdate("audioPlayerSoundOff", "audioPlayerSoundOn", ind, "Mute", "audioPopupSoundOff", "audioPopupSoundOn");
		};

		setPlayerPointerPosition(jqElement.find(".audioPointer"), $("audio[data-index=" + ind + "]")[0][playerProperty], maxOfPlayerProperty);
	};

	function updateSliderAmounts(ind) {
		$(".audioPlayerSeek[data-index=" + ind + "] .audioSeekAmount").show();
		$(".audioPlayerSeek[data-index=" + ind + "] .audioSeekAmount").css($(".audioPlayerSeek[data-index=" + ind + "] .audioSeekAmount").position());
		$(".audioPlayerSeek[data-index=" + ind + "] .audioSeekAmount").width($(".audioPlayerSeek[data-index=" + ind + "] .audioPointer").position().left - $(".audioPlayerSeek[data-index=" + ind + "] .audioSeekAmount").position().left);

		$(".audioPlayerVolume[data-index=" + ind + "] .audioVolumeAmount").show();
		$(".audioPlayerVolume[data-index=" + ind + "] .audioVolumeAmount").css($(".audioPlayerVolume[data-index=" + ind + "] .audioVolumeAmount").position());
		$(".audioPlayerVolume[data-index=" + ind + "] .audioVolumeAmount").width($(".audioPlayerVolume[data-index=" + ind + "] .audioPointer").position().left - $(".audioPlayerVolume[data-index=" + ind + "] .audioVolumeAmount").position().left);
	};

	function pauseAllPlayers(objectWithKeys) {
		for (var key in objectWithKeys) {					
			$("audio")[key].pause();
			objectWithKeys[key]["playState"] = "paused";
			$(".audioPlayerPause").removeClass("audioPlayerPause").addClass("audioPlayerPlay");
			$(".audioPopupPause").text("Play");
			$(".audioPopupPause").removeClass("audioPopupPause").addClass("audioPopupPlay");
		};
	};

	function hideAllPopupMenus(objectWithKeys) {
		for (var key in objectWithKeys) {
			$(".audioPopupMenu").hide();
			objectWithKeys[key]["menuState"] = false;
		};
	};

	function buildAudioPlayers(){

		$(".audioPlayer").append("<div class='audioPlayerPlay' tabindex='0'></div><div class='audioPlayerDuration'></div><div class='audioPlayerSeek'><div class='audioBar'></div><div class='audioBar audioSeekAmount'></div><div class='audioPointer' tabindex='0'></div></div><div class='audioPlayerSoundOn' tabindex='0'></div><div class='audioPlayerVolume'><div class='audioBar'></div><div class='audioBar audioVolumeAmount'></div><div class='audioPointer' tabindex='0'></div></div><a class='audioDownload' download='audio' tabindex='0'>Download File</a><div class='audioPlayerMenu' tabindex='0'></div><div class='audioPopupMenu'><div class='audioPopupPlay' tabindex='0'>Play</div><div class='audioPopupDownload'><a download='audio'>Download</a></div><div class='audioPopupSoundOn' tabindex='0'>Mute</div></div>");

		$.each($(".audioPlayer"), function(index, value) {
			var num = index;
			$(value).attr("data-index", num);
			$(value).children().attr("data-index", num);
			$(value).children().children().attr("data-index", num);
			$(value).children().children().children().attr("data-index", num); 
			$(".audioPlayer[data-index=" + index + "]").find(".audioPlayerDuration").html('<span>00:00</span><span class="totalTime"> / ' + outputPlayerTime(_audioPlayerRegister[index].duration) + "</span>");
			$(this).find("a.audioDownload").attr("href", $("audio")[index].currentSrc);
			$(this).find(".audioPopupDownload > a").attr("href", $("audio")[index].currentSrc);
		});

		$.each($(".audioPopupMenu"), function(index, value) {
			$(this).height($(this).find("div").height() * 3 + 3);
			$(this).css({"left":$(this).parent().width(), "top": -1});
		});

		$(".audioPopupMenu").hide();
		
		$(".audioPlayerPlay, .audioPopupPlay").click(function() {
			checkIfSamePlayer( this ); 
				hideAllPopupMenus(_audioPlayerRegister);
			if ($(this).hasClass("audioPlayerPlay") || $(this).hasClass("audioPopupPlay")) {
				$("audio")[_audioPlayerRegisterIndex].play();
				_audioPlayerRegister[_audioPlayerRegisterIndex]["playState"] = "playing";
				audioClassUpdate("audioPlayerPlay", "audioPlayerPause", _audioPlayerRegisterIndex, "Pause", "audioPopupPlay", "audioPopupPause");						
			} else {
				pauseAllPlayers(_audioPlayerRegister);
			};
			setPlayerPointerPosition(".audioPlayerSeek[data-index=" + _audioPlayerRegisterIndex + "] .audioPointer", $(this)[0].currentTime, $(this)[0].duration);
			updateSliderAmounts(_audioPlayerRegisterIndex);
			_prevAudioPlayerRegisterIndex = $(this)[0].parentNode.getAttribute("data-index"); 
		});

		$("audio").bind("timeupdate", function() {
			$(this).parent().find(".totalTime").prev("span").remove();
			$(this).parent().find(".audioPlayerDuration").prepend('<span>' + outputPlayerTime($(this)[0].currentTime) + "</span>");
			_audioPlayerRegister[_audioPlayerRegisterIndex].currentTime = $(this)[0].currentTime;
			setPlayerPointerPosition($(this).find(".audioPointer"), $(this)[0].currentTime, $(this)[0].duration);

			setPlayerPointerPosition(".audioPlayerSeek[data-index=" + $(this).index("audio") + "] .audioPointer", $(this)[0].currentTime, $(this)[0].duration);
			updateSliderAmounts($(this).index("audio"));
		});

		$("audio").bind("ended", function() {
			pauseAllPlayers(_audioPlayerRegister);
		});

		$(".audioPlayerSoundOn, .audioPopupSoundOn").click(function() {
			checkIfSamePlayer( this );
				hideAllPopupMenus(_audioPlayerRegister);
			if ($(this).hasClass("audioPlayerSoundOn") || $(this).hasClass("audioPopupSoundOn")) {
				$("audio")[_audioPlayerRegisterIndex].muted = true;
				_audioPlayerRegister[_audioPlayerRegisterIndex]["muted"] = true;
				$("audio")[_audioPlayerRegisterIndex].volume = 0;
				_audioPlayerRegister[_audioPlayerRegisterIndex]["volume"] = 0;
				audioClassUpdate("audioPlayerSoundOn", "audioPlayerSoundOff", _audioPlayerRegisterIndex, "Unmute", "audioPopupSoundOn", "audioPopupSoundOff");
			} else {
				$("audio")[_audioPlayerRegisterIndex].muted = false;
				_audioPlayerRegister[_audioPlayerRegisterIndex]["muted"] = false;
				$("audio")[_audioPlayerRegisterIndex].volume = 1;
				_audioPlayerRegister[_audioPlayerRegisterIndex]["volume"] = 1;
				audioClassUpdate("audioPlayerSoundOff", "audioPlayerSoundOn", _audioPlayerRegisterIndex, "Mute", "audioPopupSoundOff", "audioPopupSoundOn");						
			};
			setPlayerPointerPosition(".audioPlayerVolume[data-index=" + _audioPlayerRegisterIndex + "] .audioPointer", _audioPlayerRegister[_audioPlayerRegisterIndex]["volume"], 1);
			updateSliderAmounts(_audioPlayerRegisterIndex);
			_prevAudioPlayerRegisterIndex = $(this)[0].parentNode.getAttribute("data-index");
		});

		$(".audioPlayerMenu").click(function() {
			checkIfSamePlayer( this ); 
			if (_audioPlayerRegister[_audioPlayerRegisterIndex]["menuState"] == false) {
				_audioPlayerRegister[_audioPlayerRegisterIndex]["menuState"] = true;
				$(".audioPopupMenu[data-index=" + _audioPlayerRegisterIndex + "]").show();
			} else {
				hideAllPopupMenus(_audioPlayerRegister);
			};
			_prevAudioPlayerRegisterIndex = $(this)[0].parentNode.getAttribute("data-index");
		});

		$(document).mouseup(function(e) {
			_audioPlayerMouseDown = false;
		});

		$(".audioPlayerSeek").mousedown(function(e) {
			_audioPlayerMouseDown = true;
			checkIfSamePlayer( this );
				hideAllPopupMenus(_audioPlayerRegister);
		}).mousemove(function(e) {
			if (_audioPlayerMouseDown) {
				updatePointerPosition(e, $(".audioPlayer[data-index=" + _audioPlayerRegisterIndex + "] .audioPlayerSeek"), "currentTime", $("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0].duration, _audioPlayerRegisterIndex);
				updateSliderAmounts(_audioPlayerRegisterIndex);
			}
		}).click(function(e) {
			updatePointerPosition(e, $(".audioPlayer[data-index=" + _audioPlayerRegisterIndex + "] .audioPlayerSeek"), "currentTime", $("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0].duration, _audioPlayerRegisterIndex);
			updateSliderAmounts(_audioPlayerRegisterIndex);
			_prevAudioPlayerRegisterIndex = $(this)[0].parentNode.getAttribute("data-index");
		});

		$(".audioPlayerVolume").mousedown(function(e) {
			_audioPlayerMouseDown = true;
			checkIfSamePlayer( this );
				hideAllPopupMenus(_audioPlayerRegister);
		}).mousemove(function(e) {
			if (_audioPlayerMouseDown) {
				updatePointerPosition(e, $(".audioPlayer[data-index=" + _audioPlayerRegisterIndex + "] .audioPlayerVolume"), "volume", 1, _audioPlayerRegisterIndex, _audioPlayerRegister);
				updateSliderAmounts(_audioPlayerRegisterIndex);
			}
		}).click(function(e) {
			updatePointerPosition(e, $(".audioPlayer[data-index=" + _audioPlayerRegisterIndex + "] .audioPlayerVolume"), "volume", 1, _audioPlayerRegisterIndex, _audioPlayerRegister);
			updateSliderAmounts(_audioPlayerRegisterIndex);
			_prevAudioPlayerRegisterIndex = $(this)[0].parentNode.getAttribute("data-index"); 
		});

	};

	function resizeAudioPlayers() {
		$(".audioPlayer").each(function() {
			var newPlayerWidth;
			if ($(this).parent().width() >= 349) {
			   newPlayerWidth = $(this).parent().width() * .78 - 170;
			};
			if ($(this).parent().width() >= 650) {
				newPlayerWidth = $(this).parent().width() * .68 - 105;
			};
			if ($(this).parent().width() < 300) {
				newPlayerWidth = $(this).parent().width() * .75 - 140;
			};
			if ($(this).parent().width() <= 251) {
				newPlayerWidth = $(this).parent().width() * .88 - 110;
				$(this).find("div.audioPlayerDuration").css({"min-width": "35px"});
				$(this).find("span.totalTime, .audioDownload, div.audioPlayerVolume").hide();
				$(this)[0].volume = 1;
				$(this).find("div.audioPlayerMenu").show();
			};
			if ($(this).parent().width() < 170) {
				newPlayerWidth = $(this).parent().width() * .88 - 75;
				$(this).find(".audioPlayerDuration").hide();
			};
			if ($(this).parent().width() < 130) {
				$(this).find(".audioPlayerSeek").hide();
				$(this).find("div.audioPlayerPlay, div.audioPlayerPause, div.audioPlayerSoundOn, div.audioPlayerSoundOff, div.audioPlayerMenu").addClass("audioPlayerSm");
				$(this).find("> div").css({"margin-left": "0"});
			};
			if ($(this).parent().width() < 80) {
				$(this).find(".audioPlayerSoundOn, .audioPlayerSoundOff").hide();
				$(this).find("div.audioPlayerSm").css({"min-width": "50%"});
			};
			if ($(this).parent().width() <= 50) {
				$(this).find(".audioPlayerPlay, .audioPlayerPause").hide();
				$(this).find("div.audioPlayerSm").css({"min-width": "100%"});
			};				
			$(this).find(".audioPlayerSeek").width(newPlayerWidth - 10);
		});
	}; 

	var _audioPlayerMouseDown = false;
	var _audioPlayer;
	var _audioPlayerRegister = {};
	var _audioPlayerRegisterIndex, _prevAudioPlayerRegisterIndex;
	var audioPlayersOnPage = 0;


$(window).on('load',function() {	

	$("audio:visible").each(function(index){
	
		$(this).bind("loadedmetadata", function(){
			_audioPlayer = {
				playerIndex: index,
				playState: "paused",
				currentTime: $(this)[0].currentTime,
				duration: $(this)[0].duration,
				menuState: false,
				volume: $(this)[0].volume,
				muted: $(this)[0].muted,
				filename: $(this)[0].currentSrc,
			};
			if(!(_audioPlayerRegister.hasOwnProperty(index))){
				_audioPlayerRegister[index] = _audioPlayer;
				audioPlayersOnPage++;
			};
			if (audioPlayersOnPage == $("audio").length){
				buildAudioPlayers();
				$(this).parent().find(".audioPlayerDuration").html('<span class="totalTime"> / ' + outputPlayerTime($(this)[0].duration) + "</span>");
				resizeAudioPlayers();
				for (var key in _audioPlayerRegister){
					setPlayerPointerPosition(".audioPlayerVolume[data-index=" + key + "] .audioPointer", 1, 1);
					setPlayerPointerPosition(".audioPlayerSeek[data-index=" + key + "] .audioPointer", 0);
					updateSliderAmounts(key);
				};
			};
			$(this).unbind("loadedmetadata");
		});
		if ($(this)[0].readyState != 0){
			$(this).trigger("loadedmetadata");
		};
		$(this).hide(); 
	});
	
	$(".audioPlayer").keydown(function(e){
		setTimeout(function(){
			var that = document.activeElement;
			var playerProperty = "";
			var pointerBarInc = 0;
			
			if (_audioPlayerRegisterIndex != $(that).attr("data-index")){
				pauseAllPlayers(_audioPlayerRegister);
				hideAllPopupMenus(_audioPlayerRegister);
			};
			_audioPlayerRegisterIndex = $(that).attr("data-index");	
			
			if (e.keyCode == 13){
				if ($(document.activeElement).hasClass("audioPointer") == false){
					$(that).click();
					if ( $(that).parent().hasClass("audioPopupMenu") || $(that).parent().parent().hasClass("audioPopupMenu")){
						$(".audioPlayerMenu[data-index=" + _audioPlayerRegisterIndex + "]").focus();
					};
				};
			} else if ($(that).hasClass("audioPointer")){
				if ($(that).parent().hasClass("audioPlayerVolume")){
					playerProperty = "volume";
					pointerBarMax = 1;
					pointerBarInc = 0.1;
				} else {
					playerProperty = "currentTime";
					pointerBarMax = $("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0].duration;
					pointerBarInc = 5;
				};
				if (e.keyCode == 37){
					$("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0][playerProperty] = $("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0][playerProperty] - pointerBarInc < 0 ? 0 : $("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0][playerProperty] - pointerBarInc;	
				}
				if (e.keyCode == 39){
					$("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0][playerProperty] = $("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0][playerProperty] + pointerBarInc > pointerBarMax ? pointerBarMax : $("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0][playerProperty] + pointerBarInc;
				};
				setPlayerPointerPosition(that,$("audio[data-index=" + _audioPlayerRegisterIndex + "]")[0][playerProperty],pointerBarMax);
				updateSliderAmounts(_audioPlayerRegisterIndex);
			};
		},1);
	});

});


/* ces/cer form redirect */
$(document).ready(function(){
	if($(".footer-contact a[href*='forms/ces'], .footer-contact a[href*='forms/cer'], a.helpFormOverlay[href*='forms/cer'], a.helpFormOverlay[href*='forms/ces']").length>0){
		
		var formLabel = "cescer";
		var that = "";
		$(".footer-contact a[href*='forms/ces'], .footer-contact a[href*='forms/cer'], a.helpFormOverlay[href*='forms/cer'], a.helpFormOverlay[href*='forms/ces']").each(function(){
			$(this).attr("rel","#helpFormQuestion").addClass("bls-chartdata-trigger");
			that = $(this);
			$(this).click(function(){
				$(".refocushere").removeClass("refocushere");
				$(this).addClass("refocushere");
				setTimeout(function(){ 
					$("#helpFormQuestion #helpFormOption1A"+formLabel).focus();
					$('#helpFormQuestion .bls-overlay-heading a').click(function(){//close link
						$(".refocushere").focus();
						$(".refocushere").removeClass("refocushere");
					});
					$(document).keydown(function(e){//esc key
						 if(e.which == 27)$('#helpFormQuestion .bls-overlay-heading a').click();
					});
				}, 1)
				$("#helpFormQuestion .bls-overlay-heading a, #helpFormQuestion button").blur(function(){//stay in popup
					setTimeout(function(){
						if( $(document.activeElement).parents().hasClass('bls-chartdata-overlay') == false ){
							$('#helpFormQuestion .bls-overlay-heading a').focus();
						}; 
					}, 1);
				});
			});
		});
		
		$("body").prepend("<section role='dialog'  aria-label='help form' id='helpFormQuestion' style='display:none;' class='bls-chartdata-overlay'></section>");
		$("#helpFormQuestion").css({"overflow":"visible","margin":"0 auto","width":"600px","max-width":"600px","font-size":"1.05em"});
			$("#helpFormQuestion").append(
				"<div id='helpFormHead'>" + 
					"<img src='/images/bls_emblem_2016.png' alt='BLS emblem 2016'/>" + 
				"</div>" + 
				"<div class='helpFormSection'>" +
					"<button id='helpFormOption1A"+formLabel+"' class='helpFormOption'>Go</button>" + 
					"<p class='helpFormP'>Are you a survey respondent and need help submitting your company&#39;s data to CES?</p>" +
					
				"</div>" + 
				"<div class='helpFormSection'>" +
					"<button id='helpFormOption1B"+formLabel+"' class='helpFormOption'>Go</button>" + 
					"<p class='helpFormP'>Do you have questions about CES estimates?</p>" +
				"</div>" +  
				"<div class='helpFormSection'>" +
					"<button id='helpFormOption1C"+formLabel+"' class='helpFormOption'>Go</button>" + 
					"<p class='helpFormP'>Do you need help finding something else?<br><br></p>" +
				"</div>"
			);
		if (ie < 8) {//IE7below position absolute
			$("#helpFormQuestion #helpFormHead").css({"position":"absolute","margin":"10px 0 0 -140px"});
			$("#helpFormQuestion #helpFormQuestion").css({"font-size":"1.2em"});//font size
		} else {
			$("#helpFormQuestion #helpFormHead").css({"position":"absolute","margin":"20px 0 0 20px"});
		};
		$("#helpFormQuestion #helpFormHead img").css({"width":"120px","height":"66px","padding":"0 20px 20px 0","margin":"auto !important"});
		$("#helpFormQuestion .helpFormSection").css({"clear":"both","width":"350px","margin-left":"150px","margin-top":"30px","margin-bottom":"30px","padding":"0 18px"});
		$("#helpFormQuestion .helpFormSection:last-child").css({"margin-bottom":"20px"});//last
		$("#helpFormQuestion .helpFormP").css({"color":"#183061","line-height":"1.3em"});
		$("#helpFormQuestion .helpFormOption").css({"position":"relative","float":"right","padding":"5px","text-align":"center","width":"50px"});
		$("#helpFormQuestion #helpFormOption1A"+formLabel).click(function(){
			window.location.href = that.attr("href").replace(/\/(ces|cer)\.htm\?/gi,"/cer.htm?");
		});
		$("#helpFormQuestion #helpFormOption1B"+formLabel).click(function(){
			window.location.href = that.attr("href").replace(/\/(ces|cer)\.htm\?/gi,"/ces.htm?");
		});
		$("#helpFormQuestion #helpFormOption1C"+formLabel).click(function(){
			window.location.href = that.attr("href").replace(/\/(ces|cer)\.htm\?/gi,"/opb.htm?");
		});
	};
});

/* cew form redirect */
$(document).ready(function(){
	if($(".footer-contact a[href*='forms/cew'], a.helpFormOverlay[href*='forms/cew']").length>0){
		
		var formLabel = "cew";
		var that = "";
		$(".footer-contact a[href*='forms/cew'], a.helpFormOverlay[href*='forms/cew']").each(function(){
			$(this).attr("rel","#helpFormQuestion").addClass("bls-chartdata-trigger");
			that = $(this);
			$(this).click(function(){
				$(".refocushere").removeClass("refocushere");
				$(this).addClass("refocushere");
				setTimeout(function(){ 
					$("#helpFormQuestion #helpFormOption1A"+formLabel).focus();
					$('#helpFormQuestion .bls-overlay-heading a').click(function(){//close link
						$(".refocushere").focus();
						$(".refocushere").removeClass("refocushere");
					});
					$(document).keydown(function(e){//esc key
						 if(e.which == 27)$('#helpFormQuestion .bls-overlay-heading a').click();
					});
				}, 1)
				$("#helpFormQuestion .bls-overlay-heading a, #helpFormQuestion button").blur(function(){//stay in popup
					setTimeout(function(){
						if( $(document.activeElement).parents().hasClass('bls-chartdata-overlay') == false ){
							$('#helpFormQuestion .bls-overlay-heading a').focus();
						}; 
					}, 1);
				});
			});
		});
		
		$("body").prepend("<section role='dialog'  aria-label='help form' id='helpFormQuestion' style='display:none;' class='bls-chartdata-overlay'></section>");
		$("#helpFormQuestion").css({"overflow":"visible","margin":"0 auto","width":"600px","max-width":"600px","font-size":"1.05em"});
		$("#helpFormQuestion").append(
			"<div id='helpFormHead'>" + 
				"<img src='/images/bls_emblem_2016.png' alt='BLS emblem 2016'/>" + 
			"</div>" + 
			"<div class='helpFormSection'>" +
				"<button id='helpFormOption1A"+formLabel+"' class='helpFormOption'>Go</button>" + 
				"<p class='helpFormP'>Do you have questions about QCEW data?</p>" +
			"</div>" + 
			"<div class='helpFormSection'>" +
				"<button id='helpFormOption1B"+formLabel+"' class='helpFormOption'>Go</button>" + 
				"<p class='helpFormP'>Are you trying to report data for the Multiple Worksite Report (MWR)?</p>" +
			"</div>" +  
			"<div class='helpFormSection'>" +
				"<button id='helpFormOption1C"+formLabel+"' class='helpFormOption'>Go</button>" + 
				"<p class='helpFormP'>Are you trying to report data for the Annual Refiling Survey (ARS)?</p>" +
			"</div>" +  
			"<div class='helpFormSection'>" +
				"<button id='helpFormOption1D"+formLabel+"' class='helpFormOption'>Go</button>" + 
				"<p class='helpFormP'>Do you need help finding something else?<br><br></p>" +
			"</div>"
		);
		if (ie < 8) {//IE7below position absolute
			$("#helpFormQuestion #helpFormHead").css({"position":"absolute","margin":"10px 0 0 -140px"});
			$("#helpFormQuestion #helpFormQuestion").css({"font-size":"1.2em"});//font size
		} else {
			$("#helpFormQuestion #helpFormHead").css({"position":"absolute","margin":"20px 0 0 20px"});
		};
		$("#helpFormQuestion #helpFormHead img").css({"width":"120px","height":"66px","padding":"0 20px 20px 0","margin":"auto !important"});
		$("#helpFormQuestion .helpFormSection").css({"clear":"both","width":"350px","margin-left":"150px","margin-top":"30px","margin-bottom":"30px","padding":"0 18px"});
		$("#helpFormQuestion .helpFormSection:last-child").css({"margin-bottom":"20px"});//last
		$("#helpFormQuestion .helpFormP").css({"color":"#183061","line-height":"1.3em"});
		$("#helpFormQuestion .helpFormOption").css({"position":"relative","float":"right","padding":"5px","text-align":"center","width":"50px"});
		$("#helpFormQuestion #helpFormOption1A"+formLabel).click(function(){
			window.location.href = that.attr("href").replace(/\/(cew)\.htm\?/gi,"/cew.htm?");
		});
		$("#helpFormQuestion #helpFormOption1B"+formLabel).click(function(){
			window.location.href = that.attr("href").replace(/\/(cew)\.htm\?/gi,"/mwr-respondents.htm?");
		});
		$("#helpFormQuestion #helpFormOption1C"+formLabel).click(function(){
			window.location.href = that.attr("href").replace(/\/(cew)\.htm\?/gi,"/ars.htm?");
		});
		$("#helpFormQuestion #helpFormOption1D"+formLabel).click(function(){
			window.location.href = that.attr("href").replace(/\/(cew)\.htm\?/gi,"/opb.htm?");
		});
	};
});


/* thickbox replacement - jquery */
$(document).ready(function () {
	try{
		$(".bls-chartdata-trigger[rel]").overlay({
			top:200,
			left:"center",
			mask: {
			color: '#000',
			loadSpeed: 200,
			opacity: 0.5,
			zIndex: 10000
		  },
			initWidth:null,
			fixed: false,
			onBeforeLoad:function(){
				var el = this.getOverlay();
				var config = this.getConf();
				if(config.initWidth == null){
					config.initWidth = el.outerWidth();					
				}
				el.css("left",(($(document).width() / 2) - (config.initWidth / 2)));
			}
		});
	}catch(e){} 
    $(".bls-chartdata-trigger").click(function () {
        $(".bls-overlay-heading").remove();
        $(".bls-chartdata-overlay").prepend('<div class="bls-overlay-heading"><a href="javascript:void(0);">close</a> or Esc Key</div>');
    });
	$(document).on("click", ".bls-chartdata-overlay .bls-overlay-heading a", function(){
        $(".bls-chartdata-trigger").each(function(){
			try{
				$(this).overlay().close();
			}catch(e){}
		});
    });
    $(document).keyup(function (e) {
	    if ((e.keyCode ? e.keyCode : e.which) == 27) {
		try{
			$(".bls-chartdata-trigger").overlay().close();
		}catch(e){}
	}
    });
});
/* bls select all */
$(document).ready(function () {


$(".bls-select-all-checkboxes input[type='checkbox']").each(function() {
            var colHeader;
            var rowHeader;

            if($(this).attr('class') == 'bls_checkall'){
                //  this will be executed for the Select All checkbox of each column
                colHeader = $(this).closest('table').find('th').eq($(this).closest('tr').index());
                rowHeader = $(this).closest('tr').find('th').eq(0);
            } else {
                //  this is executed for all the other checkboxes in the table
                colHeader = $(this).closest('table').find('th').eq($(this).closest('td').index());
                rowHeader = $(this).closest('tr').find('th').eq(0);
            }
            //alert(rowHeader.text)
            //alert(colHeader.text)
            //checkboxTitle = $.trim(rowHeader.text()) + ", " + $.trim(colHeader.text());
			checkboxTitle = colHeader.html() + " : " + rowHeader.html();
            checkboxTitle = checkboxTitle.replace(/[\r\n\t]/gi," ").replace(/<a[^>]*?>.*?<\/a>/gi,"").replace(/<.*?>/gi,"").replace(/\s\s/gi,"");
            $(this).attr("title", checkboxTitle);
        }); //  end of assigning titles for checkboxes



	$(".bls-select-all-checkboxes").each(function(){	
		var that = $(this);
		var max_row_size = 0;
		that.find("tbody tr").each(function() {
            if(max_row_size < $(this).find("td,th").length){
				max_row_size = $(this).find("td,th").length;
			}	
        });
		var config = [];
		for(var i = 0; i < max_row_size; i++){
			config[i] = false;
		}
		that.find("tbody tr").each(function(){
			$(this).find("td,th").each(function(i){
				if($(this).find("input:checkbox").html() != null){
					config[i] = true;	
				}
			 });
		});
		var bls_checkall_row_size =	that.find("thead tr").length;
		var bls_checkall_label_object = {};
		that.find("thead tr").each(function(i){
		    var bls_checkall_row = i;
			var bls_checkall_colspan_context = 0;
			var bls_checkall_row_context = 0;
			$(this).find("th,td").each(function(i){
			var bls_checkall_rowspan = (isNaN(Number($(this).attr("rowspan"))) ? 1 : Number($(this).attr("rowspan")));
				if(Number(bls_checkall_row_size) - Number(bls_checkall_row) == bls_checkall_rowspan){
					if((Number(i) + Number(bls_checkall_colspan_context)) == 0){
						for(var index = 0; index < Object.size(bls_checkall_label_object); index++){
							if(!bls_checkall_label_object[index]){
								bls_checkall_row_context = index;
								break;
							}
						}
					}
					bls_checkall_label_object[(Number(i) + Number(bls_checkall_colspan_context)+bls_checkall_row_context)] =$(this).html();
				}else{
					bls_checkall_colspan_context += (isNaN(Number($(this).attr("colspan"))) ? 0 : Number($(this).attr("colspan")) - 1);
				}
			});
		});
		 
		that.find("thead").append("<tr></tr>");
		for(key in config){
			that.find("thead tr:last-child").append("<th></th>");
		}
		that.find("thead tr:last-child").find("th").each(function(i){
			if(!config[i]){
				$(this).html("<strong>Select All</strong>").css("text-align","left").css("backgroundColor","#fff").css("color","#000");
			}else{
				$(this).html("<label for='bls_checkall"+i+"' style='display:none;'>"+bls_checkall_label_object[i]+"</label><input type='checkbox' class='bls_checkall' id='bls_checkall"+i+"'/>").css("backgroundColor","#fff").css("color","#000");
			}
		});
		that.find("tbody td input:checkbox").attr("checked",false);
		that.find(".bls_checkall").on('click', function(){
			var current_child = $(this).closest("tr").find("td,th").index($(this).parent());	
			var input = $(this);
			that.find("tbody tr").each(function(i){
				$(this).find("td,th").each(function(i){
					if(current_child == i){
						if(input.attr("checked")){
							$(this).find("input:checkbox").not('.cps_checkall').attr("checked",true);	
						}else if(!input.attr("checked")){
							$(this).find("input:checkbox").not('.cps_checkall').attr("checked",false);	
						}
					}
				});
			});
		});
		
		that.find("tbody td input:checkbox").click(function(){
			var current_child = $(this).closest("tr").find("td,th").index($(this).closest("td,th"));
			current_child = current_child  - 1;		
			var input = $(this);
			that.find(".bls_checkall").each(function(i){
				if($(this).attr("checked") && !input.attr("checked")){
					if(current_child == i){
						$(this).attr("checked",false); 		
					}
				}
			});
		});	
			
	});
});



/*bls external link redirect*/
$(document).ready(function(){
bls_external_link_redirect();
function bls_external_link_redirect(){
	$("a").click(function(e){
		var url = $(this).attr("href");
		if(typeof(url)!="undefined"){
		if(url.match("^https?.*") && !url.match("https?://[^\.]*?(\.[^\.]*?|)?\.bls\.gov.*")){
			var redirectURL = "";	
			if(isWhitelisted(url)){
				return true;
			}else if(isAffiliated(url)){
				redirectURL = "/bls/exit_BLS.htm?a=true" + "&url=" + url.replace(/([^?]*\/).*/gi,"$1") + encodeURIComponent(url.replace(/[^?]*\/(.*)/gi,"$1"));
			}else{
				redirectURL = "/bls/exit_BLS.htm" + "?url=" + url.replace(/([^?]*\/).*/gi,"$1") + encodeURIComponent(url.replace(/[^?]*\/(.*)/gi,"$1"));
			}
			if(url.match(/dol.gov/gi)){
				window.open(url);
				return false;
			}
			if($(this).attr("target") == "_blank"){
				window.open(redirectURL);
			}else{
				window.location = redirectURL;
			}
			return false;
		}};
	});
}
function isAffiliated(url){
var affiliatedSites = [/^https?:\/\/.*?\..*?\.(gov|mil)\/?.*?$/,/^https?:\/\/[^\/]*?\.state[^\/]*?\.us\/?.*?$/,/twitter.com\/BLS_gov/,/nlsy79.norc.org/,/nlsy97.norc.org/,/www.nlsinfo.org/,/www.nlsbibliography.org/,/www.onetonline.org/,/www.servicelocator.org/,/www.labormarketinfo.com/,/www.floridajobs.org/,/www.discoverarkansas.net/,/http:\/\/lmigateway.coworkforce.com\/lmigateway/,/www.delawareworks.com/,/guamdol.net/,/www.hiwi.org/,/www.iowaworkforce.org/,/www.laworks.net/,/www.milmi.org/,/www.missourieconomy.org/,/ourfactsyourfuture.org/,/nevadaworkforce.com/,/www.ncesc.com/,/desncc.com/,/www.ndworkforceintelligence.com/,/www.qualityinfo.org/,/www.sces.org/,/www.tracer2.com/,/www.vtlmi.info/,/data.virginialmi.com/,/workforcewv.org/];
for(var index in affiliatedSites){
	if(url.match(affiliatedSites[index])){
		return true;
		break;
	}	
}
return false;
}
function isWhitelisted(url){
var whitelistedSites = [/doi.org/,/hirevets.gov/];
for(var index in whitelistedSites){
	if(url.match(whitelistedSites[index])){
		return true;
		break;
	}	
}
return false;
}
});

/* pre.numberedCode style */
$(document).ready(function(){
	if(ie<9){
    $("pre.numberedCode").each(function(){
			$(this).before('<span class="line-number"></span>');
			for(var j = 0; j < $(this).html().split(/\n/).length; j++) {
				$(this).prev()[0].innerHTML += '<span>' + (j + 1) + '</span>';
			}
			$(this).prev().css("height",$(this).outerHeight() - 6 +"px");
		});
		$(".line-number span").css({
			"display":"block"
		});
		$(".line-number").css({
			"float":"left",
			"padding-right":"10px",
			"background-color":"#eee",
			"border-right":"1px solid #000",
			"padding-top":"6px",
			"padding-left":"3px"
		});	
	}else{
		$("pre.numberedCode").each(function(){
		$(this).html('<span class="line-number"></span>' + $(this).html() + '<span class="cl"></span>');
        for(var j = 0; j < $(this).html().split(/\n/).length; j++) {
            var line_num = $(this).find('span')[0];
            line_num.innerHTML += '<span>' + (j + 1) + '</span>';
        }
	});
	}
});
/*justify heights for .one-col, .two-col, .three-col, .four-col with selector option*/
function alignCol(selector){
	$(".one-col, .two-col, .three-col, .four-col").each(function(i){
		var colHook = selector ? $(this).children("div").find(selector) : $(this).children("div");
		var colMaxHeight = 0;
		colHook.each(function(i){
			colMaxHeight = colMaxHeight < $(this).height() ? $(this).height() : colMaxHeight;
		}).each(function(i){
			$(this).css("height",colMaxHeight+"px");
		});
});
};

/*fixed headers for tables*/
var createFixedHeader = function(jqTableEl, jqParentElSelector){

	jqTableEl.not('.header-fixed').each(function(i) {
		if($(this).next().attr("id")!= $(this).attr("id")){
			$(this).addClass("fixed-headers");
			if(jqParentElSelector){
				$(this).attr("data-fixedheaderparent",jqParentElSelector);
			}
			var thisTable = $(this).clone();
			var newTable = thisTable.wrap("<div></div>").parent().clone();
			newTable.find("table").addClass("header-fixed").css("display","none").removeClass("sortable_datatable");

			newTable.find("caption, .sort_row, tbody, tfoot").remove();
	
			$(this).after(newTable.html());	
			

		}
	});
	
	
	$(".header-fixed").css({position: "fixed",top: "0px",display: "none",backgroundColor: "white",margin: "0px"});
	$(".header-fixed th").css({backgroundImage: "none"});
	$(".header-fixed tbody,.header-fixed tfoot").css("visibility","hidden");
	$(".header-fixed tbody tr *").css({"lineHeight":"0px","paddingTop":"0px","paddingBottom":"0px","marginTop":"0px","marginBottom":"0px","borderTop":"none","borderBottom":"none","verticalAlign":"middle","whiteSpace":"nowrap","height":"0px","overflow":"hidden"});
	$(".header-fixed tfoot *").css({"lineHeight":"0px","paddingTop":"0px","paddingBottom":"0px","marginTop":"0px","marginBottom":"0px","borderTop":"none","borderBottom":"none","height":"0px"});
	$(".header-fixed .sort_row").css("display","none");

	var fixedHeaderResizeInterval;
	$(window).unbind("resize.fixedHeader");
	$(window).bind("resize.fixedHeader",function(){
		clearTimeout(fixedHeaderResizeInterval);
		fixedHeaderResizeInterval = setTimeout(function(){
			$("table.fixed-headers").each(function(){
				createFixedHeader(jqTableEl,jqParentElSelector);
			})
			$(window).scroll();
		},50);
	});
	if(jqParentElSelector){
		parentCtx = $(jqParentElSelector)[0];
		pcleftprop = "scrollLeft";
		pctopprop = "scrollTop";
	}else{
		parentCtx = window;
		pcleftprop = "scrollX";
		pctopprop = "scrollY";
	}
	
	var fixedHeaderScrollInterval;
	$(window).unbind("scroll.fixedHeader");
	$(parentCtx).unbind("scroll.fixedHeader");
	$(parentCtx).bind("scroll.fixedHeader", function() {
		clearTimeout(fixedHeaderScrollInterval);
		fixedHeaderScrollInterval = setTimeout(function(){
			
			var matchFound = -1;
			var pleft;
			$(".fixed-headers").not('.header-fixed').each(function(ind){
				if(parentCtx != window){
					ctx = {};
					ctx.top = -$(this).find("thead").height();
					ctx.left = $(this)[0].getBoundingClientRect().left;
					ptop = ctx.top + parentCtx[pctopprop];
					pleft = ctx.left + parentCtx[pcleftprop];
				}else{
	
					ctx = $(this)[0].getBoundingClientRect();
					ptop= ctx.top + (document.documentElement.scrollTop || window.scrollY);
					pleft= ctx.left + document.documentElement.scrollLeft;
					
				}

				pbot = ptop + $(this).find("tbody").height();

				if(ptop + $(this).find("thead").height() <= $(parentCtx).scrollTop() && pbot >= $(parentCtx).scrollTop() && $(this).is(":visible") && $(parentCtx).scrollTop() != 0){
					matchFound = ind;
					return false;
				}
			});
						
			$(".header-fixed").hide();
			if(matchFound!=-1){
				
		var widthToAdd = Number($('.header-fixed:eq('+matchFound+')').prev().css("width").replace("px", ""));
			widthToAdd = widthToAdd + 2;
			if(ie <= 12){widthToAdd = widthToAdd - 2;}
			
			ctx = parentCtx!=window? $(parentCtx):$("body");
			ctx.find('.header-fixed:eq('+matchFound+')').css("width", widthToAdd + "px");

		ctx.find('.header-fixed:eq('+matchFound+')').prev().find("thead tr th, thead tr td").each(function(i){
			ctx.find('.header-fixed:eq('+matchFound+')').find("thead tr th, thead tr td").eq(i).css("width",$(this)[0].getBoundingClientRect().width-(Number($(this).css("padding-left").replace("px","")) + Number($(this).css("padding-right").replace("px","")))-0.05+"px")
		})	
				
				
				

				ctx.find('.header-fixed:eq('+matchFound+')').css("left",pleft+"px").show();
				ctx.find('.header-fixed:eq('+matchFound+') thead,.header-fixed:eq('+matchFound+') tbody,.header-fixed:eq('+matchFound+') tfoot').show();
				
				if(parentCtx != window){
					ctx.find('.header-fixed:eq('+matchFound+')').css("top", parentCtx.getBoundingClientRect().top+"px")
					
					
					ctx.find('.header-fixed:eq('+matchFound+')').css("left", ctx.find('.header-fixed:eq('+matchFound+')').prev()[0].getBoundingClientRect().left+"px")
				}
				
				
			} 
		},50);
	});
}
$(document).ready(function () {
	if($("table.fixed-headers").length > 0){
		$("table.fixed-headers").each(function(){
			createFixedHeader($(this));
		})
		
	}
});

/* glossary mouseover */
$(document).ready(function(){
	if($(".glossaryTerm").length){
		var glossaryObj = {};
		$.get("/library/snippets/glossary.stm", function(data){
			glossaryObj = JSON.parse(data);
			$(".glossaryTerm").each(function(){
				var that = $(this);
				var term = glossaryObj[$(this).text().toLowerCase().trim()];	
				if(term){
					$.get(term, function(data){
						that.attr("title",$(data).find(".term").text()).attr("rel",$(data).find(".definition").text().replace(/\<a href\=\"\#/gi,'<a href="/bls/glossary.htm#')).tooltip({tipClass: "tooltip glossaryTooltip",position:"top center",effect:"fade",offset:[0,50]}).dynamic({ bottom:{ direction: 'down'} });
					});
				}else{
					$(this).removeClass("glossaryTerm");
				};
			});
		});
	};
});

/* .triangleExpandable for FAQs */
$(document).ready(function(){
	$(".triangleExpandable .triangle").each(function(){
		$(this).next("ul, ol").hide();
		$(this).click(function(){
			if( $(this).next("ul, ol").is(":visible") ){
				$(this).next("ul, ol").hide();
				$(this).html("&rtrif;");
			}else{
				$(this).next("ul, ol").show();
				$(this).html("&dtrif;");
			};
		});
			$(this).keydown(function(e){//keyboard
				if(e.which == 13){//enter
					$(this).click();
				}
			});   
	});
	$("#triExpandAll").click(function(){
		$(".triangleExpandable .triangle").each(function(){
			$(this).next("ul, ol").show();
			$(this).html("&dtrif;");
		});
	});
		$("#triExpandAll").keydown(function(e){//keyboard
			if(e.which == 13){//enter
				$(this).click();
			}
		}); 
	$("#triCollapseAll").click(function(){
		$(".triangleExpandable .triangle").each(function(){
			$(this).next("ul, ol").hide();
			$(this).html("&rtrif;");
		});
	});
		$("#triCollapseAll").keydown(function(e){//keyboard
			if(e.which == 13){//enter
				$(this).click();
			}
		}); 
});

/* .graphicBoxes for lists*/
$(document).ready(function(){
	$(".graphicBoxes").each(function(){
		var columns = $(this).attr("data-col");
		var em = Number($(this).css("font-size").replace(/(\d+).*/gi,"$1"));
		var graphicWidth = $(this).width();
		var liHeight = 0;				
		$(this).find("li").each(function(){
			$(this).width( Math.floor(graphicWidth/columns)-(3*em)-(2*columns) ); //calculate width based on data-col					
			if( $(this).height() > liHeight ){ //find max LI height
				liHeight = $(this).height() + em;
			};
			$(this).click(function(){ //
				window.open( $(this).find("a").attr("href"),"_self" );
			});
		});
		$(this).find("li").height(liHeight);
	});
});

/* .randomizer for featuring */
$(document).ready(function(){
	$("ul.randomizer, ol.randomizer").each(function(){
		$(this).find("> li").each(function(){ $(this).hide(); });
		$(this).find("> li").eq( Math.floor(Math.random() * $(this).find("> li").length) ).show();
	});
});

/* timeline */
$(document).ready(function(){
	var timelineMonthNames = ["Jan.", "Feb.", "Mar.", "Apr.", "May", "Jun.", "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec."];
	if(!$(".timelineSegment").length){
		$(".timeline").each(function(){
			$(this).css("width", $(this).parent().width() - 23 + "px").css("left","5px");
			var timelineEvents = timeline[$(this).attr("id")];
			var maxYear = 0;
			var minYear = 99999;
			var yearList = {};
			for(index in timelineEvents){
				var event = timelineEvents[index];
				var year = Number(event.date.substr(0,4));
				if(typeof yearList[year] == "undefined"){
					yearList[year] = [];
				}
				yearList[year].push(event);
				if(year > maxYear){
					maxYear = year;
				}
				if(year < minYear){
					minYear = year;
				}
			}
			var segmentInterval = 5;
			var segmentPerYear = 1;
			var showMonths = false;
			var monthlySegmentationThreshold = 4;
			var timelineConfig = timeline[$(this).attr("id")+"-config"];
			if(timelineConfig){
				monthlySegmentationThreshold = timelineConfig.monthlySegmentation ? (maxYear - minYear + 1) : monthlySegmentationThreshold;
			}
			if(maxYear - minYear < monthlySegmentationThreshold){
				segmentInterval = 12;
				segmentPerYear = 12;
				maxYear = maxYear + 1;
				if(maxYear - minYear < 2){
					showMonths = true;
				}
			}else{
				maxYear = Math.ceil(maxYear / segmentInterval) * segmentInterval;
				minYear = Math.floor(minYear / segmentInterval) * segmentInterval;
			}
			var distanceBetweenPoints = 15;
			var distanceFromTimeline = 8;
			var spanInYearCounterMax = 0;
			var timelineSegmentWidthMax = 13;
			var timelineRange = (maxYear - minYear) * segmentPerYear;
			for(var i = 0; i <= timelineRange; i++){
			var dataSpanString = "";
				var spanInYearCounter = 0;
				var thisYear = yearList[Math.floor(minYear+(i/segmentPerYear))];
				if(typeof thisYear != "undefined"){
					for(index in thisYear){
						var event = thisYear[index];
						currentYear = Number(event.date.substr(0,4));
						currentMonth = Number(event.date.substr(4,2));
						var timeMatch = false;
						if(segmentPerYear == 12){
							if(Math.floor(minYear+(i/segmentPerYear)) == currentYear && (i%segmentPerYear)+1 == currentMonth){
								timeMatch = true;
							}
						}else{
							if(Math.floor(minYear+(i/segmentPerYear)) == currentYear){
								timeMatch = true;
							}
						}
						if(timeMatch){
							spanInYearCounter++;
							dataSpanString += '<span tabindex="0" class="data" style="top:'+ (-distanceFromTimeline - (distanceBetweenPoints*spanInYearCounter)) +'px" title="'+event.heading+'" rel="'+event.text.replace(/([^\\])"/gi,'$1\'')+'"></span>';
						}
					}
				}
				spanInYearCounterMax = spanInYearCounter > spanInYearCounterMax ? spanInYearCounter : spanInYearCounterMax;
				$(this).append('<div class="timelineSegment"><span class="label"></span>'+dataSpanString+'</div>');
				var lastSegment = $(this).find(".timelineSegment:last");
				if(i % segmentInterval == 0){
					lastSegment.addClass("major").find("span.label").html("<span>"+timelineMonthNames[i%segmentPerYear]+"<br /></span>" + (Number(minYear)+i/segmentPerYear)); 
					lastSegment.find("span.data").css("right", -(lastSegment.find("span.data").width()/2) - 1 +"px");
					lastSegment.prepend('<span class="filler"></span>');	
				}else{
					lastSegment.addClass("minor").find("span.label").html(timelineMonthNames[i%segmentPerYear]);
					lastSegment.find("span.data").css("right", -(lastSegment.find("span.data").width()/2) - 1 +"px");
				}
				if(i == 0){
					lastSegment.addClass("first").find("span.label").css("right", -(lastSegment.find("span.label").innerWidth()) + 1 +"px");
				}else if(i == timelineRange){
					lastSegment.addClass("last").find("span.label").css("right", "-2px");
				}else{
					lastSegment.addClass("middle").find("span.label").css("right", -(lastSegment.find("span.label").innerWidth() /2) +"px");
				}
			}
			var timelineSegmentWidth = ($(this).width()) / (timelineRange) -  1;
			timelineSegmentWidth = timelineSegmentWidth < timelineSegmentWidthMax ? timelineSegmentWidthMax : timelineSegmentWidth;/*limit resize of segments*/
			$(this).find(".timelineSegment").not(".first").css("width", timelineSegmentWidth + "px");
			$(this).find(".timelineSegment").not(".first").find("span.filler").css("width", timelineSegmentWidth + "px");
			$(this).css("top", (spanInYearCounterMax * distanceBetweenPoints) + distanceFromTimeline + "px").css("marginBottom", (spanInYearCounterMax * distanceBetweenPoints) + distanceFromTimeline + "px");
			if(showMonths){showMonths=" showMonths";}else{showMonths="";}
			$(this).wrap('<div class="timelineContainer'+showMonths+'"></div>');
		});
		if ($(".timeline").length) {
			/*timeline tooltip*/
			$(".timelineSegment span.data[title]").each(function() {
				$(this).attr("alt", $(this).attr("title"));
			});
			$(".timelineSegment span.data[title]").tooltip({
				tipClass: "timelineTooltip",
				onBeforeShow: function(){
					this.getTip().html("<h4>" + this.getTrigger().attr("alt") + "</h4><p>" + this.getTrigger().attr("rel") + "</p>");
				},

				onHide: function(e){
					if(this.getTrigger().hasClass("frozen")){
						this.show();	
					}
				},
				offset:[-10,0],
				position:"top center",
				events: {
					def:     "focus mouseover, blur mouseleave",
					tooltip: "focus mouseover, blur mouseleave"
				}

			});
			$(".timelineSegment span.data").mouseenter(function(e) {
				$(this).focus();
				
				$(".timelineSegment span.data").removeClass("frozen");
			});
			$(".timelineSegment span.data").focus(function(e) {
				$(".timelineSegment span.data").removeClass("frozen");
			});
			
			$(".timelineSegment span.data").on("mousemove,focus",function(e) {
				
				var containerOffset = $(this).parent().position().left - $(this).closest(".timelineContainer").scrollLeft(); 
				if(containerOffset > ($(this).parents(".timelineContainer").width() - 25 - $(".timelineTooltip").width())){
					containerOffset = $(this).parents(".timelineContainer").width() - 25 - $(".timelineTooltip").width();
				}else if(containerOffset > $(".timelineTooltip").width()/2){
					containerOffset = e.pageX - $(this).parents(".timelineContainer").offset().left - 110;
				}
				$(".timelineTooltip").css("left", $(this).parents(".timelineContainer").offset().left + containerOffset  + "px").css("position","absolute");
			});
			$(".timelineSegment span.data").click(function(e) {
				$(this).addClass("frozen");
				$(this).data("tooltip").getTip().find("a").focus();
			});
		}
	}
});

/* Bootsrap modal */
$(document).ready(function() {
	$(document.body).on('click','.modal-body a',function(e){
		$('#modal-box').on('hidden.bs.modal', function (e) {
			e.stopImmediatePropagation();
		}).modal('hide');
	});
	$('a[href$="#modal-box"]').on( "click", function() {
	   $('#modal-box').modal('show');
	});
});

	var image = new Image();
	var downloadingImage = new Image();
	downloadingImage.src = "/images/layout/bls_logo_33x66.gif";


$(document).ready(function(){

	if(typeof Highcharts !== 'undefined'){
		Highcharts.setOptions({
			plotOptions: {
				series: {
					animation: false
				}
			}
		});
		}

    var _onbeforeprint = function() {

		    	if($(".panes > div").length > 0 || $(".tab-content").length > 0 || $("#panes > div").length > 0){
				try{
					if($(".panes > div").length > 0 || $(".tab-content").length > 0){
						let allTabsLinks = document.querySelectorAll("ul.tabs > li > a");
							for(let i = 0; i<allTabsLinks.length;i++){		
								$(allTabsLinks[i]).trigger( "click" );
							}
						}
					if($("#panes > div").length > 0){
						let allTabsLinks = document.querySelectorAll("ul.tabs > li > a");
						
							for(let i = 0; i<allTabsLinks.length;i++){		
								$(allTabsLinks[i]).trigger( "click" );
								console.log(allTabsLinks[i])
							}
						}

				  }
				catch(e){
						console.log(e);
					 }					 
				}
				if($(".panes > div").length > 0 || $(".tab-content").length > 0 || $("#panes > div").length > 0){
					if($(".panes > div").length > 0 && $(".tab-content > div").length === 0 && $("#panes > div").length === 0){
					try{
						var tabsSel = document.querySelectorAll(".panes > div");
						var tabLabel = document.querySelectorAll("ul.tabs > li");
						for(var x = 0; x<tabsSel.length;x++){
							tabsSel[x].insertAdjacentHTML('beforebegin',tabLabel[x].innerHTML)
							tabsSel[x].style.display="block";
						};
					}
					catch(e){
						console.log(e);
					 }	 
					}
					else if($(".panes > div").length === 0 && $(".tab-content > div").length > 0 && $("#panes > div").length === 0){
						try{
							var tabsSel = document.querySelectorAll(".tab-content > div");
							var tabLabel = document.querySelectorAll("ul.tabs > li");
							for(var x = 0; x<tabsSel.length;x++){
								tabsSel[x].insertAdjacentHTML('beforebegin',tabLabel[x].innerHTML)
								tabsSel[x].style.display="block";
								$(tabsSel[x]).addClass( "active" ).addClass( "show" );
							};
						}
						catch(e){
							console.log(e);
						 }
					
					}
					else if($(".panes > div").length === 0 && $(".tab-content > div").length === 0 && $("#panes > div").length > 0 ){
						try{
							var tabsSel = document.querySelectorAll("#panes > div");
							var tabLabel = document.querySelectorAll("ul.tabs > li > a");
							for(var x = 0; x<tabsSel.length;x++){
								tabsSel[x].insertAdjacentHTML('beforebegin',tabLabel[x].innerHTML)
								tabsSel[x].style.display="block";
								$(tabsSel[x]).addClass( "active" ).addClass( "show" );
							};
						}
						catch(e){
							console.log(e);
						 }
					
					}
				}
    };
	
	window.addEventListener("beforeprint", function() {_onbeforeprint();});

    window.addEventListener("afterprint", function() {if($(".panes > div").length > 0 || $(".tab-content > div").length > 0 || $("#tabs").length > 0){window.location.reload(false);}});

	var _print = print;
	print = function() {

		_print();
	}
	
	var allImages = $("img");
	var printBtnExist = [];
	var duplicateATagExist = [];
	var getPrintBox = document.querySelector("div.article-tools-box");
	for(var i = 0; i<allImages.length;i++){
	   if ($(allImages[i]).attr("src") === "/images/icons/icon_small_printer.gif"){
		   printBtnExist.push(1);
			  var printText = document.querySelectorAll("a");
				for(var j = 0; j<printText.length;j++){
				  if ($(printText[j]).text().match(/print/gi) && printText[j].parentElement == getPrintBox) {
						duplicateATagExist.push(1);
						printText[j].removeAttribute("href");
						printText[j].removeAttribute("target");
						printText[j].removeAttribute("onclick");
						printText[j].parentElement.style.cursor = 'pointer';
						printText[j].parentElement.setAttribute("onclick","window.print()");
						allImages[i].parentElement.removeAttribute("href");
						allImages[i].parentElement.removeAttribute("target");
						allImages[i].parentElement.removeAttribute("onclick");
						allImages[i].parentElement.setAttribute("href", "#");
					}
				}
				if (duplicateATagExist.length <=0) {
				allImages[i].parentElement.style.cursor = 'pointer';
				allImages[i].parentElement.removeAttribute("href");
				allImages[i].parentElement.removeAttribute("target");
				allImages[i].parentElement.removeAttribute("onclick");
				allImages[i].parentElement.setAttribute("onclick","window.print()");
			    allImages[i].parentElement.setAttribute("href", "#");
				}
	   }
	};
	
});




/*-----------------------Youtube Video Duration-------------------------*/
$(document).ready(function(){ 
if (typeof ytinit == 'function') { 
var ytint = setInterval(function(){if(window.YT){if(window.YT.loaded){clearInterval(ytint);ytinit();}}},1000)
}
});

var ytr = []; 

function getYTIframeDur(){
	vid = this.getAttribute("id");
	try{
		temp = YT.get(vid).getPlayerState()
		document.getElementById(vid).src = document.getElementById(vid).src;
	}catch(e){}
	YT.get(vid).addEventListener("onReady",function(e){
		ytdur = e.target.getDuration()!=0?e.target.getDuration():ytdur;	
		$(e.target.getIframe()).after('<span class="ytduration yt-iframe">'+convertSecToHMS(ytdur)+'</span>')
	}).addEventListener("onStateChange",function(e){if(e.target.getPlayerState()==1){$(e.target.getIframe()).next(".ytduration").remove();$(e.target.getIframe()).remove();}});
	
}

function getYTDur(vid){
var _this=this;
$(this).before('<div style="display:none;" id="yt'+vid+'"></div>');
	temp = new YT.Player("yt"+vid, { 
		videoId: vid,
		playerVars: {autoplay: 0},
		events: {
			onReady:function(e){
				e.target.seekTo(0);
				e.target.pauseVideo(); 
			},
			onStateChange:function(e){					
				if(e.target.getPlayerState()==3){
				ytdur = e.target.getDuration()!=0?e.target.getDuration():ytdur;	
					$(e.target.getIframe()).next().append('<span class="ytduration">'+convertSecToHMS(ytdur)+'</span>');
					$(e.target.getIframe()).remove();
				}
			}
		}
	})
}



function p0(n){
	return Number(n) < 10? "0" + n : n;
}

function convertSecToHMS(totalSeconds){
hours = Math.floor(totalSeconds / 3600);
totalSeconds %= 3600;
minutes = Math.floor(totalSeconds / 60);
seconds = totalSeconds % 60;
string = "";
if(Number(hours)){string+=hours+":";}
string+= (Number(hours)? p0(minutes) : minutes) +":";
string+=p0(Math.ceil(seconds));
return string;
}

//siteimprove
$(document).ready(function(){
	$("html").attr("lang","en");
	$("table").each(function(i){
		$(this).find(".footnoteRefs a").each(function(){
			if(!$(this).attr("aria-label")){
			$(this).attr("aria-label",$($(this).attr("href").replace(/\./g, '\\.'))[0].nextSibling.nodeValue + " t" + (i+1) + "fn");
			}
		});
	});
	$(".thickbox").each(function(){
		if(!$(this).attr("aria-label")){
			$(this).attr("aria-label","more information on " + $(this).attr("href").replace(/.*=/gi,"").replace(/[_\-]/gi," ").replace(/inlinehelp /gi,""))
		}
	});
	$("h1,h2,h3,h4,h5,h6").each(function(){
		if(!$(this).text().match(/[\w]/gi)){
			$(this).remove();
		}
	});
	$("map").each(function(){
		$(this).find('area:not([alt])').each(function(){
			if($(this).attr("title")){
				$(this).attr("alt",$(this).attr("title"));
			}
		})
	});
	$("u").each(function(){
		$(this).wrapInner('<span class="underline"></span>').children().unwrap();
	});
});
