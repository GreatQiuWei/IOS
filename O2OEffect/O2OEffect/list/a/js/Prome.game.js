// PG = PromeGame
;var PG=(function(){
    /* 获取浏览器信息 */
	var ua=navigator.userAgent.toLowerCase();
	var isMac=ua.indexOf("mac")>=0;
	var windowW=$(window).width();
	var windowH=$(window).height();
	/* 基础游戏设置 */
    var gameInterval;
    var gameFps=1000/60;
    var gameVersion=1.01;
    /* 创建声音控制相关 */
    var audioChannels=[];
    var audioChannelsNum=10;

    /* 基础页面元素 */
	var $message=$('#message');
	var $messageBg=$('#message .bg');
	var $messagePanel=$('#message .panel');
	var $messageBtn=$('#message .panel .btn');
	var $messageText=$('#message .panel .text');
	var $messageClose=$('#message .panel .close');
	var $messageStart=$('#message .start');
	var $loading=$('#loading');
    var $pageLead=$('#pageLead');
	var $pageIndex=$('#pageIndex');

    /* 扩展页面元素 */
    var $pageInfo=$('#pageInfo');
    var $sentBtn=$('.sentBtn');
    var $sex=$('.sex');
    var $pageResult=$('#pageResult');
    var $pageChart=$('#pageChart');
    var $pageGameDes=$('#pageGameDes');


    /* 基础游戏元素 */
	var $gameArea=$('.gameArea');
	var $gameStartMask=$('.gameStartMask');
    var $sprite=$('.sprite');

    /* 扩展游戏元素 */
    var $gamePoints=$('.initPanel .points span');
    var $gameTimer=$('.initPanel .time');
    var $gameControlBtn=$('.initPanel .controlBtn');

    /* 扩展游戏设置 */
	var isGameStart=false,isGamePause=false,isHasSentInfo=false;
    var gamePoints=0;
    var gameModel;
    var actCount=0;
    var gameTimer=60*1000;
    var level=[2, 3, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 8, 8, 8, 8, 9];
    var dlevel=[4,4,6,6,6,6,6,6,8];
	var messageAry=[
	
    ];
    var resourceAry=[
        // { 'type':'audio' , 'url':'music/bg.mp3'},
        { 'type':'image' , 'url':'images/btn_d.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/btn_s.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/ele1.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/ele2.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/ele3.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/ele4.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/finger.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/gift.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/pageLead_bottom.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/pageLead_top.png?v='+gameVersion},
        { 'type':'image' , 'url':'images/triangleBg.jpg?v='+gameVersion}
    ];

    /* 外层操作设置 */
    var regName=/^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]){2,4}$/;
    var regPhone=/^1\d{10}$/;
    var sexNo=0; //0：男，1：女

    /* 事件控制 */

    $sprite.on('touchend','.box',function(){
        if($(this).hasClass('target')){
            if(gameModel=='double'&&!$(this).hasClass('act')){
                actCount++;
                if(actCount>1){
                    gamePoints++;
                    $gamePoints.html(gamePoints*2);
                    if(gamePoints>=dlevel.length) setDoubleBoxs(dlevel[dlevel.length-1]);
                    else setDoubleBoxs(dlevel[gamePoints]);
                    $('#test').html(gamePoints); 
                }else{
                    $(this).addClass('act');
                }
                
            }
            if(gameModel=='single'){
                gamePoints++;
                $gamePoints.html(gamePoints);
                if(gamePoints>=level.length) setSingleBoxs(level[level.length-1]);
                else setSingleBoxs(level[gamePoints]);
                $('#test').html(gamePoints);
            }
            
        }
    });

    $gameControlBtn.on('touchend',function(){
        if(isGamePause){
            isGamePause=false;
        }else{
            isGamePause=true;
        }
    });

    $sentBtn.on('touchend',function(){
        sentInfo();
    });

    $sex.on('touchend',function(){
        $(this).addClass('act').siblings().removeClass('act');
        if($(this).hasClass('male')) sexNo=0;
        if($(this).hasClass('female')) sexNo=1;
    });

    $gameStartMask.on('touchend',function(){
		if(!isGameStart) start();
	});
	
    /* 初始加载事件 */
    // init();
    loadResource();
    // createAudioChannels();
    
    /* ---初始化--- */
    function init(){
        showPage('Lead');
        gamePoints=0;
        gameTimer=60*1000;
        $sprite.css({width:windowW-20+'px',height:windowW-20+'px'});
        $gamePoints.html(gamePoints);
        $gameTimer.html(gameTimer);
    }
    /* ---游戏控制--- */
    function start(model){
    	init();
        isGameStart=true;
        gameModel=model;
        if(gameModel=='single') setSingleBoxs(level[gamePoints]);
        if(gameModel=='double') setDoubleBoxs(dlevel[gamePoints]);
        showPage('Index');
        gameInterval=setInterval(function(){
            gameTimer-=gameFps;
            if(gameTimer<0){
                over();
            }else{
                $gameTimer.html(Math.floor(gameTimer/1000));
            }
        },gameFps);
    } //开始
    function restart(){
        
    } //重开
    function timeOut(){} //超时
    function pause(){
    	clearInterval(gameInterval);
    } //暂停
    function win(){} //胜利
    function over(){
    	$('#LandscapeNotice').hide();
        clearInterval(gameInterval);
        var pointsMsg=gamePoints+'分';
        $('#pageInfo header h2 span').html(pointsMsg);
        $('#pageResult .panel .content b').html(pointsMsg);
        if(!isHasSentInfo) showPage('Info');
        else showPage('Result');
    } //结束

    /* ---精灵方法--- */
    function setSingleBoxs(num){
        var boxNums=num*num;
        var randomNum=Math.ceil(Math.random()*boxNums)-1;
        var eleNum=Math.round(Math.random()*3)+1;
        var boxBgColor=getBoxBgColor();
        var box='';
        for(var i=0; i<boxNums; i++){
            // if(i==randomNum) box+='<div class="box target" style="background-color:#000;"></div>';
            if(i==randomNum) box+='<div class="box target" style="background-image:url(images/ele'+eleNum+'.png?v='+gameVersion+');background-color:'+boxBgColor+';"></div>';
            else box+='<div class="box" style="background-image:url(images/ele'+eleNum+'.png?v='+gameVersion+');background-color:'+boxBgColor+';"></div>';
        }
        $sprite.removeClass('lv2 lv3 lv4 lv5 lv6 lv7 lv8 lv9').addClass('lv'+num).html(box);
    }

    function setDoubleBoxs(num){
        actCount=0;
        var boxNums=num*num;
        var randomNumLeft=getRandomNum('left',num);
        var randomNumRight=getRandomNum('right',num);
        var eleNumLeft=Math.round(Math.random()*3)+1;
        var eleNumRight=Math.round(Math.random()*3)+1;
        var boxBgColorLeft=getBoxBgColor();
        var boxBgColorRight=getBoxBgColor();
        var box='';
        for(var i=0; i<boxNums; i++){
            if(i%num<num*0.5){
                // if(i==randomNumLeft) box+='<div class="box target" style="background-color:#000;"></div>';
                if(i==randomNumLeft) box+='<div class="box target" style="background-image:url(images/ele'+eleNumLeft+'.png?v='+gameVersion+');background-color:'+boxBgColorLeft+';"></div>';
                else box+='<div class="box" style="background-image:url(images/ele'+eleNumLeft+'.png?v='+gameVersion+');background-color:'+boxBgColorLeft+';"></div>';
            }else{
                // if(i==randomNumRight) box+='<div class="box target" style="background-color:#000;"></div>';
                if(i==randomNumRight) box+='<div class="box target" style="background-image:url(images/ele'+eleNumRight+'.png?v='+gameVersion+');background-color:'+boxBgColorRight+';"></div>';
                else box+='<div class="box" style="background-image:url(images/ele'+eleNumRight+'.png?v='+gameVersion+');background-color:'+boxBgColorRight+';"></div>';
            }
        }
        $sprite.removeClass('lv2 lv3 lv4 lv5 lv6 lv7 lv8 lv9').addClass('lv'+num).html(box);
    }

    function getRandomNum(type,num){
        var row=Math.ceil(Math.random()*num)-1;
        var column=Math.ceil(Math.random()*num*0.5)-1;
        if(type=='left'){
            return row*num+column;
        }
        if(type=='right'){
           return row*num+column+num*0.5; 
        }
    }

    function getBoxBgColor(){
        color='rgb('+Math.round(Math.random()*255)+','+Math.round(Math.random()*255)+','+Math.round(Math.random()*255)+')';
        return color;
    }

    /* ---碰撞检测--- */
    function circleCollision(p1,p2,r1,r2){
    	var x=Math.abs(p1.x-p2.x);
		var y=Math.abs(p1.y-p2.y);
		var b=Math.sqrt(x*x+y*y)<=(r1+r2)?true:false;
		return b; 
    } //圆形碰撞
    /* ---重力感应--- */
    function addDevicemotion(){ window.addEventListener('devicemotion', devicemotion, false); } //监听重力感应
    function removeDevicemotion(){ window.removeEventListener('devicemotion', devicemotion, false); } //移除重力感应
    function devicemotion(e){} //重力感应处理
    /* ---加载资源--- */
    function loadResource(){
        showPage('Loading');
        var total=resourceAry.length;
        var loaded=0,failed=0;
        for(var i in resourceAry){
            if(resourceAry[i]["type"]=="image"){
                var image= new Image();
                image.onload = function(){
                    loaded++;
                    $('.loadStatus').html(Math.floor((loaded+failed)/total*100));
                    if(loaded+failed>=total){
                       init();
                    }
                }
                image.onerror = function(){
                    failed++;
                    $('.loadStatus').html(Math.floor((loaded+failed)/total*100));
                    if(loaded+failed>=total){
                       init();
                    }
                }
                image.src = resourceAry[i]["url"];
            }
            if(resourceAry[i]["type"]=="audio"){
                var xhr = new XMLHttpRequest();
                xhr.open('GET', resourceAry[i]["url"], true);
                xhr.onload = function(e) { //下载完成  
                    loaded++;
                    $('.loadStatus').html(Math.floor((loaded+failed)/total*100));
                    if(loaded+failed>=total){
                       init();
                    }
                };
                xhr.onerror = function(e) { //下载完成  
                    failed++;
                    $('.loadStatus').html(Math.floor((loaded+failed)/total*100));
                    if(loaded+failed>=total){
                       init();
                    }
                };
                xhr.send(); 
            }
        }
    }
    /* ---声音控制--- */
    var audioIndex=0;
    function createAudioChannels(){
        var str='';
        str+='<audio autoplay="autoplay" loop="loop" preload="preload" id="Mbg" src="music/bg.mp3"></audio>';
        str+='<audio preload="preload" id="Mcondom" src="music/condom.mp3"></audio>';
        str+='<audio preload="preload" id="Mpill" src="music/pill.mp3"></audio>';
        str+='<audio preload="preload" id="Msys" src="music/sys.mp3"></audio>';
        for(var i=0; i<audioChannelsNum; i++){
            // var audio=new Audio();
            // audio.src=resourceAry[2]["url"];
            // audioChannels.push(audio);
            str+='<audio preload="preload" id="Mdestroy_kd_'+i+'" src="music/destroy_kd.mp3"></audio>';
        }
        $('body').append(str);
    } //创建声道
    function getFreeAudioChannel(){
        var audio;
        for(var i=0; i<audioChannelsNum; i++){
            // audio=audioChannels[i];
            audio=document.getElementById('Mdestroy_kd_'+i);
            if(audio.played&&audio.played.length>0){
                if(audio.ended) return audio;
            }else{
                if(!audio.ended) return audio;
            }
        }
        return undefined; //所有声道占用
    } //获取当前空闲声道
    function playAudio(type,id){
        // var audioChannel=getFreeAudioChannel();
        var audioChannel;
        if(type==1){
            audioChannel=document.getElementById(id);
        }
        if(type==2){
            audioChannel=document.getElementById('Mdestroy_kd_'+audioIndex%audioChannelsNum);
            audioIndex++;
        }
        if(audioChannel){
            // audioChannel.src=resourceAry[channelIndex]["url"];
            // audioChannel.load();
            audioChannel.play();
        }
    } //播放声音
    /* ---外层方法--- */

    function sentInfo(){
        $messageBtn.hide();
        var name=$('#name').val();
        var phone=$('#phone').val();
        if(!(regName).test(name)){
            showMsg(6,0);
        }else if(!(regPhone).test(phone)){
            showMsg(7,0);
        }else{
            // phone=phone.substring(0,3)+'****'+phone.substring(7,11);
            // var winner='<li>恭喜<span class="phone">'+phone+'</span>获得<span class="gift">'+gift[giftNo]+'</span></li>';
            // $winnerList.prepend(winner);
            // isBackToIndex=true;
            // showMsg(3,3);
            isHasSentInfo=true;
            showPage('Result');
        }
    };

    function showSharePanel(){
        if(isAllowClick) $sharePanel.show();
    }

    function hideSharePanel(){
        $sharePanel.hide();
    }

    function showMsg(i,type){
		$messagePanel.show();
		$messageStart.hide();
		if(type==1){
			$messageText.html('游戏结束！<br>您消灭了'+points+'个精子，是杀精狂人！');
			$('.tdn').attr('href','javascript:PG.restart();');
			$messageBtn.removeClass('lineBg-orange lineBg-blue').addClass('lineBg-orange').html('重新游戏').show();
		}else if(type==2){
			$messagePanel.hide();
			$messageStart.show();
			$messageStart.html(messageAry[i]);
		}
		$message.show();
		$messagePanel.addClass('pop');
		$messageStart.addClass('pop');
	}

	function closeMsg(){
		$messageBtn.hide();
		$messagePanel.removeClass('pop');
		$message.hide();
		if(isBackToIndex){
            showPage('Lead');
			isBackToIndex=false;
		}
	}

    function showPage(page){
        $('.page').hide();
        switch(page){
            case 'Loading': $loading.show();break;
            case 'Index': $pageIndex.show();break;
            case 'Lead': $pageLead.show();break;
            case 'Info': $pageInfo.show();break;
            case 'Result': $pageResult.show();break;
            case 'Chart': $pageChart.show();break;
            case 'GameDes': $pageGameDes.show();break;
        }
    }

	function delay(time,func){
		setTimeout(func,time);
	}

    // var e = {timeLineLink:"http://packd.sinaapp.com/index.html", logo:"http://packd.sinaapp.com/images/icon.png"};

    // document.addEventListener("WeixinJSBridgeReady", function() {
    //     WeixinJSBridge && (WeixinJSBridge.on("menu:share:appmessage", function() {
    //         e.tTitle = "\"蝌\"学避孕大作战";
    //         e.tContent = "点击消灭蝌蚪，防止子宫受孕";
    //         var j = e.tContent;
    //         //var j = points > 0 ? "我在PAC\"蝌\"学避孕大作战中消灭了"+points+"只蝌蚪"+resultDes: e.tContent;
    //         WeixinJSBridge.invoke("sendAppMessage", {img_url: e.logo, link: e.timeLineLink,desc: j,title: e.tTitle}, function(res) {
    //                         _report('send_msg', res.err_msg);});
    //     }), WeixinJSBridge.on("menu:share:timeline", function() {
    //         e.tTitle = "\"蝌\"学避孕大作战";
    //         e.tContent = "点击消灭蝌蚪，防止子宫受孕";
    //         var j = points > 0 ? "我在PAC\"蝌\"学避孕大作战中消灭了"+points+"只蝌蚪"+resultDes: e.tContent;
    //         WeixinJSBridge.invoke("shareTimeline", {img_url: e.logo,img_width: "640",img_height: "640",link: e.timeLineLink,desc: j,title: e.tTitle}, function(res) {
    //                         _report('send_msg', "res.err_msg");});
    //     }));
    // }, !1);

	/* ---旋转屏幕--- */
	window.onresize=function(){
		windowW=$(window).width();
        windowH=$(window).height();
        $sprite.css({width:windowW-20+'px',height:windowW-20+'px'});
	};

    return {
        init:init,
        start:start,
        restart:restart,
        timeOut:timeOut,
        pause:pause,
        win:win,
        over:over,
        showMsg:showMsg,
        closeMsg:closeMsg,
        showSharePanel:showSharePanel,
        setSingleBoxs:setSingleBoxs,
        showPage:showPage
    };
})();