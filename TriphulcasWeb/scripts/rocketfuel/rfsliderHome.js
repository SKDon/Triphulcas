(function ($) {
   
  $.fn.rfSlider= function( method, options ) {
      return this.each(function() {        
      // If options exist, lets merge them
      // with our default settings

      var settings = {
        'sliderwidth' : 400,
        'sliderheight' : 200,
        'holder' : '.rfslidemask',
        'slidetime':600,
        'slideinterval':5000,
        'slidetransition':'wipe', // fade or wipe
        'transition':true 
      };
        var slidetimer = null;
        var ismoving= false;
      
      var methods = {
      init: function () {
        var holder = settings.holder;
          $(holder).css('width', settings.sliderwidth+ 'px');
          $(holder).css('height', settings.sliderheight+ 'px');
          $(holder+" .rfslides").css('width', settings.sliderwidth+ 'px');
          $(holder+" .rfslides").css('height', settings.sliderheight+ 'px');
          $(holder+" .rfslides .rfslide").css('width', settings.sliderwidth+ 'px');
          $(holder+" .rfslides .rfslide").css('height', settings.sliderheight+ 'px');
          $(holder).parent().find(".rfprev").bind('click', methods.playprev);
          $(holder).parent().find(".rfnext").bind('click', methods.playnext);
          methods.checkbuttons(settings.holder+" .rfslides", 0);
      },
      slide: function (selector, slidedistance) {
        ismoving= true;
        if(settings.slidetransition=='wipe'){
          var $mover = $(selector);
          $mover.animate({
              marginLeft: slidedistance
          }, settings.slidetime,function() {
            ismoving= false;});
        }
        if(settings.slidetransition=='fade'){
            $(selector).parent().fadeOut('slow', function() {$(selector).css('margin-left',slidedistance+'px');
            $(selector).parent().fadeIn('slow', function() {methods.checkbuttons(selector, slidedistance);ismoving = false;} );
          });
        }
      },
      playprev: function () {
       if(!ismoving){
        var holder = settings.holder+" .rfslides";
          var currentpos = parseInt($(holder).css('margin-left'), 10) + settings.sliderwidth;
          methods.checkbuttons(holder, currentpos);
          methods.slide(holder, currentpos);
        }
      },
      playnext: function () {
        if(!ismoving){
          var holder = settings.holder+" .rfslides";
          var currentpos = parseInt($(holder).css('margin-left'), 10) - settings.sliderwidth;
          methods.checkbuttons(holder, currentpos);
          methods.slide(holder, currentpos);
        }
      },
       resetslider: function (holder) {
        if(!ismoving){
          $(holder).parent().parent().find(".rfprev").fadeOut('slow');
          $(holder).parent().parent().find(".rfnext").fadeOut('slow');
          ismoving = true;
          
          if(settings.slidetransition=='wipe'){
          var totalwidth = ($(holder + " > .rfslide").size()+1) * settings.sliderwidth;
       
          $(holder).css('width', totalwidth + 'px');
          $(settings.holder+" .rfslides .rfslide:eq(0)").clone().appendTo(settings.holder+" .rfslides");
         
           var currentpos = parseInt($(holder).css('margin-left'), 10) - settings.sliderwidth;
           var $mover = $(holder);
          $mover.animate({
              marginLeft: currentpos 
          }, settings.slidetime,function() {
            ismoving= false;
           $(holder).css('margin-left','0px');
            methods.checkbuttons(holder, 0);

          $(settings.holder+" .rfslides .rfslide").last().remove();
          });
        }
        if(settings.slidetransition=='fade'){
            $(holder).parent().fadeOut('slow', function() {$(holder).css('margin-left','0px');
           $(holder).parent().fadeIn('slow', function() {methods.checkbuttons(holder, 0);ismoving = false;} );
           });
        }
         
        }
      },
      checkbuttons: function (holder, currentpos) {
        var totalwidth = $(holder + " > .rfslide").size() * settings.sliderwidth;
        clearTimeout(slidetimer);
          if (totalwidth <= settings.sliderwidth) {
              $(holder).css('width', settings.sliderwidth+ 'px');
              $(holder).parent().parent().find(".rfprev").hide();
              $(holder).parent().parent().find(".rfnext").hide();
          } else {
              $(holder).css('width', totalwidth + 'px');
              if (currentpos == 0) {
                  $(holder).parent().parent().find(".rfprev").fadeOut('slow');
                  $(holder).parent().parent().find(".rfnext").fadeIn('slow');
                if(settings.transition)
                  slidetimer  = setTimeout(function(){$(holder).parent().parent().find(".rfnext").trigger('click')},settings.slideinterval);
              } else if (totalwidth == Math.abs(currentpos) + settings.sliderwidth) {
                  $(holder).parent().parent().find(".rfprev").fadeIn('slow');
                  $(holder).parent().parent().find(".rfnext").fadeOut('slow');
                if(settings.transition)
                  slidetimer = setTimeout(function(){methods.resetslider(holder);},settings.slideinterval);
              } else {
                  $(holder).parent().parent().find(".rfprev").fadeIn('slow');
                  $(holder).parent().parent().find(".rfnext").fadeIn('slow');
                if(settings.transition)
                  slidetimer = setTimeout(function(){$(holder).parent().parent().find(".rfnext").trigger('click')},settings.slideinterval);
              }
          }
      } 
    }; //end methods

      if ( options ) { 
        $.extend( settings, options );
      }
    // Method calling logic
    if ( methods[method] ) {
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof method === 'object' || ! method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  method + ' does not exist on jQuery.RocketfuelSlider' );
    } 

    });
  };

})(jQuery);