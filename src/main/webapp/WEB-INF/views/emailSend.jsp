<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
.file_input_textbox
{
float: left
}
 
.file_input_div
{
position: relative;
width: 100px;
height: 23px;
overflow: hidden;
}
 
.file_input_button
{
width: 100px;
position: absolute;
top: 0px;
background-color: #33BB00;
color: #FFFFFF;
border-style: solid;
}
 
.file_input_hidden
{
font-size: 45px;
position: absolute;
right: 0px;
top: 0px;
opacity: 0;
 
filter: alpha(opacity=0);
-ms-filter: "alpha(opacity=0)";
-khtml-opacity: 0;
-moz-opacity: 0;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

</script>
</head>
<body>
<input type="text" id="fileName" class="file_input_textbox" readonly="readonly" value="기존파일이름">
 
<div class="file_input_div">
<input type="button" value="Search files" class="file_input_button" />
<input type="file" class="file_input_hidden" title="새로운 파일 업로드" onchange="javascript: document.getElementById('fileName').value = this.value" />
</div>

</body>
</html>