// PG = PromeGame
;var PG=(function(){
    /* 获取浏览器信息 */
	var ua=navigator.userAgent.toLowerCase();
	var isMac=ua.indexOf("mac")>=0;
	var windowW=$(window).width();
	var windowH=$(window).height();
	var defaultW=360;
	var isBackToIndex=false;

	var $message=$('#message');
	var $messageBg=$('#message .bg');
	var $messagePanel=$('#message .panel');
	var $messageBtn=$('#message .panel .btn');
	var $messageText=$('#message .panel .text');
	var $messageClose=$('#message .panel .close');
	var $messageStart=$('#message .start');
	var $loading=$('#loading');
	var $pageInfo=$('#pageInfo');
	var $pageIndex=$('#pageIndex');
	var $pageList=$('#pageList');
	var $sentBtn=$('.sentBtn');
	var $giftNo=$('.giftNo');
	var $sex=$('.sex');

	var $winnerTitle=$('.winner-title');
	var $winnerList=$('.winner-list');

	var $gameArea=$('.gameArea');
	var $gameStartMask=$('.gameStartMask');
	var $roadBg=$('.roadBg');
	var $houseBg=$('.houseBg');
	var $nissan=$('.nissan');
	var $varia1=$('.varia1');
	var $varia2=$('.varia2');
	var $varia3=$('.varia3');

	var $light1=$('.light1');
	var $light2=$('.light2');
	var $points=$('.points');
	var $tips=$('.tips');

	var $carWheel=$('.carWheel');

	var gameInterval;
	var roadBgInterval,houseBgInterval;
	var itemInterval;
	var lightInterval;
	var gameFps=1000/60;
	var s=0;
	var fs=defaultW-windowW*0.5;
	var index=-1;
	var isLightDestroy1=false;
	var isLightDestroy2=false;
	var isLightOn1=false;
	var isLightOn2=false;
	var isGameStart=false;
	var point=0,points=0;
	var lightClick=0;
	var lightMiss=0;
	var roadBgPositionX=0,houseBgPositionX=0;
	var nissanX=0,varia1X=0,varia2X=0,varia3X=0;
	var light1X=0,light2X=246;
	var hits=0;
	var misss=0;
	var pointMultiple=1;
	var runSpeed=1;
	var defaultInterval;

	var messageAry=[
		'游戏结束！'
	];

	$loading.hide();
    $pageIndex.show();

    $gameArea.on('touchend',function(){
   		if(light1X>=(-fs-64-96)&&light1X<(-fs-64+96)&&!isLightOn1&&!isLightDestroy1) lightOn($light1,1);
   		// else if(light1X>=(-fs-64+96)&&light1X<(-64)&&!isLightDestroy1) lightDestroy($light1,1);
		if(light2X>=(-fs-64-96)&&light2X<(-fs-64+96)&&!isLightOn2&&!isLightDestroy2) lightOn($light2,2);
		// else if(light2X>=(-fs-64+96)&&light2X<(-64)&&!isLightDestroy2) lightDestroy($light2,2);
    });

    $gameStartMask.on('touchend',function(){
		if(!isGameStart) start();
	});

 //    $messageBg.on('touchend',function(){
	// 	closeMsg();
	// });

    init();
    // $gameArea.css({height:windowW+'px'});

    //初始化
    function init(){
    	s=0;
    	fs=defaultW-windowW*0.5;
    	index=-1;
    	point=0;
    	points=0;
    	lightClick=0;
    	lightMiss=0;
    	roadBgPositionX=0;
    	houseBgPositionX=0;
    	nissanX=0;
    	varia1X=0;
    	varia2X=0;
    	varia3X=0;
    	light1X=0;
    	light2X=246;
    	runSpeed=1;
    	hits=0;
		misss=0;

    	defaultInterval=setInterval(function(){
    		roadBgMove(6*runSpeed);
	    	itemMove(3*runSpeed);
	    	houseBgMove(2*runSpeed);
    	},gameFps);
    	
    	lightChange($light1,1);
    	lightChange($light2,1);
    	lightReset($light1,1);
    	lightReset($light2,2);
    	$carWheel.removeClass('act');
    	closeMsg();
    }
    /* ---游戏控制--- */
    function start(){
    	isGameStart=true;
    	lightMove(6);
    	$gameStartMask.css({width:0,height:0});
    	$points.html(points);
    	
    } //开始
    function restart(){
    	init();
    	$gameArea.addClass('act');
    	start();
    } //重开
    function timeOut(){} //超时
    function pause(){
    	// clearInterval(roadBgInterval);
    	// clearInterval(houseBgInterval);
    	// clearInterval(itemInterval);
    	clearInterval(defaultInterval);
    	if(isGameStart) clearInterval(lightInterval);
    	$gameArea.removeClass('act');
    } //暂停
    function win(){} //胜利
    function over(){
    	// clearInterval(roadBgInterval);
    	// clearInterval(houseBgInterval);
    	// clearInterval(itemInterval);
    	clearInterval(defaultInterval);
    	clearInterval(lightInterval);
    	$gameArea.removeClass('act');
	    showMsg(0,3);
    } //结束
    /* ---精灵方法--- */
    function roadBgMove(speed){
    	// roadBgInterval=setInterval(function(){
    	// 	roadBgPositionX-=speed;
	    // 	if(roadBgPositionX<-64) roadBgPositionX=0;
	    // 	$roadBg.css({backgroundPosition:roadBgPositionX+'px 0'});
    	// },gameFps);
    	roadBgPositionX-=speed;
    	if(roadBgPositionX<-64) roadBgPositionX=0;
    	$roadBg.css({backgroundPosition:roadBgPositionX+'px 0'});
    }

    function houseBgMove(speed){
    	// houseBgInterval=setInterval(function(){
    	// 	houseBgPositionX-=speed;
	    // 	if(houseBgPositionX<-1354) houseBgPositionX=0;
	    // 	$houseBg.css({backgroundPosition:houseBgPositionX+'px 0'});
    	// },gameFps);
    	houseBgPositionX-=speed;
    	if(houseBgPositionX<-1354) houseBgPositionX=0;
    	$houseBg.css({backgroundPosition:houseBgPositionX+'px 0'});
    }

    function itemMove(speed){
    	// itemInterval=setInterval(function(){
    	// 	nissanX-=speed;
	    // 	if(nissanX<-1080) nissanX=0;
	    // 	$nissan[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
	    // 	varia1X-=speed;
	    // 	if(varia1X<-720) varia1X=0;
	    // 	$varia1[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
	    // 	varia2X-=speed;
	    // 	if(varia2X<-900) varia2X=0;
	    // 	$varia2[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
	    // 	varia3X-=speed;
	    // 	if(varia3X<-1260) varia3X=0;
	    // 	$varia3[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
    	// },gameFps);
    	nissanX-=speed;
    	if(nissanX<-1080) nissanX=0;
    	$nissan[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
    	varia1X-=speed;
    	if(varia1X<-720) varia1X=0;
    	$varia1[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
    	varia2X-=speed;
    	if(varia2X<-900) varia2X=0;
    	$varia2[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
    	varia3X-=speed;
    	if(varia3X<-1260) varia3X=0;
    	$varia3[0].style.webkitTransform='translate3d('+nissanX+'px,0,0)';
    }

    function lightMove(speed){
    	lightInterval=setInterval(function(){
    		light1X-=speed*runSpeed;
	    	if(light1X<(-fs-64-96)){
	    		if(!isLightOn1){
					if(!isLightDestroy1) lightDestroy($light1,1);
				}
	    	}
	    	if(light1X<-492){
	    		index++;
	    		light1X=0;
	    		lightReset($light1,1);
	    		if(index==20) lightChange($light1,2);
	    	}
	    	$light1[0].style.webkitTransform='translate3d('+light1X+'px,0,0)';

	    	light2X-=speed*runSpeed;
	    	if(light2X<(-fs-64-96)){
	    		if(!isLightOn2){
					if(!isLightDestroy2) lightDestroy($light2,2);
				}
	    	}
	    	if(light2X<-492){
	    		index++;
	    		light2X=0;
	    		lightReset($light2,2);
	    		if(index==21) lightChange($light2,2);
	    	}
	    	$light2[0].style.webkitTransform='translate3d('+light2X+'px,0,0)';
	    	if(index>10) runSpeed=runSpeed>=1.8?runSpeed:1.1;
	    	if(index>20) runSpeed=runSpeed>=1.8?runSpeed:1.3;
	    	if(index>30) runSpeed=runSpeed>=1.8?runSpeed:1.5;
	    	if(index>40) runSpeed=runSpeed>=1.8?runSpeed:1.7;
	    	if(index>5000||points<=-250) over();
	    	$('#test').html("经过"+(index+1)+"个灯柱<br>点亮"+lightClick+"个灯柱<br>错过"+lightMiss+"个灯柱<br>分数："+(lightClick-lightMiss));
    	},gameFps);
    }

    function lightStop(){
    	clearInterval(lightInterval);
    }

    function lightOn($dom,num){
		if(num==1) isLightOn1=true;
    	if(num==2) isLightOn2=true;
		$dom.addClass('on');
    	lightClick++;
    	hits++;
    	misss=0;
    	if(hits>=5){
    		$carWheel.addClass('act');
    		pointMultiple=2;
    		runSpeed=1.8+(hits-5)*0.1;
    		if(runSpeed>2.5) runSpeed=2.5;
    	}
    	points+=100*pointMultiple;
    	$points.html(points);
    	tipsShow('成功点灯+'+100*pointMultiple);
    	console.log(runSpeed);
    }

    function lightDestroy($dom,num){
    	if(num==1) isLightDestroy1=true;
    	if(num==2) isLightDestroy2=true;
    	for(var i=0;i<7;i++){
    		lightDestroyPlay(i,60,$dom);
    	}
    	lightMiss++;
    	misss++;
    	hits=0;
    	if(misss>=5) over();
    	pointMultiple=1;
    	runSpeed=1;
    	$carWheel.removeClass('act');
    	points-=50;
    	$points.html(points);
    	tipsShow('错过点灯-50');
    }

    function lightDestroyPlay(i,j,$dom){
    	setTimeout(function(){
			$dom.css({backgroundPosition:-(i+2)*128+'px 0'});
		},i*j);
    }

    function lightChange($dom,i){
    	$dom.css({backgroundImage:'url(images/light'+i+'.png)'});
    }

    function lightReset($dom,num){
		$dom.css({backgroundPosition:''});
		$dom.removeClass('on');
		if(num==1){
			isLightDestroy1=false;
			isLightOn1=false;
		}
		if(num==2){
			isLightDestroy2=false;
			isLightOn2=false;
		}
    }

    function tipsShow(msg){
    	$tips.removeClass('act').html(msg);
    	setTimeout(function(){
    		$tips.addClass('act');
    	},100);
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
    function loadImages(){} //加载图片资源
    function addMusic(){} //加载音乐资源
    /* ---外层方法--- */
    function showMsg(i,type){
		$messagePanel.show();
		// $messageStart.hide();
		if(type==1){
			$messageText.html('亲，你今天运气爆棚！<br>抽中'+gift[i]);
			$messageBtn.show();
		}else if(type==2){
			$messagePanel.hide();
			$messageStart.show();
			$messageStart.html(gift[i]);
		}else if(type==3){
			$messageText.html(messageAry[i]);
			$('.tdn').attr('href','javascript:PG.restart();');
			$messageBtn.removeClass('lineBg-orange lineBg-blue').addClass('lineBg-orange').html('重新游戏').show();
		}else if(type==4){
			$messageText.html(gift[i]);
			$('.tdn').attr('href','javascript:game.showPageInfo();');
			$messageBtn.removeClass('lineBg-orange lineBg-blue').addClass('lineBg-blue').html('马上领奖').show();
		}else if(type==5){
			$messageText.html(gift[i]);
			$('.tdn').attr('href','javascript:game.start();');
			$messageBtn.removeClass('lineBg-orange lineBg-blue').addClass('lineBg-blue').html('继续游戏').show();
		}else{
			$messageText.html(gift[i]);
			// $messageBtn.removeClass('lineBg-orange lineBg-blue').addClass('lineBg-orange').show();
		}
		$message.show();
		$messagePanel.addClass('pop');
		// $messageStart.addClass('pop');
	}

	function closeMsg(){
		$messageBtn.hide();
		$messagePanel.removeClass('pop');
		$message.hide();
		if(isBackToIndex){
			showPageIndex();
			isBackToIndex=false;
		}
	}

	function showPageIndex(){
		$message.hide();
		$pageIndex.show();
		// $pageList.hide();
		// $pageInfo.hide();
	}

	/* ---旋转屏幕--- */
	// window.onresize=function(){
	// 	if($(window).width()>$(window).height()){
	// 		if(isGameStart) pause();
	// 	}
	// };

    return {
        init:init,
        start:start,
        restart:restart,
        timeOut:timeOut,
        pause:pause,
        win:win,
        over:over,
        circleCollision:circleCollision,
        addDevicemotion:addDevicemotion,
        removeDevicemotion:removeDevicemotion,
        devicemotion:devicemotion,
        loadImages:loadImages,
        addMusic:addMusic,
        lightStop:lightStop,
        lightMove:lightMove
    };
})();