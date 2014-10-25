
;(function() {
	if (window.mywx) {return};
	var mywx = (function() {
		var data={};
		function isWeiXin() {
			var ua = window.navigator.userAgent.toLowerCase();
			if (ua.match(/MicroMessenger/i) == 'micromessenger') {
				return true;
			} else {
				return false;
			}
		}
		return {
			isWeiXin: isWeiXin,
			contactLink:'http://mp.weixin.qq.com/s?__biz=MjM5NDUxNzM2NA==&mid=200669372&idx=1&sn=312186e850998184efff1885e885424e&scene=1&from=singlemessage&isappinstalled=0#rd',
			setData:function(opt){
				opt=opt||{};
				data={
					'title': opt['title'] || document.title,
					'link': opt['link'] || 'http://c.o2omobi.com/case/list/cmbc/',
					'desc': opt['desc'] || document.title,
					'img_url': opt['img_url']||'http://c.o2omobi.com/case/list/cmbc/img/appicon.png'
				}
				return this;
			},
			getData:function(){
				return data;
				/*var title = document.title;
				var desc = '民生银行喊你来当行长，还有机会领取奖品哦！';
				if (typeof(gamer)!=='undefined' && gamer.title && gamer.score>=4) {
					desc = '我已凭借' + gamer.score + '点经验值荣升' + gamer.title + '！来挑战吧，还有机会领取奖品哦！';
				};
				return {
					'title': title,
					'link': 'http://c.o2omobi.com/case/list/cmbc',
					'desc': desc,
					'img_url': 'http://c.o2omobi.com/case/list/cmbc/img/appicon.png'
				}*/
			},
			invoke: function(name, data,fn) {
				if (!name || !data || typeof(data) != 'object' || typeof WeixinJSBridge == 'undefined') {
					return false;
				};
				if (typeof(fn)!=='function') {fn=function(){}};
				WeixinJSBridge.invoke(name, data,function(d){fn(d)});
			},
			profile: function() {
				return;
				if (typeof WeixinJSBridge == 'undefined') return false;
				WeixinJSBridge.invoke('profile', {
					username: '', //服务号实际id
					scene: "57"
				}, function(d) {
					// 返回d.err_msg取值，d还有一个属性是err_desc
					// add_contact:cancel 用户取消
					// add_contact:fail　关注失败
					// add_contact:ok 关注成功
					// add_contact:added 已经关注
					// WeixinJSBridge.log(d.err_msg);
					// alert(d.err_msg)
				});
			},
			addContact: function(wxid) {
				return;
				if (typeof WeixinJSBridge == 'undefined') return false;
				WeixinJSBridge.invoke('addContact', {
					webtype: '1',
					username: 'gh_e80004aa2d4f'
				}, function(d) {
					// 返回d.err_msg取值，d还有一个属性是err_desc
					// add_contact:cancel 用户取消
					// add_contact:fail　关注失败
					// add_contact:ok 关注成功
					// add_contact:added 已经关注
					// WeixinJSBridge.log(d.err_msg);
					// alert(d.err_msg)
				});
			},

			shareMessage: function(fn) {
				var data=this.getData();
				this.invoke('sendAppMessage', data,fn);
			},
			share: function(fn) {
				var data=this.getData();
				var _data={};
				for(var i in data){
					_data[i]=data[i];
				}
				_data.title=data.desc;
				this.invoke('shareTimeline', _data,fn);
			},
			shareWeibo: function() {
				return;
				WeixinJSBridge.invoke('shareWeibo',   {                 
					"content":'',
					"url":'',
				});
			},
			init:function(){
				var that=this;
				if (that.inited) {return};
				that.inited=true;
				that.setData();


				document.addEventListener('WeixinJSBridgeReady', function() {

					/*document.querySelector('h1.title').addEventListener('click',function(){
						weixin.addContact();
					},false);*/
					// 发送给好友
					WeixinJSBridge.on('menu:share:appmessage', function(argv) {
						that.shareMessage(function(){
							// location.href=that.contactLink
						});
					});
					// 分享到朋友圈
					WeixinJSBridge.on('menu:share:timeline', function(argv) {
						that.share(function(){
							// location.href=that.contactLink
						});
					});
					// 分享到微博
					// WeixinJSBridge.on('menu:share:weibo', function(argv){
					// 	that.shareWeibo();
					// });
				}, false);
				return this;
			}
		}
	})();

	window.mywx=mywx.init();

})();