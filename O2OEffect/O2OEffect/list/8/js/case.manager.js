;(function(){


	sectionLoadImg();
	init();

	// 设置section背景图
	function sectionLoadImg(min,max){
		min=min||0;
		max=max||1000;
		ev.forEach(ev.getAll('.section'),function(item,i){
			if (i>=min&&i<max) {
				var source=item.getAttribute('source');
				if (source) {
					item.style.backgroundImage='url('+source+')';
				};
			};
		});
	}

	function init(){


				
		mymodule['ggk'].init('sources/00.jpg',function(canvas,ctx){},'#325FA5');
		ev.addEvent(ev.get('canvas'),ev.end,function(){
			this.style.display='none';
		});

		sectionSwipe.init();
			sectionSwipe.addFn('sectionEnd',function(){
				var cur=ev.get('.section.cur');
				var index=cur.getAttribute('sectionIndex');
				if (index>=1) {
					ev.get('.btm-btns').classList.add('show');
				}else{
					ev.get('.btm-btns').classList.remove('show');
				};
			});


			var mapCity='广州市'
			mymodule['map'].init(mapCity);

			mymodule['map'].addFn('getmap',function(map){
				var addr='广州南沙区中惠壁珑湾';
				var html='<p style="font-size:16px;color:#999;">中惠 壁珑湾</p><p>广州南沙区进港大道与凤凰大道交界<br>（地铁4号线蕉门站A出口）</p>';
				mymodule['map'].setGeo(addr,html,mapCity);
			});

	}




})();



