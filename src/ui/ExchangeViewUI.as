/**Created by Morn,Do not modify.*/
package ui {
	import morn.core.components.*;
	public class ExchangeViewUI extends View {
		public var lblDir:Label;
		public var btnBrowse:Button;
		public var btnExchange:Button;
		public var progressBar:ProgressBar;
		protected var uiXML:XML =
			<View>
			  <Image url="png.comp.blank" x="86" y="218" width="504" height="33"/>
			  <Label x="94" y="219" width="494" height="32" size="24" var="lblDir"/>
			  <Label text="路径：" x="7" y="219" width="86" height="32" size="24" align="right"/>
			  <Button label="浏览" skin="png.comp.button" x="149" y="308" width="138" height="41" var="btnBrowse" labelSize="24" visible="false"/>
			  <Button label="转换" skin="png.comp.button" x="220" y="309" width="138" height="41" var="btnExchange" labelSize="24"/>
			  <Label x="57" y="20" width="494" height="141" size="20" text="将要转换得CSV，EXCEL(只支持.xls，其他请转到此版本)配置放到一个文件夹下，将文件夹拖到软件里，最后点击转换，稍等片刻，会在同目录下生成对应名字得XML配置。" multiline="true" wordWrap="true" color="0xff0000" indent="30" leading="5" font="Microsoft YaHei"/>
			  <Label x="60" y="162" width="509" height="41" size="24" multiline="true" wordWrap="true" color="0xff0000" font="Microsoft YaHei" text="注意：中文描述请用中文”，“别用英文“,&quot;"/>
			  <ProgressBar skin="png.comp.progress" x="96" y="277" width="414" height="14" value="0" sizeGrid="10,2,10,2" var="progressBar" label="0%"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}