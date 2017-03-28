;(function($) {

function load(settings, root, child, container) {

	$.ajax({

	   url:settings.url,

	   dataType: "json",
 
        data : "parentId="+resourceJSON.parentId+"&type=tree",

	   error:function(){$j("body").message({message:"请刷新",warning:true});},

	   success:function(response){
		function createNode(parent) {
					var current = $("<li/>").attr("id", this.id || "").html("<span class='folder'>&nbsp;</span><a href='javascript:void(0)' id='"+this.id+"'>"+this.text+"</a><b></b>").appendTo(parent);

					if (this.hasChildren || this.children && this.children.length) {

						var branch = $("<ul/>").appendTo(current);

						if (this.hasChildren) {

							current.addClass("hasChildren");

			              	createNode.call({

								text:"placeholder",

								id:"placeholder",

								children:[]

							}, branch);

						}

					}

					current.parent().parent().find("div").removeClass("treeLoading");				

				}

				$.each(response, createNode, [child]);
				$(container).treeview({add: child});

               
		}

	});
}


function loadChildren(settings, root, child, container) {

	$.ajax({

	   url:settings.url,

	   dataType: "json",

	   data:"parentId="+root+"&type=tree",

	   error:function(){$j("body").message({message:"请刷新",warning:true});},

	   success:function(response){
		function createNode(parent) {	

	var current = $("<li/>").attr("id", this.id || "").html("<span class='folder'>&nbsp;</span><a id='"+this.id+"' href='javascript:void(0)'>"+this.text+"</a>").appendTo(parent);
					if (this.hasChildren || this.children && this.children.length) {

						var branch = $("<ul/>").appendTo(current);

						if (this.hasChildren) {

							current.addClass("hasChildren");

							current.find("a").eq(0).replaceWith("<a href='javascript:void(0)' class='childNode' id='"+this.id+"'>"+this.text+"</a><b></b>");

			              	createNode.call({

								text:"placeholder",

								id:"placeholder",

								children:[]

							}, branch);

						} 

					}

					current.parent().parent().find("div").removeClass("treeLoading");

				}
				$.each(response, createNode, [child]);

				$(container).treeview({add: child});



		}

	});
}


var proxied = $.fn.treeview;

$.fn.treeview = function(settings) {

	if (!settings.url) {

		return proxied.apply(this, arguments);

	}

	var container = this;

	load(settings, 0, this, container);

	var userToggle = settings.toggle;

	return proxied.call(this, $.extend({}, settings, {

		collapsed: true,

		toggle: function() {
			var $this = $(this);

		    if($(this).find("ul").eq(0).find("li").eq(0).attr("id")== "placeholder") {

				$(this).find("div").addClass("treeLoading");

			}
		   if($this.attr("class") == "hasChildren collapsable" || $this.attr("class") == "hasChildren collapsable lastCollapsable" || $this.attr("class") == "collapsable" || $this.attr("class") == "collapsable lastCollapsable") {
			  $this.children().eq(1).addClass("folderOpen");	
			} else {
			  $this.children().eq(1).removeClass("folderOpen");
			}
			if ($this.hasClass("hasChildren")) {

				var childList = $this.removeClass("hasChildren").find("ul");

				childList.empty();

				loadChildren(settings, this.id, childList, container);

			}

			if (userToggle) {

				userToggle.apply(this, arguments);

			}

		}

	}));

};



})(jQuery);