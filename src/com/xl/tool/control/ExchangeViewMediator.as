package com.xl.tool.control
{
	import com.xl.tool.util.ConfigToXMLUtil;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.ExchangeViewUI;

	public class ExchangeViewMediator
	{
		private var view:ExchangeViewUI;
		private var exchangeUtil:ConfigToXMLUtil;
		public function ExchangeViewMediator()
		{
		}
		public function initView(main:Sprite):void
		{
			this.view = new ExchangeViewUI();
			main.addChild(this.view);
			this.addEvents();
			this.exchangeUtil = new ConfigToXMLUtil(this.view.lblDir,this.view.progressBar);
		}
		public function addEvents():void
		{
			this.view.btnBrowse.addEventListener(MouseEvent.CLICK,this.onMouseClick);
			this.view.btnExchange.addEventListener(MouseEvent.CLICK,this.onMouseClick);
		}
		public function removeEvents():void
		{
			this.view.btnBrowse.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
			this.view.btnExchange.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
		}
		public function dispose():void
		{
			this.removeEvents();
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			switch(e.currentTarget)
			{
				case this.view.btnBrowse:
				{
					this.exchangeUtil.browseDir();
					break;
				}
				case this.view.btnExchange:
				{
					this.exchangeUtil.startExchange();
					break;
				}
			}
		}
	}
}