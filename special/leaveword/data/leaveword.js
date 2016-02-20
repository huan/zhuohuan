
<Script Language="JavaScript">
function verify()
{
	if(document.leaveword.guestname.value == ""){
		alert("请留下您的大名！");
		return false;
	}

	if(document.leaveword.title.value == ""){
		alert("您忘记填写留言标题乐！请您添上标题在提交！^_^");
		return false;
	}
	if(document.leaveword.words.value == ""){
		alert("您忘记填写留言内容乐！请您添上留言内容在提交！^_^");
		return false;
	}
	return true;
}
</Script>
