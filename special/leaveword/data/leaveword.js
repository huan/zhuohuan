
<Script Language="JavaScript">
function verify()
{
	if(document.leaveword.guestname.value == ""){
		alert("���������Ĵ�����");
		return false;
	}

	if(document.leaveword.title.value == ""){
		alert("��������д���Ա����֣��������ϱ������ύ��^_^");
		return false;
	}
	if(document.leaveword.words.value == ""){
		alert("��������д���������֣��������������������ύ��^_^");
		return false;
	}
	return true;
}
</Script>
