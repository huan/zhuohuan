<%@ Language=JavaScript %>
<%
Response.CacheControl = "Private";
Response.Expires = 0;

var ForReading = 1, ForWriting = 2, ForAppending = 8;
var ItemsInOnePage = 10;

var UrlReturn = "../special.html";
var MyUrl = "http://" + Request.ServerVariables("SERVER_NAME") + Request.ServerVariables("SCRIPT_NAME");
var MyFileName = Request.ServerVariables("SCRIPT_NAME") + "";
MyFileName = MyFileName.substr(MyFileName.lastIndexOf("/")+1);

var HtmlReturn = "";
var MainContents = "";

switch(Request("Param")+""){
default:
case "Browse":
	MainContents = Browse();
	
	HtmlReturn = GetHead();
	HtmlReturn += MakeNavigationBar(Session("CurrentBrowsePos"), ItemsInOnePage, Session("LeaveWordIndex").length-1);
	HtmlReturn += TableHead();
	HtmlReturn += MainContents;
	HtmlReturn += "</table>\r\n";
	HtmlReturn += GetFoot();
	break;
case "BrowseNextPage":
	MainContents = BrowseNextPage();

	HtmlReturn = GetHead();
	HtmlReturn += MakeNavigationBar(Session("CurrentBrowsePos"), ItemsInOnePage, Session("LeaveWordIndex").length-1);
	HtmlReturn += TableHead();
	HtmlReturn += MainContents;
	HtmlReturn += "</table>\r\n";
	HtmlReturn += GetFoot();
	break;
case "BrowsePreviousPage":
	MainContents = BrowsePreviousPage();

	HtmlReturn = GetHead();
	HtmlReturn += MakeNavigationBar(Session("CurrentBrowsePos"), ItemsInOnePage, Session("LeaveWordIndex").length-1);
	HtmlReturn += TableHead();
	HtmlReturn += MainContents;
	HtmlReturn += "</table>\r\n";
	HtmlReturn += GetFoot();
	break;
case "LeaveWordStart":
	MainContents = LeaveWordStart();

	HtmlReturn = GetHead();
	HtmlReturn += "<table width=500 border=0>\r\n";
	HtmlReturn += MainContents;
	HtmlReturn += "</table>\r\n";
	HtmlReturn += GetFoot();
	break;
case "LeaveWordOver":
	MainContents = LeaveWordOver();
	
	HtmlReturn = GetHead();
	HtmlReturn += MainContents;
	HtmlReturn += GetFoot();
	break;
case "ShowItem":
	MainContents = GetFileContent("data/" + Request("ItemNum") + ".htm");

	HtmlReturn += MainContents;
	break;
}

Response.Write(HtmlReturn+"");
Response.End();
//////////////////////////////////////////////////////////////////////*************************************
function Browse()
{
	var StrReturn = "";
	
	var fso = Server.CreateObject("Scripting.FileSystemObject");
	var PhysicalFileName = Server.MapPath("data/index.dat");
	if(!fso.FileExists(PhysicalFileName)){
		ts = fso.OpenTextFile(PhysicalFileName, ForWriting ,true);
		ts.WriteLine('');
		ts.close();
	}
	
	var list = new Array();
	var i=0;
	var ts = fso.OpenTextFile(PhysicalFileName, ForReading);
	while(!ts.AtEndOfStream){
		i++;
		list[i] = ts.ReadLine();
	}
	ts.Close();

	Session("LeaveWordIndex") = list;
	Session("CurrentBrowsePos") = list.length - 1;

	StrReturn += getWordsTable(list);

	return StrReturn;
}

function BrowseNextPage()
{
	var StrReturn = "";
	
	if(Session("CurrentBrowsePos") == null){
		resetSession();
	}

	if(Session("CurrentBrowsePos")-ItemsInOnePage  < 1){
		Session("CurrentBrowsePos") = ItemsInOnePage;
	}else{
		Session("CurrentBrowsePos") -= ItemsInOnePage;
	}
	
	return getWordsTable(Session("LeaveWordIndex"));
}

function BrowsePreviousPage()
{
	var StrReturn = "";
	
	if(Session("CurrentBrowsePos") == null){
		resetSession();
	}

	if(Session("CurrentBrowsePos")+ItemsInOnePage  >= Session("LeaveWordIndex").length){
		Session("CurrentBrowsePos") = Session("LeaveWordIndex").length-1;
	}else{
		Session("CurrentBrowsePos") += ItemsInOnePage;
	}
	
	return getWordsTable(Session("LeaveWordIndex"));
}

function LeaveWordStart()
{
	var StrReturn = "";

	StrReturn = GetFileContent("data/leaveword.js");
		
	StrReturn += "<form name='leaveword' method='POST' action='" + MyUrl + "?Param=LeaveWordOver'>\r\n";
	
	StrReturn += GetFileContent("data/leaveword.dat");
	
	StrReturn += "</form>\r\n";
	

	
	return StrReturn;
}

function LeaveWordOver()
{
	var StrReturn = "";
	
	var GuestName = Request("guestname")+"";
	var GuestMail = Request("mail")+"";
	var HomePageUrl = Request("homepageurl")+"";
	var HomePageName = Request("homepagename")+"";
	var GuestAge = Request("age")+"";
	var GuestNet = Request("net")+"";
	var GuestFace = Request("face")+"";
	var GuestOpnion	= Request("opinion")+"";
	var LeaveWordTitle = Request("title")+"";
	var LeaveWords = Request("words")+"";
	var SmthID = Request("smthid") + "";

	HomePageUrl = HomePageUrl.toLowerCase();
	if( (HomePageUrl.indexOf("http://") == -1) && HomePageUrl)
		HomePageUrl = "http://" + HomePageUrl;

	GuestName = Server.HTMLEncode(GuestName);
	GuestMail = Server.HTMLEncode(GuestMail);
	HomePageUrl = Server.HTMLEncode(HomePageUrl);
	HomePageName = Server.HTMLEncode(HomePageName);
	GuestAge = Server.HTMLEncode(GuestAge);
	GuestNet = Server.HTMLEncode(GuestNet);
	GuestFace = Server.HTMLEncode(GuestFace);
	GuestOpnion = Server.HTMLEncode(GuestOpnion);
	LeaveWordTitle = Server.HTMLEncode(LeaveWordTitle);
	SmthID = Server.HTMLEncode(SmthID);
	LeaveWords = ConvertCRLF(LeaveWords);

	var today = new Date()
	var dayArray = new Array();
	dayArray[0] = "日";
	dayArray[1] = "一";
	dayArray[2] = "二";
	dayArray[3] = "三";
	dayArray[4] = "四";
	dayArray[5] = "五";
	dayArray[6] = "六";
	var GuestVisitDate = (today.getMonth()+1) + "月" + today.getDate() + "日  (周" + dayArray[today.getDay()] + ")" + today.getYear() + "年";
	
	var GuestIPAddr = Request.ServerVariables("REMOTE_ADDR");
	
	if(!GuestMail)
		GuestMail = "JavaScript:alert('这位网友没有输入自己的 E-Mail.')"
	else
		GuestMail = "mailto:" + GuestMail;
	
	if(!HomePageName)
		HomePageName = "神秘网页";
	
	if(!HomePageUrl)
		HomePageUrl = "JavaScript:alert('这位网友没有输入自己的 HomePage 地址.')";
		
	if(!SmthID)
		SmthID = "神秘ID";

	var newStr = "";

	var FileData = "<html><head><title>" + GuestName + "大虾之留言" + "</title><meta http-equiv='Content-Type' content='text/html; charset=gb2312'>\r\n<body background='images/saftextr.jpg' bgcolor='#000000' text='#CCCC99' link='#CC9900' vlink='#996600' alink='#FF3300'>\r\n";
	FileData += "<center>\r\n<table width=100% border=1>\r\n";
	FileData += "<tr bgcolor='saddlebrown'><td><font face='楷体_GB2312'><img src='images/" + GuestFace + ".gif' width=25 height=25 align='absmiddle'>留言标题：</font></td><td><font face='楷体_GB2312'>" + LeaveWordTitle + "</font></td></tr>\r\n";
	FileData += "<tr><td><font face='楷体_GB2312'>访问信息：</td><td><font face='楷体_GB2312'>" + GuestAge + GuestName + "于" + GuestVisitDate + "来自 " + GuestNet + " " + GuestIPAddr + "</font></td></tr>\r\n";
	FileData += "<tr><td><font face='楷体_GB2312'>" + GuestName + "的E-Mail：</td><td><font face='楷体_GB2312'><a href=\"" + GuestMail + "\">给" + GuestName + "发依妹儿？ </a></font></td></tr>\r\n";
	FileData += "<tr><td><font face='楷体_GB2312'>" + GuestName + "的HomePage：</td><td><font face='楷体_GB2312'><a href=\"" + HomePageUrl + "\">" + HomePageName + "</a></td></tr>\r\n";
	FileData += "<tr><td><font face='楷体_GB2312'>" + GuestName + "的ＢＢＳID：</td><td><font face='楷体_GB2312'>"+ (SmthID=="神秘ID"?"<a href=\"JavaScript:alert('这位网友没有输入自己的ＢＢＳ ID 。')\">":("<a href='http://bbs.tsinghua.edu.cn/cgi-bin/bbsquery?id=" + SmthID + "'>")) + SmthID + "</a></td></tr>\r\n";
	FileData += "<tr><td><font face='楷体_GB2312'>" + GuestName + "对本站看法：</td><td><font face='楷体_GB2312'>" + GuestOpnion + "</td></tr>\r\n";
	FileData += "<tr><td><font face='楷体_GB2312'>" + GuestName + "之留言：</td><td><font face='楷体_GB2312'>" + LeaveWords + "</td></tr>\r\n";
	
	FileData += "</table><p><font face='楷体_GB2312'><a href='" + MyFileName + "?Param=Browse'><img src='images/goback.gif' width=32 height=32 border=0 alt='返回'></a></center></body></html>";

	
	var fso = Server.CreateObject("Scripting.FileSystemObject");
	var PhysicalFileName = "";
	if(!Session("LeaveWordIndex")){
		PhysicalFileName = Server.MapPath("data/index.dat");
		if(!fso.FileExists(PhysicalFileName)){
			var ts = fso.OpenTextFile(PhysicalFileName, ForWriting ,true);
			ts.WriteLine('');
			ts.close();
		}
	
		var list = new Array();
		var i=0;
		var ts = fso.OpenTextFile(PhysicalFileName, ForReading);
		while(!ts.AtEndOfStream){
			i++;
			list[i] = ts.ReadLine();
		}
		ts.Close();
		Session("LeaveWordIndex") = list;
	}
		
	var i = Session("LeaveWordIndex").length - 1;
	if(i<0)
		i=0;
	do{
		i++;
		PhysicalFileName = Server.MapPath("data/" + i + ".htm");
	}while(fso.FileExists(PhysicalFileName));
	
	ts = fso.OpenTextFile(PhysicalFileName, ForWriting, true);
	ts.Write(FileData);
	ts.Close();

	FileData = i + "\t";
	FileData += GuestAge + "\t";
	FileData += GuestFace + "\t";
	FileData += LeaveWordTitle + "\t"; ///////////////
	FileData += GuestName + "\t"; /////////////////
	FileData += GuestMail + "\t";
	FileData += HomePageUrl + "\t";
	FileData += HomePageName + "\t";////////////////////
	FileData += GuestVisitDate + "\t";
	FileData += GuestNet + "\t";
	FileData += SmthID + "\t"; ////////////

	
	
	PhysicalFileName = Server.MapPath("data/index.dat");

	if(!fso.FileExists(PhysicalFileName)){
		var ts = fso.OpenTextFile(PhysicalFileName, ForWriting ,true);
		ts.WriteLine('');
		ts.close();
	}

	ts = fso.OpenTextFile(PhysicalFileName, ForAppending);
	ts.WriteLine(FileData);
	ts.Close();
	
	StrReturn = "<Script Language=JavaScript>\r\nalert('感谢您在百忙之中用宝贵时间为我留言！');window.location.href='" + MyUrl + "?Param=Browse';</Script>";
	return StrReturn;
}

function ErrorMsg()
{
	var StrReturn = "";
	
	StrReturn = "<tr><td>赫赫，留言版冒烟啦！！！！</td></tr>";
	return StrReturn;
}

///////////////////////////////////////////////////////////////////////*************************************
function GetHead()
{
	var fso = Server.CreateObject("Scripting.FileSystemObject");
	var PhysicalFileName = Server.MapPath("data/htmlhead.dat");
	var ts = fso.OpenTextFile(PhysicalFileName, ForReading);
	return ts.ReadAll();
}

function GetFoot()
{
	var fso = Server.CreateObject("Scripting.FileSystemObject");
	var PhysicalFileName = Server.MapPath("data/htmlfoot.dat");
	var ts = fso.OpenTextFile(PhysicalFileName, ForReading);
	return ts.ReadAll();
}

function GetLineItem(str, nth)
{
	var i=0, j=0;
	var StrReturn = "";
	
	for(i=0;i<str.length;i++){
		if(str.charAt(i) == '\t'){
			j++;
			if(j==nth){
				return StrReturn;
			}else{
				StrReturn = "";
			}
		}else if( i==(str.length-1)){
			j++;
			if(j==nth){
				StrReturn += str.charAt(i);
				return StrReturn;
			}
		}else{
			StrReturn += str.charAt(i);
		}
	}
	return null;
}

function MakeNavigationBar(CurrentBrowsePos, ItemsInOnePage, TotalItemCount)
{
	var StrReturn = "";
	var Previous, Next;

	if(CurrentBrowsePos == TotalItemCount)
		Previous = "<td><font face='楷体_GB2312'>上一页</font></td>\r\n";
	else
		Previous = "<td><a href='" + MyUrl + "?Param=BrowsePreviousPage'><font face='楷体_GB2312'>上一页</a></td>\r\n";
	if( (CurrentBrowsePos - ItemsInOnePage) <= 0)
		Next = "<td><font face='楷体_GB2312'>下一页</font></td>\r\n";
	else
		Next = "<td><font face='楷体_GB2312'><a href='" + MyUrl + "?Param=BrowseNextPage'>下一页</a></font></td>\r\n";
	
	StrReturn = "<table width=500 border=4><tr>\r\n";
	
	StrReturn += "	<td><font face='楷体_GB2312'><a href='" + UrlReturn + "'>离开留言版</a></font></td>\r\n";

	StrReturn += "	<td><font face='楷体_GB2312'><a href='" + MyUrl + "?Param=Browse'>查看最新留言</a></font></td>\r\n";
	
	StrReturn += "	<td><font face='楷体_GB2312'><a href='" + MyUrl + "?Param=LeaveWordStart'>留言</a></font></td>\r\n";
	
	StrReturn += "	" + Previous;
	StrReturn += "	" + Next;
	
	StrReturn += "</tr>\r\n</table>\r\n<p>\r\n";
	
	return StrReturn;
}

function TableHead()
{
	var StrReturn = "";
	
	StrReturn += "<table width=100% border=1 obgcolor='dimgray' oldcolor='dimgray'>\r\n";
	StrReturn += "<tr bgcolor='saddlebrown'>" + "<td><font face='楷体_GB2312'>感受</font></td><td><font face='楷体_GB2312'>标题</font></td><td><font face='楷体_GB2312'>尊姓大名</font></td><td><font face='楷体_GB2312'>水母青蛙</font></td><td><font face='楷体_GB2312'>个人烘培机</font></td><td><font face='楷体_GB2312'>留言日期</font></td><td><font face='楷体_GB2312'>来自</font></td></tr>\r\n";
	
	return StrReturn;
}

function GetFileContent(FileName)
{
	var PhysicalFileName = Server.MapPath(FileName);
	
	var fso = Server.CreateObject("Scripting.FileSystemObject");
	var ts = fso.OpenTextFile(PhysicalFileName, ForReading);
	return ts.ReadAll();
}

function toShort(str, nMax, bCut)
{
	if((str+"").length > nMax){
		if(bCut){
			return str.substr(0,nMax);
		}else{
			return (str.substr(0,nMax-2) + "..");
		}
	}
	return str;
}	

function resetSession()
{
	var fso = Server.CreateObject("Scripting.FileSystemObject");
	var PhysicalFileName = Server.MapPath("data/index.dat");
	if(!fso.FileExists(PhysicalFileName)){
		ts = fso.OpenTextFile(PhysicalFileName, ForWriting ,true);
		ts.WriteLine('');
		ts.close();
	}
	var list = new Array();
	var i=0;
	var ts = fso.OpenTextFile(PhysicalFileName, ForReading);
	while(!ts.AtEndOfStream){
		i++;
		list[i] = ts.ReadLine();
	}
	ts.Close();

	Session("LeaveWordIndex") = list;
	Session("CurrentBrowsePos") = list.length - 1;
}

function getWordsTable(list)
{
	var StrReturn = "";
	var filename, age, face, title, name, mail, homepagename, homepageurl, date, ip, smthid;

	for(i=Session("CurrentBrowsePos");i>0;i--){
		if((Session("CurrentBrowsePos") - i) == ItemsInOnePage){
			break;
		}

		filename = GetLineItem(list[i], 1);
		age = GetLineItem(list[i], 2);
		face = GetLineItem(list[i], 3);
		title = toShort(GetLineItem(list[i], 4),14, false);
		name = toShort(GetLineItem(list[i], 5),8);
		mail = GetLineItem(list[i], 6);
		homepageurl = GetLineItem(list[i], 7);
		homepagename = toShort(GetLineItem(list[i], 8),10, false);
		date = toShort(GetLineItem(list[i], 9),8, true);
		ip = GetLineItem(list[i], 10);
		smthid = toShort(GetLineItem(list[i], 11),8, false);

		

		if(!age || !face || !title || !name || !mail || !homepageurl || !homepagename || !date || !ip || !filename)
			continue;

		StrReturn += "<tr>\r\n";
		
		StrReturn += "	<td><font face='楷体_GB2312'>" + "<img src='images/" + face + ".gif' align='absmiddle' width=25 height=25 alt='客人的表情啦！' border=0>" + age + "</font></td>\r\n"
		
		StrReturn += "	<td><font face='楷体_GB2312'><a href='" + MyUrl + "?Param=ShowItem&ItemNum=" + i + "'>" + title + "</a></font></td>\r\n";

		StrReturn += "	<td><font face='楷体_GB2312'><a href=\"" + mail + "\">" + name + "</a></font></td>\r\n";
		
		StrReturn += "	<td><font face='楷体_GB2312'>" + (smthid=="神秘ID"?"<a href=\"JavaScript:alert('这位网友没有输入自己的ＢＢＳ ID 。')\">":("<a href='http://bbs.tsinghua.edu.cn/cgi-bin/bbsquery?id=" + smthid + "'>")) + smthid + "</a></font></td>\r\n";
				
		StrReturn += "	<td><font face='楷体_GB2312'><a href=\"" + homepageurl + "\">" + homepagename + "</a></font></td>\r\n";
		
		StrReturn += "	<td><font face='楷体_GB2312'>" + date + "</font></td>\r\n";
		
		StrReturn += "	<td><font face='楷体_GB2312'>" + ip + "</font></td>\r\n";
		
		StrReturn += "</tr>\r\n";
	}
	return StrReturn;
}

function ConvertCRLF(str)
{
	var StrNew = "";
	if(!str || str.length == 0)
		return "";
	for(var i=0;i<str.length;i++){
		if(str.charAt(i) == '\n')
			StrNew += "<br>";
		else
			StrNew += str.charAt(i);
	}
	return StrNew;
}
%>