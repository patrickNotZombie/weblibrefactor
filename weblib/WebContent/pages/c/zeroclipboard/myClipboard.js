
var client=null;
var clipBoardText=null;
	  
function initClipboard() {//console.log(client);
	
	
		client = new ZeroClipboard( $(".clipBoardButton") );
		
		client.on( 'ready', function(event) {
			//console.log( 'movie is loaded' );
			
			client.on( 'copy', function(event) {
				//event.clipboardData.setData('text/plain', "11");
				
			} );
			
			client.on( 'aftercopy', function(event) {
				//console.log('Copied text to clipboard: ' + event.data['text/plain']);
			} );
		} );
		
		client.on( 'error', function(event) {
			//console.log( 'ZeroClipboard error of type "' + event.name + '": ' + event.message );
			ZeroClipboard.destroy();
		} );
	
}

function setClipboardText(text) {//console.log(text);
	if (/MSIE\s+8.0/i.test(navigator.userAgent)||/MSIE\s+7.0/i.test(navigator.userAgent)) {
		
		clipBoardText=text;
	}else{
		
			initClipboard();
		
		client.setText(text);
	}
}

function clipButtonClick(){
	
	if (/MSIE\s+8.0/i.test(navigator.userAgent)||/MSIE\s+7.0/i.test(navigator.userAgent)) {
		window.clipboardData.setData("Text", clipBoardText); 
	}
}

var modalHtml="<div class='cModalMask' style='position: absolute;left: 0px;top: 0px;width: 4000px;height: 3000px;z-index: 800000;overflow: hidden;cursor: default;background:none #000000 !important;opacity:0.6 !important;filter:alpha(opacity=60) !important;'></div>"
function setShowModalMask(show) {
	if($(".cModalMask").length==0){
		$("body").append(modalHtml);
	}
	if(show==1){
		$(".cModalMask").show();
	}else{
		$(".cModalMask").hide();
	}
	
}
