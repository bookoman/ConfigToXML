package com.xl.tool.util
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import morn.core.components.Label;
	import morn.core.components.ProgressBar;

	public class ConfigToXMLUtil
	{
		public var file:File;
		private var lblDir:Label;
		private var progressBar:ProgressBar;
		private var items:Vector.<ConfigToXMLItem>;
		private var curProgressCount:int;
		private var sumProgressCount:int;
		public function ConfigToXMLUtil(lblDir:Label,progressBar:ProgressBar)
		{
			this.file = new File();
			this.lblDir = lblDir;
			this.progressBar = progressBar;
			this.items = new Vector.<ConfigToXMLItem>();
		}
		
		public function browseDir():void
		{
			this.file.addEventListener(Event.SELECT,this.onDirSelected);
			this.file.browseForDirectory("选择一个转换路径");
			this.progressBar.value = 0;
			this.progressBar.label = Math.ceil(this.progressBar.value * 100) + "%"; 
		}
		
		public function startExchange():void
		{
			if(this.file.isDirectory)
			{
				this.curProgressCount = 0;
				this.items.splice(0,this.items.length); 
				
				var files:Array = this.file.getDirectoryListing();
				var item:ConfigToXMLItem;
				for each(var tempFile:File in files)
				{
					if(tempFile.type  == ".csv" || tempFile.type  == ".xls")
					{
						item = new ConfigToXMLItem(tempFile,file,this.loadedCall);
						trace("...................................................",tempFile.name);
						item.exchangeFile();
						this.items.push(item);
					}
				}
				this.sumProgressCount = this.items.length;
				
			}
		}
		private function onDirSelected(e:Event):void{
			this.file.removeEventListener(Event.SELECT,this.onDirSelected);
			this.lblDir.text = this.file.nativePath;
		}
		private function loadedCall():void
		{
			this.curProgressCount++;
			this.progressBar.value = this.curProgressCount / this.sumProgressCount;
			this.progressBar.label = Math.ceil(this.progressBar.value * 100) + "%"; 
		}
	}
}