/**
 * jQuery lightBox plugin
 * This jQuery plugin was inspired and based on Lightbox 2 by Lokesh Dhakar (http://www.huddletogether.com/projects/lightbox2/)
 * and adapted to me for use like a plugin from jQuery.
 * @name jquery-lightbox-0.5.js
 * @author Leandro Vieira Pinho - http://leandrovieira.com
 * @version 0.5
 * @date April 11, 2008
 * @category jQuery plugin
 * @copyright (c) 2008 Leandro Vieira Pinho (leandrovieira.com)
 * @license CCAttribution-ShareAlike 2.5 Brazil - http://creativecommons.org/licenses/by-sa/2.5/br/deed.en_US
 * @example Visit http://leandrovieira.com/projects/jquery/lightbox/ for more informations about this jQuery plugin
 */

// Offering a Custom Alias suport - More info: http://docs.jquery.com/Plugins/Authoring#Custom_Alias
(function($) {
	/**
	 * $ is an alias to jQuery object
	 *
	 */
	$.fn.lightBox = function(settings) {
		// Settings to configure the jQuery lightBox plugin how you like
		settings = jQuery.extend({
			// Configuration related to overlay
			overlayBgColor: 		'#000',		// (string) Background color to overlay; inform a hexadecimal value like: #RRGGBB. Where RR, GG, and BB are the hexadecimal values for the red, green, and blue values of the color.
			overlayOpacity:			0.8,		// (integer) Opacity value to overlay; inform: 0.X. Where X are number from 0 to 9
			// Configuration related to navigation
			fixedNavigation:		false,		// (boolean) Boolean that informs if the navigation (next and prev button) will be fixed or not in the interface.
			// Configuration related to images
			imageLoading:			'js/jquery-lightbox-0.5/images/lightbox-ico-loading.gif',		// (string) Path and the name of the loading icon
			imageBtnPrev:			'js/jquery-lightbox-0.5/images/lightbox-btn-prev.gif',			// (string) Path and the name of the prev button image
			imageBtnNext:			'js/jquery-lightbox-0.5/images/lightbox-btn-next.gif',			// (string) Path and the name of the next button image
			imageBtnClose:			'js/jquery-lightbox-0.5/images/lightbox-btn-close.gif',		// (string) Path and the name of the close btn
			imageBlank:				'js/jquery-lightbox-0.5/images/lightbox-blank.gif',			// (string) Path and the name of a blank image (one pixel)
			// Configuration related to container image box
			containerBorderSize:	10,			// (integer) If you adjust the padding in the CSS for the container, #lightbox-container-image-box, you will need to update this value
			containerResizeSpeed:	400,		// (integer) Specify the resize duration of container image. These number are miliseconds. 400 is default.
			// Configuration related to texts in caption. For example: Image 2 of 8. You can alter either "Image" and "of" texts.
			txtImage:				'Image',	// (string) Specify text "Image"
			txtOf:					'of',		// (string) Specify text "of"
			// Configuration related to keyboard navigation
			keyToClose:				'c',		// (string) (c = close) Letter to close the jQuery lightBox interface. Beyond this letter, the letter X and the SCAPE key is used to.
			keyToPrev:				'p',		// (string) (p = previous) Letter to show the previous image
			keyToNext:				'n',		// (string) (n = next) Letter to show the next image.
			// Don磘 alter these variables in any way
			imageArray:				[],
			activeImage:			0,
			drag : true ,//hjz     
			isDraggable : false 
		},settings);
		// Caching the jQuery object with all elements matched
		var jQueryMatchedObj = this; // This, in this context, refer to jQuery object
		/**
		 * Initializing the plugin calling the start function
		 *
		 * @return boolean false
		 */
		function _initialize() {
			_start(this,jQueryMatchedObj); // This, in this context, refer to object (link) which the user have clicked
			return false; // Avoid the browser following the link
		}
		/**
		 * Start the jQuery lightBox plugin
		 *
		 * @param object objClicked The object (link) whick the user have clicked
		 * @param object jQueryMatchedObj The jQuery object with all elements matched
		 */
		function _start(objClicked,jQueryMatchedObj) {
			// Hime some elements to avoid conflict with overlay in IE. These elements appear above the overlay.
			$(parent.window.document).find('embed, object, select').css({ 'visibility' : 'hidden' });
			// Call the function to create the markup structure; style some elements; assign events in some elements.
			_set_interface();
			// Unset total images in imageArray
			settings.imageArray.length = 0;
			// Unset image active information
			settings.activeImage = 0;
			// We have an image set? Or just an image? Let磗 see it.
			if ( jQueryMatchedObj.length == 1 ) {
				settings.imageArray.push(new Array(objClicked.getAttribute('href'),objClicked.getAttribute('title')));
			} else {
				// Add an Array (as many as we have), with href and title atributes, inside the Array that storage the images references		
				for ( var i = 0; i < jQueryMatchedObj.length; i++ ) {
					settings.imageArray.push(new Array(jQueryMatchedObj[i].getAttribute('href'),jQueryMatchedObj[i].getAttribute('title')));
				}
			}
			while ( settings.imageArray[settings.activeImage][0] != objClicked.getAttribute('href') ) {
				settings.activeImage++;
			}
			// Call the function that prepares image exibition
			_set_image_to_view();
		}
		/**
		 * Create the jQuery lightBox plugin interface
		 *
		 * The HTML markup will be like that:
			<div id="jquery-overlay"></div>
			<div id="jquery-lightbox">
				<div id="lightbox-container-image-box">
					<div id="lightbox-container-image">
						<img src="../fotos/XX.jpg" id="lightbox-image">
						<div id="lightbox-nav">
							<a href="#" id="lightbox-nav-btnPrev"></a>
							<a href="#" id="lightbox-nav-btnNext"></a>
						</div>
						<div id="lightbox-loading">
							<a href="#" id="lightbox-loading-link">
								<img src="../images/lightbox-ico-loading.gif">
							</a>
						</div>
					</div>
				</div>
				<div id="lightbox-container-image-data-box">
					<div id="lightbox-container-image-data">
						<div id="lightbox-image-details">
							<span id="lightbox-image-details-caption"></span>
							<span id="lightbox-image-details-currentNumber"></span>
						</div>
						<div id="lightbox-secNav">
							<a href="#" id="lightbox-secNav-btnClose">
								<img src="../images/lightbox-btn-close.gif">
							</a>
						</div>
					</div>
				</div>
			</div>
		 *
		 */
		function _set_interface() {
			var pop_iv_bg = "pop_iv_bg";
			if($.browser.msie && $.browser.version == "6.0") {
			  pop_iv_bg = "pop_iv_bg_ie6";
			}
			// Apply the HTML markup into body tag
			$(parent.window.document).find('body').append('<div id="jquery-overlay"></div><div id="jquery-lightbox"><div id="lightbox-container-image-box"><div id="lightbox-container-image"><img id="lightbox-image" exif="true"><div style="" id="lightbox-nav"</div><div id="lightbox-loading"></div></div></div><div id="lightbox-container-image-data-box"><div id="lightbox-container-image-data"><div id="lightbox-image-details"><span id="lightbox-image-details-caption"></span><span id="lightbox-image-details-currentNumber"></span></div></div></div></div>');
			
			$(parent.window.document).find('body').append('<div id="jquery-lightbox-nav"><div id="jquery-lightbox-wrap"><div class="'+pop_iv_bg+' inner"><span class="'+pop_iv_bg+' l">&nbsp;</span><ul><li><span class="op op_equal"><a class="'+pop_iv_bg+'" title="原图大小" href="javascript:void(0)">原图大小</a></span><span class="op op_size displayNone"><a class="'+pop_iv_bg+'" title="适合尺寸" href="javascript:void(0)">适合尺寸</a></span></li><li><span class="op op_line"><span class="'+pop_iv_bg+'">&nbsp;</span></span><span class="op op_prev"><a id="lightbox-nav-btnPrev" class="'+pop_iv_bg+'" style="cursor: pointer;" title="上一页">上一页</a></span></li><li><span class="op op_next"><a id="lightbox-nav-btnNext" class="'+pop_iv_bg+'" style="cursor: pointer;" title="下一页">下一页</a></span></li><li><span class="op op_line"><span class="'+pop_iv_bg+'">&nbsp;</span></span><span class="op op_close"><a class="'+pop_iv_bg+'" id="lightbox-secNav-btnClose" title="关闭" href="javascript:void(0)">关闭</a></span></li></ul><span class="'+pop_iv_bg+' r">&nbsp;</span></div></div></div>');
			// Get page sizes
			var arrPageSizes = ___getPageSize();
			
			
			// Style overlay and show it
			$(parent.window.document).find('#jquery-overlay').css({
				backgroundColor:	settings.overlayBgColor,
				opacity:			settings.overlayOpacity,
				width:				arrPageSizes[0],
				height:				arrPageSizes[1]
			}).fadeIn();
			// Get page scroll
			var arrPageScroll = ___getPageScroll();
			// Calculate top and left offset for the jquery-lightbox div object and show it
			$(parent.window.document).find('#jquery-lightbox').css({
				top:	arrPageScroll[1] + (arrPageSizes[3] / 10),
				left:	arrPageScroll[0]
			}).show();
			// Assigning click events in elements to close overlay
			$(parent.window.document).find('#jquery-overlay,#jquery-lightbox').click(function() {
				//if(!settings.isDraggable)
				//_finish();									
			});
			
			
			// Assign the _finish function to lightbox-loading-link and lightbox-secNav-btnClose objects
			$(parent.window.document).find('#lightbox-loading-link,#lightbox-secNav-btnClose').click(function() {
				_finish();
				return false;
			});

			// If window was resized, calculate the new overlay dimensions
			$(window).resize(function() {
				// Get page sizes
				var arrPageSizes = ___getPageSize();
				// Style overlay and show it
				$(parent.window.document).find('#jquery-overlay').css({
					width:		arrPageSizes[0],
					height:		arrPageSizes[1]
				});
				// Get page scroll
				var arrPageScroll = ___getPageScroll();
				// Calculate top and left offset for the jquery-lightbox div object and show it
				$(parent.window.document).find('#jquery-lightbox').css({
					top:	arrPageScroll[1] + (arrPageSizes[3] / 10),
					left:	arrPageScroll[0]
				});
				$(parent.window.document).find("#jquery-lightbox-nav").css({top:$(parent.window).height() - 50}).show();//hjz
				
				
			});
			if($.browser.msie) {
			  $(parent.window.document).find("html").css("overflow","hidden");//hjz
			} else {
			  $(parent.window.document).find("body").css("overflow","hidden");//hjz
			  //$(parent.window.document).find("#mainIframe").attr("scrolling","no");
			}
			

			$(parent.window.document).find("#jquery-lightbox-nav").css({top:$(parent.window).height() - 50}).show();//hjz
		}
		/**
		 * Prepares image exibition; doing a image磗 preloader to calculate it磗 size
		 *
		 */
		function _set_image_to_view() { // show the loading
			parent.DCampus.IndexUI.dragPhoto();//hjz	
			// Show the loading
			$(parent.window.document).find('#lightbox-loading').html('<a href="#" id="lightbox-loading-link"><img src="' + settings.imageLoading + '"/></a>').show();
			if ( settings.fixedNavigation ) {
				$(parent.window.document).find('#lightbox-image,#lightbox-container-image-data-box,#lightbox-image-details-currentNumber').hide();
			} else {
				// Hide some elements
				$(parent.window.document).find('#lightbox-image,#lightbox-nav,#lightbox-container-image-data-box,#lightbox-image-details-currentNumber').hide();
			}
			// Image preload process
			var objImagePreloader = new Image();
			$(parent.window.document).find('#lightbox-image').attr('src',"js/jquery-lightbox-0.5/images/blank.gif");//预览一张空白图
			//var saveWidth,saveHeight;
			objImagePreloader.onload = function() {
				$(parent.window.document).find('#lightbox-image').attr('src',settings.imageArray[settings.activeImage][0]);
				// Perfomance an effect in the image container resizing it
				_resize_container_image_box(objImagePreloader.width,objImagePreloader.height);
				//	clear onLoad, IE behaves irratically with animated gifs otherwise
				objImagePreloader.onload=function(){};
			};
			
			try {
			  $(window).resize(function(){
				  _resize_container_image_box(objImagePreloader.width,objImagePreloader.height);
				  $(parent.window.document).find(".op_equal").removeClass("displayNone");
				  $(parent.window.document).find(".op_size").addClass("displayNone");
			  });
			  objImagePreloader.src = settings.imageArray[settings.activeImage][0];	
			} catch(e){}
			
			$(parent.window.document).find(".op_equal a").unbind().bind("click",function(){	
				$(this).parent().addClass("displayNone");
				_original_resize_container_image_box(objImagePreloader.width,objImagePreloader.height);
				$(parent.window.document).find(".op_size").removeClass("displayNone");
			});
			var arrPageScroll = ___getPageScroll();
			var arrPageSizes = ___getPageSize();
			$(parent.window.document).find(".op_size a").unbind().bind("click",function(){
				_resize_container_image_box(objImagePreloader.width,objImagePreloader.height);
				$(parent.window.document).find('#jquery-lightbox').css({
					top:	arrPageScroll[1] + (arrPageSizes[3] / 10),
					left:	arrPageScroll[0]
				});				
				$(this).parent().addClass("displayNone");
				$(parent.window.document).find(".op_equal").removeClass("displayNone");			   
			});			
			
		};
		/**
		 * Perfomance an effect in the image container resizing it
		 *
		 * @param integer intImageWidth The image磗 width that will be showed
		 * @param integer intImageHeight The image磗 height that will be showed
		 */
		function _resize_container_image_box(intImageWidth,intImageHeight) {
			// Get current width and height
			var intCurrentWidth = $(parent.window.document).find('#lightbox-container-image-box').width();
			var intCurrentHeight = $(parent.window.document).find('#lightbox-container-image-box').height();
			// Get the width and height of the selected image plus the padding
			
			var saveWidth = intImageWidth;
			var saveHeight = intImageHeight;
            if(saveHeight >= $(window).height() - 180 || saveWidth >= $(window).width()) {
				 intImageHeight = $(window).height() - 200;   
				 intImageWidth  =   saveWidth / saveHeight * intImageHeight;
				 if(intImageWidth > $(window).width()) {
					 intImageWidth = $(window).width() - 200;
					 intImageHeight  =   intImageWidth / saveWidth * saveHeight ;				   
				 }
				 $(parent.window.document).find("#lightbox-image").width(intImageWidth).height(intImageHeight);
			} else {
                  _original_resize_container_image_box(intImageWidth,intImageHeight);
			}	//hjz


			
			var intWidth = (intImageWidth + (settings.containerBorderSize * 2)); // Plus the image磗 width and the left and right padding value
			var intHeight = (intImageHeight + (settings.containerBorderSize * 2)); // Plus the image磗 height and the left and right padding value
			
			
			// Diferences
			var intDiffW = intCurrentWidth - intWidth;
			var intDiffH = intCurrentHeight - intHeight;
			// Perfomance the effect
			$(parent.window.document).find('#lightbox-container-image-box').width(intWidth).height(intHeight);
			_show_image();
			if ( ( intDiffW == 0 ) && ( intDiffH == 0 ) ) {
				if ( $.browser.msie ) {
					___pause(250);
				} else {
					___pause(100);	
				}
			} 
			$(parent.window.document).find('#lightbox-container-image-data-box').css({ width: intImageWidth });
			//$('#lightbox-nav-btnPrev,#lightbox-nav-btnNext').css({ height: intImageHeight + (settings.containerBorderSize * 2) });
		};
		
		function _original_resize_container_image_box(intImageWidth,intImageHeight) {
			// Get current width and height
			var intCurrentWidth = $(parent.window.document).find('#lightbox-container-image-box').width();
			var intCurrentHeight = $(parent.window.document).find('#lightbox-container-image-box').height();
			// Get the width and height of the selected image plus the padding

			var intWidth = (intImageWidth + (settings.containerBorderSize * 2)); // Plus the image磗 width and the left and right padding value
			var intHeight = (intImageHeight + (settings.containerBorderSize * 2)); // Plus the image磗 height and the left and right padding value
			
			$(parent.window.document).find("#lightbox-image").width(intImageWidth).height(intImageHeight);
			// Diferences
			var intDiffW = intCurrentWidth - intWidth;
			var intDiffH = intCurrentHeight - intHeight;
			// Perfomance the effect
			$(parent.window.document).find('#lightbox-container-image-box').width(intWidth).height(intHeight);
			_show_image();
			if ( ( intDiffW == 0 ) && ( intDiffH == 0 ) ) {
				if ( $.browser.msie ) {
					___pause(250);
				} else {
					___pause(100);	
				}
			} 
			$(parent.window.document).find('#lightbox-container-image-data-box').css({ width: intImageWidth });
			//$('#lightbox-nav-btnPrev,#lightbox-nav-btnNext').css({ height: intImageHeight + (settings.containerBorderSize * 2) });
		};		
		/**
		 * Show the prepared image
		 *
		 */
		function _show_image() {
			
			
			var arrPageScroll = ___getPageScroll();
			var arrPageSizes = ___getPageSize();
			$(parent.window.document).find('#jquery-lightbox').css({
				top:	arrPageScroll[1] + (arrPageSizes[3] / 10),
				left:	arrPageScroll[0]
			});					
			$(parent.window.document).find('#lightbox-loading').empty().hide();
			$(parent.window.document).find('#lightbox-image').fadeIn(function() {
				_show_image_data();
				_set_navigation();
			});
			_preload_neighbor_images();
	
		};
		/**
		 * Show the image information
		 *
		 */
		function _show_image_data() {
			$(parent.window.document).find('#lightbox-container-image-data-box').slideDown('fast');
			$(parent.window.document).find('#lightbox-image-details-caption').hide();
			try {
				if ( settings.imageArray[settings.activeImage][1] ) {
					$('#lightbox-image-details-caption').html(settings.imageArray[settings.activeImage][1]).show();
				}
				// If we have a image set, display 'Image X of X'
				if ( settings.imageArray.length > 1 ) {
					$(parent.window.document).find('#lightbox-image-details-currentNumber').html(settings.txtImage + ' ' + ( settings.activeImage + 1 ) + ' ' + settings.txtOf + ' ' + settings.imageArray.length).show();
				}	
			} catch(e) {
			
			}
		}
		/**
		 * Display the button navigations
		 *
		 */
		function _set_navigation() {
			$(parent.window.document).find('#lightbox-nav').show();
			// Instead to define this configuration in CSS file, we define here. And it磗 need to IE. Just.
			//$('#lightbox-nav-btnPrev,#lightbox-nav-btnNext').css({ 'background' : 'transparent url(' + settings.imageBlank + ') no-repeat' });
			
			// Show the prev button, if not the first image in set
			if ( settings.activeImage != 0 ) {
				if ( settings.fixedNavigation ) {
					$(parent.window.document).find('#lightbox-nav-btnPrev')
						.unbind()
						.bind('click',function() {
							settings.activeImage = settings.activeImage - 1;
							_set_image_to_view();
							$(parent.window.document).find(".op_equal").removeClass("displayNone");
							$(parent.window.document).find(".op_size").addClass("displayNone");					
							return false;
						});
				} else {
					// Show the images button for Next buttons
					$(parent.window.document).find('#lightbox-nav-btnPrev').unbind().hover(function() {
						//$(this).css({ 'background' : 'url(' + settings.imageBtnPrev + ') left 15% no-repeat' });
					},function() {
						//$(this).css({ 'background' : 'transparent url(' + settings.imageBlank + ') no-repeat' });
					}).bind('click',function() {
						settings.activeImage = settings.activeImage - 1;
						_set_image_to_view();
						$(parent.window.document).find(".op_equal").removeClass("displayNone");
						$(parent.window.document).find(".op_size").addClass("displayNone");					
						return false;
					}).parent().parent().show();
				}
			} else {
			  $(parent.window.document).find('#lightbox-nav-btnPrev').parent().parent().hide();
			}
			
			// Show the next button, if not the last image in set
			if ( settings.activeImage != ( settings.imageArray.length -1 ) ) {
				if ( settings.fixedNavigation ) {
					$(parent.window.document).find('#lightbox-nav-btnNext')
						.unbind()
						.bind('click',function() {
							settings.activeImage = settings.activeImage + 1;
							_set_image_to_view();
							$(parent.window.document).find(".op_equal").removeClass("displayNone");
							$(parent.window.document).find(".op_size").addClass("displayNone");
							return false;
						});
				} else {
					// Show the images button for Next buttons
					$(parent.window.document).find('#lightbox-nav-btnNext').unbind().hover(function() {
						//$(this).css({ 'background' : 'url(' + settings.imageBtnNext + ') right 15% no-repeat' });
					},function() {
						//$(this).css({ 'background' : 'transparent url(' + settings.imageBlank + ') no-repeat' });
					}).bind('click',function() {
						settings.activeImage = settings.activeImage + 1;
						_set_image_to_view();
						$(parent.window.document).find(".op_equal").removeClass("displayNone");
						$(parent.window.document).find(".op_size").addClass("displayNone");					
						return false;
					}).parent().parent().show();
				}
			} else {
			  	 $(parent.window.document).find('#lightbox-nav-btnNext').parent().parent().hide();
			}
			// Enable keyboard navigation
			_enable_keyboard_navigation();
		}
		/**
		 * Enable a support to keyboard navigation
		 *
		 */
		function _enable_keyboard_navigation() {
			$(document).keydown(function(objEvent) {
				_keyboard_action(objEvent);
			});
		}
		/**
		 * Disable the support to keyboard navigation
		 *
		 */
		function _disable_keyboard_navigation() {
			$(document).unbind();
		}
		/**
		 * Perform the keyboard actions
		 *
		 */
		function _keyboard_action(objEvent) {
			// To ie
			if ( objEvent == null ) {
				keycode = event.keyCode;
				escapeKey = 27;
			// To Mozilla
			} else {
				keycode = objEvent.keyCode;
				escapeKey = objEvent.DOM_VK_ESCAPE;
			}
			// Get the key in lower case form
			key = String.fromCharCode(keycode).toLowerCase();
			// Verify the keys to close the ligthBox
			if ( ( key == settings.keyToClose ) || ( key == 'x' ) || ( keycode == escapeKey ) ) {
				_finish();
			}
			// Verify the key to show the previous image
			if ( ( key == settings.keyToPrev ) || ( keycode == 37 ) ) {
				// If we磖e not showing the first image, call the previous
				if ( settings.activeImage != 0 ) {
					settings.activeImage = settings.activeImage - 1;
					_set_image_to_view();
					_disable_keyboard_navigation();
				}
			}
			// Verify the key to show the next image
			if ( ( key == settings.keyToNext ) || ( keycode == 39 ) ) {
				// If we磖e not showing the last image, call the next
				if ( settings.activeImage != ( settings.imageArray.length - 1 ) ) {
					settings.activeImage = settings.activeImage + 1;
					_set_image_to_view();
					_disable_keyboard_navigation();
				}
			}
		}
		/**
		 * Preload prev and next images being showed
		 *
		 */
		function _preload_neighbor_images() {
			if ( (settings.imageArray.length -1) > settings.activeImage ) {
				objNext = new Image();
				objNext.src = settings.imageArray[settings.activeImage + 1][0];
			}
			if ( settings.activeImage > 0 ) {
				objPrev = new Image();
				objPrev.src = settings.imageArray[settings.activeImage -1][0];
			}
		}
		/**
		 * Remove jQuery lightBox plugin HTML markup
		 *
		 */
		function _finish() {
			$(parent.window.document).find('#jquery-lightbox').remove();
			$(parent.window.document).find('#jquery-overlay').fadeOut(function() { $(parent.window.document).find('#jquery-overlay').remove();
				if($.browser.msie) {
				  $(parent.window.document).find("html").css("overflow","");//hjz
				} else {
				  $(parent.window.document).find("body").css("overflow","");//hjz
				  //$(parent.window.document).find("#mainIframe").attr("scrolling","auto");
				}																				  
			});
			// Show some elements to avoid conflict with overlay in IE. These elements appear above the overlay.
			$(parent.window.document).find('embed, object, select').css({ 'visibility' : 'visible' });

			$(parent.window.document).find("#jquery-lightbox-nav").remove();//hjz
		}
		/**
		 / THIRD FUNCTION
		 * getPageSize() by quirksmode.com
		 *
		 * @return Array Return an array with page width, height and window width, height
		 */
		function ___getPageSize() {
			var xScroll, yScroll;
			if (parent.window.innerHeight && parent.window.scrollMaxY) {	
				xScroll = parent.window.innerWidth + parent.window.scrollMaxX;
				yScroll = parent.window.innerHeight + parent.window.scrollMaxY;
			} else if (parent.document.body.scrollHeight > parent.document.body.offsetHeight){ // all but Explorer Mac
				xScroll = parent.document.body.scrollWidth;
				yScroll = parent.document.body.scrollHeight;
			} else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
				xScroll = parent.document.body.offsetWidth;
				yScroll = parent.document.body.offsetHeight;
			}
			var windowWidth, windowHeight;
			if (parent.self.innerHeight) {	// all except Explorer
				if(parent.document.documentElement.clientWidth){
					windowWidth = parent.document.documentElement.clientWidth; 
				} else {
					windowWidth = parent.self.innerWidth;
				}
				windowHeight = parent.self.innerHeight;
			} else if (parent.document.documentElement && parent.document.documentElement.clientHeight) { // Explorer 6 Strict Mode
				windowWidth = parent.document.documentElement.clientWidth;
				windowHeight = parent.document.documentElement.clientHeight;
			} else if (parent.document.body) { // other Explorers
				windowWidth = parent.document.body.clientWidth;
				windowHeight = parent.document.body.clientHeight;
			}	
			// for small pages with total height less then height of the viewport
			if(yScroll < windowHeight){
				pageHeight = windowHeight;
			} else { 
				pageHeight = yScroll;
			}
			// for small pages with total width less then width of the viewport
			if(xScroll < windowWidth){	
				pageWidth = xScroll;		
			} else {
				pageWidth = windowWidth;
			}
			arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight);
			return arrayPageSize;
		};
		/**
		 / THIRD FUNCTION
		 * getPageScroll() by quirksmode.com
		 *
		 * @return Array Return an array with x,y page scroll values.
		 */
		function ___getPageScroll() {
			var xScroll, yScroll;
			if (self.pageYOffset) {
				yScroll = self.pageYOffset;
				xScroll = self.pageXOffset;
			} else if (document.documentElement && document.documentElement.scrollTop) {	 // Explorer 6 Strict
				yScroll = document.documentElement.scrollTop;
				xScroll = document.documentElement.scrollLeft;
			} else if (document.body) {// all other Explorers
				yScroll = document.body.scrollTop;
				xScroll = document.body.scrollLeft;	
			}
			arrayPageScroll = new Array(xScroll,yScroll);
			return arrayPageScroll;
		};
		 /**
		  * Stop the code execution from a escified time in milisecond
		  *
		  */
		 function ___pause(ms) {
			var date = new Date(); 
			curDate = null;
			do { var curDate = new Date(); }
			while ( curDate - date < ms);
		 };
		// Return the jQuery object for chaining. The unbind method is used to avoid click conflict when the plugin is called more than once
		return this.unbind('click').click(_initialize);
	};
})(jQuery); // Call and execute the function immediately passing the jQuery object