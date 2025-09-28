(function PopupImage()
{
    var pattern, patternNew;
    var imgSelector;
    var url=location.href;
    if (url.match(/photo\.pchome\.com\.tw/))
    {
        pattern = /s\./;
        patternNew = '.';
        imgSelector = 'span>img:first-child';
    }
    else if (url.match(/www\.wretch\.cc\/album\/album\.php/))
    {
        pattern = /thumbs\/t/;
        patternNew = '';
        imgSelector = '.small-c .side>a>img:first-child';
    }
    else if (url.match(/.*\.pixnet\.net\/album\//) || url.match(/.*\.pixnet\.net\/alb\//) )
    {
        pattern = /\/thumb_/;
        patternNew = '/';
        imgSelector = '#contentBody img.thumb';
    }
    //else if (url.match(/www\.flickr\.com\/photos/))
    //{
//        pattern = /_m\.jpg$/;
        //patternNew = '.jpg?v=0';
        //imgSelector = 'a>img[class=pc_img]';
    //}
    else
    {
        alert('此頁面不支援PhotoViewer!');
        return;
    }
    
    var viewportWidth, viewportHeight;
    if (typeof(window.innerWidth) != 'undefined')
    {
        viewportWidth = window.innerWidth;
        viewportHeight = window.innerHeight;
    }
    else if (typeof(document.documentElement) != 'undefined' &&
        typeof(document.documentElement.clientWidth) != 'undefined' &&
        document.documentElement.clientWidth != 0)
    {
        viewportWidth = document.documentElement.clientWidth;
        viewportHeight = document.documentElement.clientHeight;
    }
    else
    {
        viewportWidth = document.body.clientWidth;
        viewportHeight = document.body.clientHeight;
    }
    
    
    $(imgSelector).each(function(){
        $('<img>').addClass('linkImg')
        .attr('src', $(this).attr('src').replace(pattern, patternNew))
        .hide()
        .appendTo($(this).parent()).hide();
    });
    
    
    if ($('img#showImg').length == 0)
    {
        $('<img id=showImg />')
        .attr('src','').attr('alt', 'loading...')
        .css('z-index', '1')
        .css('background-color', 'white')
        .css('color', 'black')
        .hide().appendTo($('body'));        
        
        $('img#showImg')
        .hover(
        function(ev){
            $(ev.target).show();
        },
        function(ev){
            $(ev.target).hide();
        })
        .click(function(ev){
            $(ev.target).hide();
        });
    }

    $(imgSelector).hover(
        function(ev)
        {
            var trueImg=$('img#showImg');
            trueImg.attr('src', $(this).parent().children('img.linkImg').attr('src'));
            if (trueImg.attr('readyState') == 'complete')
                trueImg.attr('alt', '');

            try
            {
                w = trueImg.width();
                h = trueImg.height();
                ratio_w = w/document.documentElement.clientWidth;
                ratio_h = h/document.documentElement.clientHeight;
                ratio = (ratio_w >ratio_h)? ratio_w:ratio_h;
                if (ratio>1)
                    if (ratio_w > ratio_h)
                    {
                        trueImg.width(document.documentElement.clientWidth - 50);
                    }
                    else
                    {
                        trueImg.height(document.documentElement.clientHeight - 50);
                    }
            }
            catch(e)
            {
                alert(e);
            }
         

            trueImg.css('z-index', '65564').show();
        },
        function(ev)
        {
            $('img#showImg').css('z-index', '1').hide();
        }
    );
    
    $(imgSelector).mousemove(
    function(ev)
    {
        var paddingX= 40;
        var paddingY = 40;
       
        var trueImg = $('img#showImg');
        if (trueImg.length > 0)
        {
            if(ev.pageX >= viewportWidth/2)
            {
                x = ev.pageX - trueImg.width() - paddingX;
                offsetX = (typeof(window.pageXOffset)=='undefined') ? ev.pageX - ev.clientX : window.pageXOffset;
                x = (x >= offsetX) ? x: offsetX;
            }
            else
            {
                x = eval(ev.pageX + paddingX);
                dx = (ev.pageX + trueImg.width() + paddingX) - viewportWidth;
                x = (dx > 0) ? x-dx : x;
            }
            
            if (ev.clientY >= viewportHeight/2)
            {
                y = ev.pageY - trueImg.height()- paddingY;
                offsetY = (typeof(window.pageYOffset)=='undefined') ? ev.pageY - ev.clientY : window.pageYOffset;
                y = (y >= offsetY) ? y : offsetY;
            }
            else
            {
                y = eval(ev.pageY + paddingY);
                dy = (viewportHeight -( ev.clientY + trueImg.height()) - paddingY);
                y = (dy >= 0) ? y : y+dy;
            }

            trueImg
            .css({'position':'absolute'})
            .css({'top':y})
            .css({'left':x});
        }
    });
}
)();