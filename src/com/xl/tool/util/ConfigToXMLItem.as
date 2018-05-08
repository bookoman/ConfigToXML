package com.xl.tool.util
{
	import com.as3xls.xls.ExcelFile;
	import com.as3xls.xls.Sheet;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class ConfigToXMLItem
	{
		private var fileDir:File
		private var file:File;
		private var loadedCall:Function;
		public function ConfigToXMLItem(file:File,fileDir:File,loadedCall:Function)
		{
			this.file = file;
			this.fileDir = fileDir;
			this.loadedCall = loadedCall;
		}
		
		
		public function exchangeFile():void
		{
			if(this.file.type  == ".xls")
			{
				this.excelToXml();
			}
			else if(this.file.type  == ".csv")
			{
				this.csvToXml();
			}
		}
		
		
		public function csvToXml():void
		{
			var csvStr:String = ""
			var ba:ByteArray = new ByteArray();
			var stream:FileStream = new FileStream();
			stream.open(this.file,FileMode.READ);
			csvStr = stream.readMultiByte(stream.bytesAvailable,"GBK");
			stream.close();
			
			var xmlStr:String = "<?xml version='1.0' encoding='utf-8'?>\r<root>\r";
			var rowsAry:Array = csvStr.split("\r\n");
			var colsAry:Array;
			var rowStr:String;
			var colStr:String;
			var colNames:Array = rowsAry[1].split(",");
//			var myPattern:RegExp = / /g;
			for(var i:int = 2;i < rowsAry.length;i++)
			{
				rowStr = rowsAry[i];
				var tempAry:Array = rowStr.split("\"");
				rowStr = tempAry.join("");
				trace(rowStr);
				colsAry = rowStr.split(",");
				if(colsAry.length != colNames.length)
				{
					continue;
				}
				xmlStr += "\t<element "
				for(var j:int = 0; j < colsAry.length;j++)
				{
					colStr = colsAry[j];
//					colStr = colStr.replace(myPattern,",");
					xmlStr += colNames[j] + "='" + colStr + "' ";
				}
				xmlStr += "/>\r";
			}
			xmlStr += "</root>";
//			var xml:XML = new XML(xmlStr);
			this.saveXmlFile(xmlStr);
		}
		public function excelToXml():void
		{
			var ba:ByteArray = new ByteArray();
			var stream:FileStream = new FileStream();
			stream.open(this.file,FileMode.READ);
			stream.readBytes(ba);
			stream.close();
		
			var xls:ExcelFile = new ExcelFile();
			xls.loadFromByteArray(ba);
			xls.saveToByteArray();
			var sheet:Sheet = xls.sheets[0];
			
			var xmlStr:String = "<?xml version='1.0' encoding='utf-8'?>\r<root>\r";
			var colNames:Array = [];
			for(var i:int = 1; i < sheet.rows;i++)
			{
				xmlStr += i > 1 ? "\t<element " : "";
				for(var j:int = 0;j < sheet.cols;j++)
				{
					if(i == 1)
					{
						colNames[j] = sheet.getCell(i,j);
					}
					else
					{
						xmlStr += colNames[j] + "='" + sheet.getCell(i,j) + "' ";
					}
				}
				xmlStr += i > 1 ? "/>\r" : "";
			}
			xmlStr += "</root>";
			this.saveXmlFile(xmlStr);
			
//			trace(xls.sheets.length,sheet.getCell(0,0));
		}
		
		private function saveXmlFile(xmlStr:String):void
		{
			var saveFileName:String = this.file.name.substr(0,this.file.name.length - 4);
			var saveFile:File = fileDir.resolvePath(saveFileName+".xml");
			var saveStream:FileStream = new FileStream();
			try
			{
				saveStream.open(saveFile,FileMode.WRITE);
				saveStream.writeMultiByte(xmlStr,"UTF-8");
				saveStream.close();
				
				this.loadedCall();
			} 
			catch(error:Error) 
			{
				trace(error.message);
			}
		}
	}
}