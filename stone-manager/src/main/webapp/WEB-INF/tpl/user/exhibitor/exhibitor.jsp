<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/tpl/user/managerrole/head.jsp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>金泓信展商管理后台</title>
	<style>
		body {
			margin: 0px;
			padding: 0px;
			width: 100%;
			height: 100%;
		}

		input {
			width: 200px;
			height: 20px;
		}

		.exhibitors:hover{
			background-color:#6caef5;
		}
		.exhibitors{
			padding:8px;
		}

		#bg{ display: none; position: absolute; top: 0%; left: 0%; width: 50%; height: 50%; background-color: black; z-index:1001; -moz-opacity: 0.2; opacity:.2; filter: alpha(opacity=50);}
		.loading{display: none; position: absolute; top: 50%; left: 50%; z-index:1002; }
	</style>
</head>

<div id="tabs" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
	<div title="展商列表" style="padding:5px">
		<table id="exhibitors" data-options="url:'${base}/user/queryExhibitorsByPage',
            								 loadMsg: '数据加载中......',
									         singleSelect:false,	//只能当行选择：关闭
									         fit:true,
									         fitColumns:true,
									         idField:'eid',
									         remoteSort:true,
									         view: emptyView,
											 emptyMsg: '没有记录',
											 toolbar:'#toolbar',
									         rownumbers: true,
									         pagination:'true',
									         pageSize:'20'">
			<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field: 'tag', formatter: formatTag, width: $(this).width() * 0.07">
					<span id="stag" class="sortable">所属人</span><br/>
					<select id="exhibitorsTag" style="width:100%;height:21px;"
							onchange="filter(this.options[this.options.selectedIndex].value);">
					</select>
				</th>
				<th data-options="field: 'group', formatter: formatGroup, width: $(this).width() * 0.07">
					<span id="sgroup" class="sortable">展团</span><br/>
					<select id="exhibitorsGroup" style="width:100%;height:21px;"
							onchange="filter(this.options[this.options.selectedIndex].value);">
					</select>
				</th>
				<th data-options="field: 'boothNumber', width: $(this).width() * 0.07">
					<span id="sboothNumber" class="sortable">展位号</span><br/>
					<input id="exhibitorsBoothNumber" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'company', width: $(this).width() * 0.25">
					<span id="scompany" class="sortable">公司中文名</span><br/>
					<input id="exhibitorsCompany" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'companye', width: $(this).width() * 0.26">
					<span id="scompanye" class="sortable">公司英文名</span><br/>
					<input id="exhibitorsCompanye" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'contractId', width: $(this).width() * 0.07">
					<span id="scontractId" class="sortable">合同编号</span><br/>
					<input id="exhibitorsContractId" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'area', formatter: formatArea, width: $(this).width() * 0.03">
					<span id="sarea" class="sortable">展区</span><br/>
					<select id="exhibitorsArea" style="width:100%;height:21px;" onchange="filter();">
						<option selected value="">全部</option>
						<option value="1">国内</option>
						<option value="2">国外</option>
					</select>
				</th>
				<th data-options="field: 'country', formatter: formatCountry, width: $(this).width() * 0.03">
					<span id="scountry" class="sortable">国家</span><br/>
					<select id="exhibitorsCountry" style="width:100%;height:21px;"
							onchange="filter(this.options[this.options.selectedIndex].value);">
					</select>
				</th>
				<th data-options="field: 'province', formatter: formatProvince, width: $(this).width() * 0.07">
					<span id="sprovince" class="sortable">省份</span><br/>
					<select id="exhibitorsProvince" style="width:100%;height:21px;"
							onchange="filter(this.options[this.options.selectedIndex].value);">
					</select>
				</th>
				<th data-options="field: 'isLogout', formatter: formatStatus, width: $(this).width() * 0.07">
					<span id="sisLogout" class="sortable">状态</span><br/>
					<select id="exhibitorsIsLogout" style="width:104%;height:21px;" onchange="filter();">
						<option selected value="">全部</option>
						<option value="0">正常</option>
						<option value="1">注销</option>
					</select>
				</th>
			</tr>
			</thead>
        </table>
        <!-- 导出会刊 -->
        <form id="exportTransactionsToZip" action="${base}/user/exportTransactionsToZip" method="post">
            <div id="eidParm1"></div>
        </form>
        <!-- 导出展商到Excel -->
        <form id="exportExhibitorsToExcel" action="${base}/user/exportExhibitorsToExcel" method="post">
            <div id="eidParm2"></div>
        </form>
        <!-- 导出展位号+企业楣牌 -->
        <form id="exportBoothNumAndMeipaiToExcel" action="${base}/user/exportBoothNumAndMeipaiToExcel" method="post">
            <div id="eidParm3"></div>
        </form>
        <!-- 导出展商联系人到Excel -->
        <form id="exportContactsToExcel" action="${base}/user/exportContactsToExcel" method="post">
            <div id="eidParm4"></div>
        </form>
        <!-- 导出展商参展人员到Excel -->
        <form id="exportExhibitorJoinersToExcel" action="${base}/user/exportExhibitorJoinersToExcel" method="post">
            <div id="eidParm5"></div>
        </form>
        <!-- 导出展商邀请涵邮箱到Excel -->
        <form id="exportAllExhibitorInvitationsToExcel" action="${base}/user/exportAllExhibitorInvitationsToExcel" method="post">
            <div id="eidParm6"></div>
        </form>
		<!-- 导出所有展商增值税专用发票图片 -->
		<form id="exportExhibitorInvitationImageToZip" action="${base}/user/exportExhibitorInvitationImageToZip" method="post">
			<div id="eidParm9"></div>
		</form>
		<!-- 导出所有展商增值税专用发票信息 -->
		<form id="exportExhibitorInvitationToZip" action="${base}/user/exportExhibitorInvitationToZip" method="post">
			<div id="eidParm7"></div>
		</form>
		<!-- 导出所有展商展位确认涵 -->
		<form id="exportExhibitorBoothConfirmToZip" action="${base}/user/exportExhibitorBoothConfirmToZip" method="post">
			<div id="eidParm8"></div>
		</form>
		<!-- 导出非展团境外参展人员到Excel -->
		<form id="exportOutOfGroupExhibitorJoinersToExcel" action="${base}/user/exportOutOfGroupExhibitorJoinersToExcel" method="post">
			<div id="eidParm10"></div>
		</form>
	</div>
</div>

<!-- 发送展商邀请涵 -->
<div id="sendExhibitorInvitationDlg" data-options="iconCls:'icon-add',modal:true">
	<form id="sendExhibitorInvitationForm" name="sendExhibitorInvitationForm">
		<table style="width: 470px;margin: 20px auto">
			<tr>
				<td style="width: 140px;text-align: right">选择发送者账号：</td>
				<td>
					<select id="sendAccount" name="sendAccount" style="width:210px;height:25px;">
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- 添加展商账号表单 -->
<div id="addExhibitorDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="addExhibitorForm" name="addExhibitorForm">
        <table style="width: 430px;margin: 15px auto">
            <tr>
                <td style="width: 120px;text-align: right">展商中文名称：</td>
                <td><input class="easyui-validatebox" type="text" name="companyName"></td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">展商英文名称：</td>
                <td><input class="easyui-validatebox" type="text" name="companyNameE"></td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">用户名：</td>
                <td><input class="easyui-validatebox" type="text" name="username" required="true" missingMessage="用户名不能为空"></td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">密码：</td>
                <td><input class="easyui-validatebox" type="password" name="password" required="true" missingMessage="密码不能为空"></td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">展位号：</td>
                <td><input class="easyui-validatebox" type="text" name="boothNumber" required="true" missingMessage="展位号不能为空"></td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">国家：</td>
                <td>
					<select id="country" name="country" style="width:204px;height:25px;" onchange="country_change(this.options[this.options.selectedIndex].value)">
					</select>
				</td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">省份：</td>
                <td>
                	<select id="province" name="province" style="width:204px;height:25px;">
					</select>
				</td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">所属人：</td>
                <td>
					<select id="tag" name="tag" style="width:204px;height:25px;">
					</select>
				</td>
            </tr>
            <tr>
                <td style="width: 120px;text-align: right">展区：</td>
                <td>
					<select id="area" name="area" style="width:204px;height:25px;">
						<option selected value="">请选择</option>
						<option value="1">国内</option>
						<option value="2">国外</option>
					</select>
				</td>
            </tr>
			<tr>
				<td style="width: 120px;text-align: right">展厅：</td>
				<td><input class="easyui-validatebox" type="text" name="exhibitionPosition"></td>
			</tr>
            <tr>
                <td style="width: 120px;text-align: right">展位面积：</td>
                <td><input class="easyui-validatebox" type="text" name="exhibitionArea"></td>
            </tr>
			<tr>
				<td style="width: 120px;text-align: right">合同编号：</td>
				<td><input class="easyui-validatebox" type="text" name="contractId" required="true" missingMessage="合同编号不能为空"></td>
			</tr>
        </table>
    </form>
</div>

<!-- 批量修改所属人表单 -->
<div id="modifyExhibitorsTagDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="modifyExhibitorsTagForm" name="modifyExhibitorsTagForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: right">所属人：</td>
                <td>
					<select id="modifyTag" name="modifyTag" style="width:204px;">
					</select>
				</td>
            </tr>
        </table>
    </form>
</div>

<!-- 批量修改展团表单 -->
<div id="modifyExhibitorsGroupDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="modifyExhibitorsGroupForm" name="modifyExhibitorsGroupForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: right">展团：</td>
                <td>
					<select id="modifyGroup" name="modifyGroup" style="width:204px;">
					</select>
				</td>
            </tr>
        </table>
    </form>
</div>

<!-- 批量修改展区表单 -->
<div id="modifyExhibitorsAreaDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="modifyExhibitorsAreaForm" name="modifyExhibitorsAreaForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: right">展区：</td>
                <td>
					<select id="modifyArea" name="modifyArea" style="width:204px;">
						<option selected value="">请选择</option>
						<option value="1">国内</option>
						<option value="2">国外</option>
					</select>
				</td>
            </tr>
        </table>
    </form>
</div>

<!-- 导入展商账号 -->
<div id="importExhibitorsDlg" data-options="iconCls:'icon-add',modal:true">
	<form id="importExhibitorsForm" name="importExhibitorsForm">
	   	<table style="width: 320px;margin: 20px auto">
			<tr>
				<td colspan="2" style="width: 90px;text-align: left"><a href="${base}/resource/template.xls">下载导入模版</a><br /></td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">导入模版：</td>
				<td style="width: 90px;text-align: left"><input type="file" name="file" id="file" /></td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">国家：</td>
				<td>
					<select id="countryImport" name="country" style="width:200px;" onchange="country_change_import(this.options[this.options.selectedIndex].value)">
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">省份：</td>
				<td>
					<select id="provinceImport" name="province" style="width:200px;">
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">展区：</td>
				<td>
					<select id="areaImport" name="area" style="width:200px;">
						<option selected value="">请选择</option>
						<option value="1">国内</option>
						<option value="2">国外</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">展团：</td>
				<td>
					<select id="groupImport" name="group" style="width:200px;">
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">所属人：</td>
				<td>
					<select id="tagImport" name="tag" style="width:200px;">
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- 下载展位确认涵或布展委托函 -->
<div id="downloadExhibitorInvitationDlg" data-options="iconCls:'icon-add',modal:true">
	<form id="downloadExhibitorInvitationForm" name="downloadExhibitorInvitationForm">
		<table style="width: 180px;margin: 20px auto">
			<tr>
				<td style="text-align: center"><a id="downloadBoothConfirmation" href="#" class="easyui-linkbutton" style="margin-left: 10px" data-options="iconCls:'icon-save'">下载展位确认涵</a></td>
			</tr>
			<tr><td style="text-align: center"></td></tr>
			<tr>
				<td style="text-align: center"><a id="#" href="${base}/resource/Booth Setup Authorization of Xiamen Stone Fair 2017.pdf" class="easyui-linkbutton" style="margin-left: 10px" data-options="iconCls:'icon-save'">下载布展委托函</a></td>
			</tr>
		</table>
	</form>
</div>

<div id="previewExhibitorInvisationDlg" title="展商邀请涵预览" class="section-focus-pic" id="section-focus-pic">
	<div class="pages" data-scro="list">
		<p>
			<li class="item" style="left:0px;">
				<div style="width:600px;height:600px;">
					<div style="width:600px;height:500px;font-family:Times New Roman,Georgia,Serif; font-size:10px;font-color:#000000;">
						<p style="font-family:Calibri,Arial,Verdana; font-size:10px;">Dear &nbsp;<a href="#" id="contatctName"></a>,</p>
						<p>Thank you for choosing Xiamen Stone Fair on March 6-9, 2017. Well received your full payment and thank you!</p>
						<p>Please kindly find the Booth Confirmation and Booth Setup Authorization in attachment. The instructions are as follows.</p>
						<p>◇&nbsp;&nbsp;Booth Confirmation is the sole certificate for your participation in the 17th China Xiamen International Stone Fair. By presenting it along with your business card, you can claim Exhibitor Pass, Booth Set-up Pass and catalogue at Exhibitor Registration Counter on March 3-5, 2017.</p>
						<p>◇&nbsp;&nbsp;Booth Setup Authorization will take effect only with your company stamp. It is used for claiming Booth Set-up Pass by your assigned contractor in case of your late arrival.</p>
						<p>Exhibitor Area should be completed on time to guarantee your publicity on all promotional materials. Account and Password could be found on Booth Confirmation.</p>
						<p>Please click the link below to download Exhibitor Manual & Shipping Manual: <a href="http://www.stonefair.org.cn/about.asp?ID=92" target="_blank">http://www.stonefair.org.cn/about.asp?ID=92</a></p>
						<p>Any questions, please feel free to contact us.</p>
						<p>We are looking forward to your presence at Xiamen Stone Fair 2017!</p>
						<p>Yours,</p>
						<p>Best Regards,</p>
						<p>Organizing Committee of Xiamen Stone Fair</p>
					</div>
					<div style="font-family:Times New Roman,Georgia,Serif; font-size:12px;font-color:#000000;">
						<p><a href="#" id="boothConfirm" target="_blank"></a></p>
						<p><a href="${base}/resource/Booth Setup Authorization of Xiamen Stone Fair 2017.pdf" target="_blank">Booth Setup Authorization of Xiamen Stone Fair 2017.pdf</a></p>
					</div>
				</div>
			</li>
		</ul>
	</div>
	<div class="controler" data-scro="controler">
		<b class="down">1</b>
		<b>2</b>
		<b>3</b>
	</div>
	<div class="controler2" data-scro="controler2">
		<a href="javascript:prevExhibitorInvitation();" class="prev"><i></i></a>
		<a href="javascript:nextExhibitorInvitation();" class="next"><i></i></a>
	</div>
</div>

<!-- 工具栏 -->
<div id="toolbar">
    <div>
        <div id="addExhibitor" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加展商账号</div>
		<div id="modifyExhibitorsTag" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改所属人</div>
		<div id="modifyExhibitorsGroup" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改展团</div>
		<div id="modifyExhibitorsArea" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改展区</div>
        <div id="removeExhibitor" class="easyui-linkbutton" iconCls="icon-remove" plain="true">注销展商账号</div>
        <div id="enableExhibitor" class="easyui-linkbutton" iconCls="icon-edit" plain="true">启用展商账号</div>
        <!--<div id="deleteExhibitor" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除展商账号</div>-->
        <div class="easyui-menubutton" menu="#export" iconCls="icon-redo">导出</div>
		<div class="easyui-menubutton" menu="#import" iconCls="icon-undo">导入</div>
		<div class="easyui-menubutton" menu="#exhibitorInvitation" iconCls="icon-redo">展商邀请涵</div>
    </div>
    <div id="export" style="width:180px;">
    	<div id="exportAllTransactions" iconCls="icon-redo">所有会刊</div>
    	<div id="exportSelectedTransactions" iconCls="icon-redo">所选会刊</div>
    	<div class="menu-sep"></div>
		<div id="exportAllBoothNumAndMeipai" iconCls="icon-redo">所有展位号+企业楣牌</div>
		<div id="exportSelectedBoothNumAndMeipai" iconCls="icon-redo">所选展位号+企业楣牌</div>
		<div class="menu-sep"></div>
		<div id="exportAllExhibitors" iconCls="icon-redo">所有展商基本信息到Excel</div>
		<div id="exportSelectedExhibitors" iconCls="icon-redo">所选展商基本信息到Excel</div>
        <div id="exportAllContacts" iconCls="icon-redo">所有联系人列表到Excel</div>
        <div id="exportSelectedContacts" iconCls="icon-redo">所选联系人列表到Excel</div>
		<div id="exportAllExhibitorJoiners" iconCls="icon-redo">所有参展人员列表到Excel</div>
		<div id="exportSelectedExhibitorJoiners" iconCls="icon-redo">所选参展人员列表到Excel</div>
		<div class="menu-sep"></div>
		<div id="exportOutOfGroupExhibitorJoiners" iconCls="icon-redo">所有非展团境外参展人员名单</div>
		<div class="menu-sep"></div>
		<div class="menu-sep"></div>
		<div id="exportAllExhibitorInvitations" iconCls="icon-redo">所有展商邀请涵邮箱</div>
		<div class="menu-sep"></div>
		<div id="exportAllExhibitorInvitationInfoImage" iconCls="icon-redo">导出所有展商发票图片</div>
		<div id="exportSelectedExhibitorInvitationInfoImage" iconCls="icon-redo">导出所选展商发票图片</div>
		<div id="exportAllExhibitorInvitationInfo" iconCls="icon-redo">所有展商发票信息</div>
		<div id="exportSelectedExhibitorInvitationInfo" iconCls="icon-redo">所选展商发票信息</div>
	</div>
	<div id="exhibitorInvitation" style="width:200px;">
		<div id="sendExhibitorInvitation" iconCls="icon-redo">发送展位确认涵</div>
		<div id="priviewExhibitorInvitation" target="_blank" method="post" iconCls="icon-redo">预览展位确认涵</div>
		<div id="downloadExhibitorInvitation" iconCls="icon-redo">下载展位确认涵或布展委托函</div>
	</div>
	<div id="import" style="width:100px;">
		<div id="importExhibitor" iconCls="icon-undo">导入展商账号</div>
	</div>
</div>

<div class="loading"><img src="${base}/resource/load.gif"></div>
<script>
	var checkedItems = [];
	var country = [];
	var province = [];
	var tags = {};
	var groups = {};
	var exhibitorsProvinceOld = -1;
	var exhibitorsCountryOld = -1;
	var eidParm1 = document.getElementById("eidParm1");
	var eidParm2 = document.getElementById("eidParm2");
	var eidParm3 = document.getElementById("eidParm3");
	var classify = document.getElementById("classify");
	var order = "asc";
	var previewExhibitorList = [];
	var previewExhibitorIndex = 0;
//----------------------------------------------------------工具栏按钮开始------------------------------------------------------------//
	//发送展商邀请涵
	$('#sendExhibitorInvitation').click(function(){
		if(checkedItems.length > 0){
			$.messager.confirm('确认发送','你确定要发送展位确认涵吗?',function(r){
				if(r){
					$("#bg,.loading").show();
					$.ajax({
						url: "${base}/user/sendExhibitorInvisitor",
						type: "post",
						dataType: "json",
						data: {"eids": checkedItems},
						traditional: true,
						success: function (data) {
							$("#bg,.loading").hide();
							if (data.resultCode == 0) {
								checkedItems = [];
								alert("发送展位确认涵成功");
								window.location.href = window.location.href;
							} else if (data.resultCode == 2) {
								$.messager.alert('错误', data.description);
							} else {
								$.messager.alert('错误', '系统错误');
							}
						}
					});
				}
			});
		}else{
			$.messager.alert('提示', '请至少选择一项再操作');
		}
	});

	$('#priviewExhibitorInvitation').click(function(){
		if(checkedItems.length > 0){
			$("#bg,.loading").show();
			$.ajax({
				url: "${base}/user/previewExhibitorInvisitor",
				type: "post",
				dataType: "json",
				data: {"eids": checkedItems},
				traditional: true,
				success: function (data) {
					$("#bg,.loading").hide();
					if (data.resultCode == 0) {
						previewExhibitorIndex = 0;
						previewExhibitorList = data.previewExhibitorInvitationList;
						var previewExhibitor = previewExhibitorList[previewExhibitorIndex];
						$("#contatctName").html(previewExhibitor.contactName);

						//$("#boothConfirm").html(previewExhibitor.boothConfirm);
						$("#boothConfirm").html("Booth Confirmation of Xiamen Stone Fair 2017.pdf");
						var boothConfirmHref = "${base}/user/showExhibitorInvitation?eid=" + previewExhibitor.eid;
						document.getElementById('boothConfirm').href = boothConfirmHref;
						$("#previewExhibitorInvisationDlg").dialog("open");
					} else if (data.resultCode == 2) {
						$.messager.alert('错误', data.description);
					} else {
						$.messager.alert('错误', '系统错误');
					}
				}
			});
		}else{
			$.messager.alert('提示', '请至少选择一项再操作');
		}
	});

	//添加展商账号
	$('#addExhibitor').click(function(){
		document.getElementById("addExhibitorForm").reset();
       	$("#country").html('');
		$("#country").append('<option value="">请选择</option>');
		for(var i=0,a;a=country[i++];){
			$("#country").append('<option value="'+a.id+'">'+a.countryValue+a.chineseName+'</option>');
		}
		$("#province").html('');
		document.getElementById('province').disabled=true;
		$("#tag").html('');
		$("#tag").append('<option value="">请选择</option>');
		for(var tag in tags){
			$("#tag").append('<option value="'+tag+'">'+tags[tag]+'</option>');
		}
        $("#addExhibitorDlg").dialog("open");
	});
	//批量修改所属人
	$('#modifyExhibitorsTag').click(function(){
		if(checkedItems.length > 0){
			$.ajax({
	       		type:"POST",
	       		dataType:"json",
	       		url:"${base}/user/queryTags",
	       		success : function(result) {
	       			if(result){
	       				$("#modifyTag").html('');
	       				$("#modifyTag").append('<option value="">请选择</option>');
	       				for(var i=0,a;a=result.rows[i++];){
	       					$("#modifyTag").append('<option value="'+a.id+'">'+a.name+'</option>');
	       				}
	       			}
	       		}
	       	});
	        $("#modifyExhibitorsTagDlg").dialog("open");
		}else{
			$.messager.alert('提示', '请至少选择一项展商再修改所属人');
		}
	});
	//批量修改展团
	$('#modifyExhibitorsGroup').click(function(){
		if(checkedItems.length > 0){
			$.ajax({
	       		type:"POST",
	       		dataType:"json",
	       		url:"${base}/user/queryExhibitorGroupByPage",
	       		success : function(result) {
	       			if(result){
	       				$("#modifyGroup").html('');
	       				$("#modifyGroup").append('<option value="">请选择</option>');
	       				for(var i=0,a;a=result.rows[i++];){
//	        				    console.log(a);
	       					$("#modifyGroup").append('<option value="'+a.id+'">'+a.groupName+'</option>');
	       				}
						$("#modifyGroup").append('<option value="0">无</option>');
	       			}
	       		}
	       	});
	        $("#modifyExhibitorsGroupDlg").dialog("open");
		}else{
			$.messager.alert('提示', '请至少选择一项展商再修改所属人');
		}
	});
	//批量修改展区
	$('#modifyExhibitorsArea').click(function(){
		if(checkedItems.length > 0){
	        $("#modifyExhibitorsAreaDlg").dialog("open");
		}else{
			$.messager.alert('提示', '请至少选择一项展商再修改所属人');
		}
	});
	//注销展商账号
	$('#removeExhibitor').click(function(){
		if(checkedItems.length > 0){
			$.messager.confirm('注销展商','你确定要注销展商吗?',function(r){
			    if (r){
			    	$.ajax({
		                url: "${base}/user/disableExhibitors",
		                type: "post",
		                dataType: "json",
		                data: {"eids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	$("#exhibitors").datagrid("reload");
                                $('#exhibitors').datagrid('clearSelections');
		                    	checkedItems = [];
		                        $.messager.show({
		                            title: '成功',
		                            msg: '注销成功',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });
		                    } else {
		                        $.messager.alert('错误', '系统错误');
		                    }
		                }
		            });
			    }
			});
		}else{
			$.messager.alert('提示', '请至少选择一项展商再注销');
		}
	});
	//启用展商账号
	$('#enableExhibitor').click(function(){
		if(checkedItems.length > 0){
			$.messager.confirm('启用展商','你确定要启用展商吗?',function(r){
			    if (r){
			    	$.ajax({
		                url: "${base}/user/enableExhibitors",
		                type: "post",
		                dataType: "json",
		                data: {"eids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	$("#exhibitors").datagrid("reload");
                                $('#exhibitors').datagrid('clearSelections');
		                    	checkedItems = [];
		                        $.messager.show({
		                            title: '成功',
		                            msg: '启用成功',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });
		                    } else {
		                        $.messager.alert('错误', '系统错误');
		                    }
		                }
		            });
			    }
			});
		}else{
			$.messager.alert('提示', '请至少选择一项展商再启用');
		}
	});
	//删除展商账号
	$('#deleteExhibitor').click(function(){
		if(checkedItems.length > 0){
			$.messager.confirm('删除展商','你确定要删除展商吗?',function(r){
			    if (r){
			    	$.ajax({
		                url: "${base}/user/deleteExhibitors",
		                type: "post",
		                dataType: "json",
		                data: {"eids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	$("#exhibitors").datagrid("reload");
                                $('#exhibitors').datagrid('clearSelections');
		                    	checkedItems = [];
		                        $.messager.show({
		                            title: '成功',
		                            msg: '删除成功',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });
		                    } else {
		                        $.messager.alert('错误', '系统错误');
		                    }
		                }
		            });
		        	$.messager.alert('提示', '删除展商成功');
			    }
			});
		}else{
			$.messager.alert('提示', '请至少选择一项展商再删除');
		}
	});

	//导出所有会刊
	$('#exportAllTransactions').click(function(){
        eidParm1.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm1.innerHTML += node;
        document.getElementById("exportTransactionsToZip").submit();
        $.messager.alert('提示', '请勿关闭窗口,耐心等待1~2分钟后会提示下载');
	});
	//导出所选会刊
	$('#exportSelectedTransactions').click(function(){
//     	alert(checkedItems);
		eidParm1.innerHTML = "";
//     	alert(eidParm1.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
        		var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
        		eidParm1.innerHTML += node;
        	}
//         	alert(eidParm1.innerHTML);
        	document.getElementById("exportTransactionsToZip").submit();
        	$.messager.alert('提示', '导出所选会刊成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
	//导出所有展商到Excel
	$('#exportAllExhibitors').click(function(){
        eidParm2.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm2.innerHTML += node;
        document.getElementById("exportExhibitorsToExcel").submit();
        $.messager.alert('提示', '导出所有展商成功');
	});
	//导出所选展商到Excel
	$('#exportSelectedExhibitors').click(function(){
//     	alert(checkedItems);
		eidParm2.innerHTML = "";
//     	alert(eidParm2.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
        		var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
        		eidParm2.innerHTML += node;
        	}
//         	alert(eidParm2.innerHTML);
        	document.getElementById("exportExhibitorsToExcel").submit();
        	$.messager.alert('提示', '导出所选展商成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
	//导出所有展位号+企业楣牌
	$('#exportAllBoothNumAndMeipai').click(function(){
        eidParm3.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm3.innerHTML += node;
        document.getElementById("exportBoothNumAndMeipaiToExcel").submit();
        $.messager.alert('提示', '导出所有展位号+企业楣牌成功');
	});
	//导出所选展位号+企业楣牌
	$('#exportSelectedBoothNumAndMeipai').click(function(){
//     	alert(checkedItems);
		eidParm3.innerHTML = "";
//     	alert(eidParm3.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
        		var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
        		eidParm3.innerHTML += node;
        	}
//         	alert(eidParm3.innerHTML);
        	document.getElementById("exportBoothNumAndMeipaiToExcel").submit();
        	$.messager.alert('提示', '导出所选展商成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
    //导出所有展商联系人信息到Excel
    $('#exportAllContacts').click(function(){
        eidParm4.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm4.innerHTML += node;
        document.getElementById("exportContactsToExcel").submit();
        $.messager.alert('提示', '导出所有展商联系人信息成功');
    });
    //导出所选展商联系人信息到Excel
    $('#exportSelectedContacts').click(function(){
//     	alert(checkedItems);
        eidParm4.innerHTML = "";
//     	alert(eidParm4.innerHTML);
        if(checkedItems.length > 0){
            for (var i = 0; i < checkedItems.length; i++) {
                var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
                eidParm4.innerHTML += node;
            }
//         	alert(eidParm4.innerHTML);
            document.getElementById("exportContactsToExcel").submit();
            $.messager.alert('提示', '导出所选展商成功');
        }else{
            $.messager.alert('提示', '请至少选择一项展商再导出');
        }
    });
	//导出所有非展团境外参展人员信息到Excel
	$('#exportOutOfGroupExhibitorJoiners').click(function(){
		eidParm10.innerHTML = "";
		var node = "<input type='hidden' name='eids' value='-1'/>";
		eidParm10.innerHTML += node;
		document.getElementById("exportOutOfGroupExhibitorJoinersToExcel").submit();
		$.messager.alert('提示', '导出所有非展团境外参展人员信息成功');
	});
	//导出所有展商参展人员信息到Excel
	$('#exportAllExhibitorJoiners').click(function(){
		eidParm5.innerHTML = "";
		var node = "<input type='hidden' name='eids' value='-1'/>";
		eidParm5.innerHTML += node;
		document.getElementById("exportExhibitorJoinersToExcel").submit();
		$.messager.alert('提示', '导出所有展商参展人员信息成功');
	});
	//导出所选展商参展人员信息到Excel
	$('#exportSelectedExhibitorJoiners').click(function(){
//     	alert(checkedItems);
		eidParm5.innerHTML = "";
//     	alert(eidParm4.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
				var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
				eidParm5.innerHTML += node;
			}
//         	alert(eidParm5.innerHTML);
			document.getElementById("exportExhibitorJoinersToExcel").submit();
			$.messager.alert('提示', '导出所选展商成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
	//导出所有展商邀请涵邮件到Excel
    $('#exportAllExhibitorInvitations').click(function(){
        eidParm6.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm6.innerHTML += node;
        document.getElementById("exportAllExhibitorInvitationsToExcel").submit();
        $.messager.alert('提示', '导出所有展商邀请涵邮箱成功');
    });
	//导出所有展商增值税专用发票图片
	$('#exportAllExhibitorInvitationInfoImage').click(function(){
		eidParm9.innerHTML = "";
		var node = "<input type='hidden' name='eids' value='-1'/>";
		eidParm9.innerHTML += node;
		document.getElementById("exportExhibitorInvitationImageToZip").submit();
		$.messager.alert('提示', '请勿关闭窗口,耐心等待1~2分钟后会提示下载');
	});
	//导出所选展商增值税专用发票图片
	$('#exportSelectedExhibitorInvitationInfoImage').click(function(){
		eidParm9.innerHTML = "";
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
				var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
				eidParm9.innerHTML += node;
			}
			document.getElementById("exportExhibitorInvitationImageToZip").submit();
			$.messager.alert('提示', '导出所选展商增值税专用发票图片成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});

	//导出所有展商增值税专用发票信息
	$('#exportAllExhibitorInvitationInfo').click(function(){
		eidParm7.innerHTML = "";
		var node = "<input type='hidden' name='eids' value='-1'/>";
		eidParm7.innerHTML += node;
		document.getElementById("exportExhibitorInvitationToZip").submit();
		$.messager.alert('提示', '请勿关闭窗口,耐心等待1~2分钟后会提示下载');
	});
	//导出所选展商增值税专用发票信息
	$('#exportSelectedExhibitorInvitationInfo').click(function(){
		eidParm7.innerHTML = "";
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
				var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
				eidParm7.innerHTML += node;
			}
			document.getElementById("exportExhibitorInvitationToZip").submit();
			$.messager.alert('提示', '导出所选展商增值税专用发票信息成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});

	//导入展商账号
	$('#importExhibitor').click(function(){
		$("#countryImport").html('');
		$("#countryImport").append('<option value="">请选择</option>');
		for(var i=0,a;a=country[i++];){
// 			console.log(a);
			$("#countryImport").append('<option value="'+a.id+'">'+a.countryValue+a.chineseName+'</option>');
		}
		$("#provinceImport").html('');
		document.getElementById('provinceImport').disabled=true;
		$.ajax({
       		type:"POST",
       		dataType:"json",
       		url:"${base}/user/queryExhibitorGroupByPage",
       		success : function(result) {
       			if(result){
       				$("#groupImport").html('');
       				$("#groupImport").append('<option value="">请选择</option>');
       				for(var i=0,a;a=result.rows[i++];){
//        				    console.log(a);
       					$("#groupImport").append('<option value="'+a.id+'">'+a.groupName+'</option>');
       				}
       			}
       		}
       	});
		$.ajax({
       		type:"POST",
       		dataType:"json",
       		url:"${base}/user/queryTags",
       		success : function(result) {
       			if(result){
       				$("#tagImport").html('');
       				$("#tagImport").append('<option value="">请选择</option>');
       				for(var i=0,a;a=result.rows[i++];){
//        				    console.log(a);
       					$("#tagImport").append('<option value="'+a.id+'">'+a.name+'</option>');
       				}
       			}
       		}
       	});
		$("#importExhibitorsDlg").dialog("open");
	});
	//打开展位确认涵和布展委托涵提示框
	$('#downloadExhibitorInvitation').click(function(){
		$("#downloadExhibitorInvitationDlg").dialog("open");
	});
//----------------------------------------------------------工具栏按钮结束------------------------------------------------------------//
//----------------------------------------------------------自定义函数开始------------------------------------------------------------//
	function prevExhibitorInvitation() {
		previewExhibitorIndex = previewExhibitorIndex - 1;
		if(previewExhibitorIndex < 0){
			alert("已经到头了。。");
			return;
		}else{
			var previewExhibitor = previewExhibitorList[previewExhibitorIndex];
			$("#contatctName").html(previewExhibitor.contactName);
			//$("#boothConfirm").html(previewExhibitor.boothConfirm);
			$("#boothConfirm").html("Booth Confirmation of Xiamen Stone Fair 2017.pdf");
			var boothConfirmHref = "${base}/user/showExhibitorInvitation?eid=" + previewExhibitor.eid;
			document.getElementById('boothConfirm').href = boothConfirmHref;
		}
	}

	function nextExhibitorInvitation() {
		previewExhibitorIndex = previewExhibitorIndex + 1;
		if(previewExhibitorIndex >= previewExhibitorList.length){
			alert("已经到尾了。。");
			return;
		}else{
			var previewExhibitor = previewExhibitorList[previewExhibitorIndex];
			$("#contatctName").html(previewExhibitor.contactName);
			//$("#boothConfirm").html(previewExhibitor.boothConfirm);
			$("#boothConfirm").html("Booth Confirmation of Xiamen Stone Fair 2017.pdf");
			var boothConfirmHref = "${base}/user/showExhibitorInvitation?eid=" + previewExhibitor.eid;
			document.getElementById('boothConfirm').href = boothConfirmHref;
		}
	}

	function formatTag(val, row) {
        if (val != null) {
			return tags[val];
        } else {
            return null;
        }
    }
	function formatGroup(val, row) {
        if (val != null) {
			return groups[val];
        } else {
            return null;
        }
    }
	function formatArea(val, row) {
        if (val == 1) {
			return "国内";
        } else if (val == 2) {
        	return "国外";
        } else return "";
    }
    function formatCountry(val, row) {
        if (val != null) {
        	if(val == 44) return country[0].chineseName;
        	if(val > 0 && val <= 43){
	            return country[val].chineseName;
        	}else if(val > 43 && val <= 240){
        		return country[val - 1].chineseName;
        	}else{
        		return null;
        	}
        } else {
            return null;
        }
    }
	function formatProvince(val, row) {
        if (val != null) {
        	if(val > 0 && val <= province.length){
	            return province[val - 1].chineseName;
        	}
        	return null;
        } else {
            return null;
        }
    }
    function formatStatus(val, row) {
        if (val == 0) {
            return '正常';
        } else {
            return '注销';
        }
    }

    function country_change(countryId){
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryProvinceByCountryId",
    		data:{ 'countryId': countryId },
    		success : function(result) {
    			if(result){
    				$("#province").html('');
    				document.getElementById('province').disabled=false;
	   		 		$("#province").append('<option value="">请选择</option>');
	   		 		for(var i=0,a;a=province[i++];){
// 	   		 		    console.log(a);
	   		 			$("#province").append('<option value="'+a.id+'">'+a.chineseName+'</option>');
	   		 		}
    			}
    		},
    		error : function(result) {
   				$("#province").html('');
   				document.getElementById('province').disabled=true;
    		}
    	});
    }
    function country_change_import(countryId){
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryProvinceByCountryId",
    		data:{ 'countryId': countryId },
    		success : function(result) {
    			if(result){
    				$("#provinceImport").html('');
    				document.getElementById('provinceImport').disabled=false;
	   		 		$("#provinceImport").append('<option value="">请选择</option>');
	   		 		for(var i=0,a;a=province[i++];){
// 	   		 		    console.log(a);
	   		 			$("#provinceImport").append('<option value="'+a.id+'">'+a.chineseName+'</option>');
	   		 		}
    			}
    		},
    		error : function(result) {
   				$("#provinceImport").html('');
   				document.getElementById('provinceImport').disabled=true;
    		}
    	});
    }

    // 列表过滤功能
    function filter(countryId){
    	var filterParm = "?";
//     	console.log("exhibitorsAreaOld:"+exhibitorsAreaOld);
//     	console.log("exhibitorsArea:"+document.getElementById("exhibitorsArea").value);
//     	console.log("exhibitorsCountryOld"+exhibitorsCountryOld);
//     	console.log("exhibitorsCountry:"+document.getElementById("exhibitorsCountry").value);
//     	console.log("====================================================");
    	if(document.getElementById("exhibitorsTag").value != ""){
    		filterParm += '&tag=' + document.getElementById("exhibitorsTag").value;
    	}
    	if(document.getElementById("exhibitorsGroup").value != ""){
    		filterParm += '&group=' + document.getElementById("exhibitorsGroup").value;
    	}
    	if(document.getElementById("exhibitorsBoothNumber").value != ""){
    		filterParm += '&boothNumber=' + document.getElementById("exhibitorsBoothNumber").value;
    	}
    	if(document.getElementById("exhibitorsCompany").value != ""){
    		filterParm += '&company=' + encodeURI(document.getElementById("exhibitorsCompany").value);
    	}
    	if(document.getElementById("exhibitorsCompanye").value != ""){
    		filterParm += '&companye=' + encodeURI(document.getElementById("exhibitorsCompanye").value);
    	}
		if(document.getElementById("exhibitorsContractId").value != ""){
			filterParm += '&contractId=' + encodeURI(document.getElementById("exhibitorsContractId").value);
		}
    	if(document.getElementById("exhibitorsArea").value != ""){
    		filterParm += '&area=' + document.getElementById("exhibitorsArea").value;
    	}
    	if(document.getElementById("exhibitorsCountry").value != ""){
    		if(document.getElementById("exhibitorsCountry").value != exhibitorsCountryOld){
    			filterParm += '&country=' + document.getElementById("exhibitorsCountry").value;
    			exhibitorsCountryOld = document.getElementById("exhibitorsCountry").value;
        		$.ajax({
            		type:"POST",
            		dataType:"json",
            		url:"${base}/user/queryProvinceByCountryId",
            		data:{ 'countryId': countryId },
            		success : function(result) {
            			if(result){
            				$("#exhibitorsProvince").html('');
            				document.getElementById('exhibitorsProvince').disabled=false;
        	   		 		$("#exhibitorsProvince").append('<option value="">请选择</option>');
        	   		 		for(var i=0,a;a=province[i++];){
//         	   		 		    console.log(a);
        	   		 			$("#exhibitorsProvince").append('<option value="'+a.id+'">'+a.chineseName+'</option>');
        	   		 		}
            			}
            		},
            		error : function(result) {
           				$("#exhibitorsProvince").html('');
           				document.getElementById('exhibitorsProvince').disabled=true;
            		}
            	});
    		}
    	}else{
    		filterParm += '&country=' + document.getElementById("exhibitorsCountry").value;
			exhibitorsCountryOld = document.getElementById("exhibitorsCountry").value;
    		$("#exhibitorsProvince").html('');
			document.getElementById('exhibitorsProvince').disabled=true;
    	}
    	if(document.getElementById("exhibitorsProvince").value != ""){
    		if(document.getElementById("exhibitorsProvince").value != exhibitorsProvinceOld){
	    		filterParm += '&province=' + document.getElementById("exhibitorsProvince").value;
	    		exhibitorsProvinceOld = document.getElementById("exhibitorsProvince").value;
    		}
    	}
    	if(document.getElementById("exhibitorsIsLogout").value != ""){
    		filterParm += '&isLogout=' + document.getElementById("exhibitorsIsLogout").value;
    	}
    	$('#exhibitors').datagrid('options').url = '${base}/user/queryExhibitorsByPage' + filterParm;
        $('#exhibitors').datagrid('reload');
    }
//----------------------------------------------------------自定义函数结束------------------------------------------------------------//
    $(document).ready(function () {
		$("#previewExhibitorInvisationDlg").dialog({
			autoOpen: false,
			show: {
				effect: "blind",
				duration: 1000
			},
			hide: {
				effect: "explode",
				duration: 1000
			}
		});
		$("#previewExhibitorInvisationDlg").dialog("close");
    	//加载国家列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryAllCountry",
    		success : function(result) {
    			if(result){
    				country = result;
    				$("#exhibitorsCountry").html('');
    				$("#exhibitorsCountry").append('<option value="">全部</option>');
    				for(var i=0,a;a=country[i++];){
//     					console.log(a);
    					$("#exhibitorsCountry").append('<option value="'+a.id+'">'+a.countryValue+a.chineseName+'</option>');
    				}
    				document.getElementById('exhibitorsProvince').disabled=true;
//     				for(var i=0,a;a=result.areas[i++];){
//     				    console.log(a.text);
//     				}
    			}
    		}
    	});
    	//加载省份列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryAllProvince",
    		success : function(result) {
    			if(result){
    				province = result;
//     				for(var i=0,a;a=result.areas[i++];){
//     				    console.log(a.text);
//     				}
    			}
    		}
    	});
    	//加载所属人列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryTags?rows=50",
    		success : function(result) {
    			if(result){
    				$("#exhibitorsTag").html('');
    				$("#exhibitorsTag").append('<option value="">全部</option>');
    				for(var i=0,a;a=result.rows[i++];){
    					tags[a.id] = a.name;
    					$("#exhibitorsTag").append('<option value="'+a.id+'">'+a.name+'</option>');
    				}
//     				for(var i=0,a;a=result.rows[i++];){
//     				    console.log(a.id + ":" + a.name);
//     				}
    			}
    		}
    	});
    	//加载展团列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryExhibitorGroupByPage",
    		success : function(result) {
    			if(result){
    				$("#exhibitorsGroup").html('');
    				$("#exhibitorsGroup").append('<option value="">全部</option>');
    				for(var i=0,a;a=result.rows[i++];){
    					groups[a.id] = a.groupName;
    					$("#exhibitorsGroup").append('<option value="'+a.id+'">'+a.groupName+'</option>');
    				}
//     				for(var i=0,a;a=result.rows[i++];){
//     				    console.log(a.id + ":" + a.name);
//     				}
    			}
    		}
    	});

    	$('#menu').accordion({
			onSelect: function(title){
				if(title == "公告管理"){
					addTab("公告列表","${base}/user/article");
				}else if(title == "标签管理"){
					addTab("标签列表","${base}/user/tag");
				}else if(title == "VISA管理"){
					addTab("展商VISA列表","${base}/user/tVisa");
				}else if(title == "客商管理"){
					addTab("国内客商","${base}/user/inlandCustomer");
				}else if(title == "展商管理"){
					addTab("展商列表","${base}/user/exhibitor");
				}else if(title == "模板管理") {
					addTab("邮件模板","${base}/user/tEmail");
				} else if(title == "数据报表") {
					addTab("数据报表","${base}/user/tReport");
				}
			}
		});

        // 展商列表渲染
		$('#exhibitors').datagrid({
            onSelect:function (rowIndex, rowData){
            	var row = $('#exhibitors').datagrid('getSelections');
				for (var i = 0; i < row.length; i++) {
					if (findCheckedItem(row[i].eid) == -1) {
						checkedItems.push(row[i].eid);
					}
				}
            },
            onUnselect:function (rowIndex, rowData){
				var k = findCheckedItem(rowData.eid);
				if (k != -1) {
					checkedItems.splice(k, 1);
				}
            },
            onSelectAll:function (rows){
            	for (var i = 0; i < rows.length; i++) {
            		var k = findCheckedItem(rows[i].eid);
					if (k == -1) {
						checkedItems.push(rows[i].eid);
					}
				}
            },
            onUnselectAll:function (rows){
            	for (var i = 0; i < rows.length; i++) {
					var k = findCheckedItem(rows[i].eid);
					if (k != -1) {
						checkedItems.splice(k, 1);
					}
				}
            },
            rowStyler:function(index,row){
				if (row.infoFlag == 4){
					return 'color:green;font-weight:bold;';	//今年有更新并且完整-绿色
				}else if (row.infoFlag == 3){
					return 'color:orange;font-weight:bold;';//非必填项缺失-橙色
				}else if (row.infoFlag == 2){
					return 'color:red;font-weight:bold;';	//必填项缺失-红色
				}else if (row.infoFlag == 1){
					return 'color:green;font-weight:bold;';	//账号信息完整-绿色
				} else if(row.infoFlag == 5) {
					return 'color:black;font-weight:bold;';	//账号刚激活，但未登录的
				}
			},
            onDblClickRow: function (index, field, value) {
            	if(field.company != ""){
	                if (!$("#tabs").tabs("exists", field.company)) {
	                    $('#tabs').tabs('add', {
	                        title: field.company,
	                        content:'<iframe frameborder="0" src="'+ "${base}/user/exhibitor?eid=" + field.eid+'" style="width:100%;height:99%;"></iframe>',
	                        closable: true
	                    });
	                } else {
	                    $("#tabs").tabs("select", field.company);
	                }
            	}else if(field.companye != ""){
            		if (!$("#tabs").tabs("exists", field.companye)) {
	                    $('#tabs').tabs('add', {
	                        title: field.companye,
	                        content:'<iframe frameborder="0" src="'+ "${base}/user/exhibitor?eid=" + field.eid+'" style="width:100%;height:99%;"></iframe>',
	                        closable: true
	                    });
	                } else {
	                    $("#tabs").tabs("select", field.companye);
	                }
            	}
            }
        }).datagrid('getPager').pagination({
            pageSize: 20,//每页显示的记录条数，默认为10
            pageList: [10,20,30,40,50],//可以设置每页记录条数的列表
            beforePageText: '第',//页数文本框前显示的汉字
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
        });
        function findCheckedItem(eid) {
			for (var i = 0; i < checkedItems.length; i++) {
				if (checkedItems[i] == eid) return i;
			}
			return -1;
		}
		// 全局排序功能
		$("#exhibitors").data().datagrid.dc.view.find("div.datagrid-header td .sortable").click(function(){
			if(order == "asc"){
				$('#exhibitors').datagrid('reload', {
					sort : $(this).prop("id").substr(1, $(this).prop("id").length),
					order : order
				});
				$(this).html($(this).html().split(" ▲")[0].split(" ▼")[0] + " ▲");
				order = "desc";
			}else if(order == "desc"){
				$('#exhibitors').datagrid('reload', {
					sort : $(this).prop("id").substr(1, $(this).prop("id").length),
					order : order
				});
				$(this).html($(this).html().split(" ▲")[0].split(" ▼")[0] + " ▼");
				order = "null";
			}else{
				$('#exhibitors').datagrid('reload', {
					sort : null,
					order : null
				});
				$(this).html($(this).html().split(" ▲")[0].split(" ▼")[0]);
				order = "asc";
			}
		});

		// 发送展商邀请涵弹出框
		$('#sendExhibitorInvitationDlg').dialog({
			title: '发送展商邀请涵',
			width: 520,
			height: 200,
			closed: true,
			cache: false,
			modal: true,
			buttons: [
				{
					text: '确认发送',
					iconCls: 'icon-ok',
					handler: function () {
						var sendAccountTag = document.getElementById("sendAccount").value;
						if(checkedItems.length > 0){
							$.messager.confirm('确认发送','你确定要用【' + tags[sendAccountTag] + '】账号发送展商邀请涵吗?',function(r){
								$.ajax({
									url: "${base}/user/sendExhibitorInvisitor",
									type: "post",
									dataType: "json",
									data: {"eids": checkedItems, "sendAccountTag": sendAccountTag},
									traditional: true,
									success: function (data) {
										if (data.resultCode == 0) {
											$("#sendExhibitorInvitationDlg").dialog("close");
											checkedItems = [];
											$.messager.show({
												title: '成功',
												msg: '发送展商邀请涵成功',
												timeout: 3000,
												showType: 'slide'
											});
											$("#sendExhibitorInvitationForm").clearForm();
											window.location.href = window.location.href;
										} else if (data.resultCode == 2) {
											$.messager.alert('错误', data.description);
										} else {
											$.messager.alert('错误', '系统错误');
										}
									}
								});
							});
						}else{
							$.messager.alert('提示', '请至少选择一项再操作');
						}
					}
				},
				{
					text: '取消',
					handler: function () {
						document.getElementById("sendExhibitorInvitationForm").reset();
						$("#sendExhibitorInvitationDlg").dialog("close");
					}
				}
			]
		});

        // 添加展商账号弹出框
        $('#addExhibitorDlg').dialog({
            title: '添加展商账号',
            width: 445,
            height: 480,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认添加',
                    iconCls: 'icon-ok',
                    handler: function () {
                        if ($("#addExhibitorForm").form("validate")) {
                        	if(document.addExhibitorForm.companyName.value.trim() != "" || document.addExhibitorForm.companyNameE.value.trim() != ""){
                        		$.ajax({
                                    url: "${base}/user/addExhibitor",
                                    type: "post",
                                    dataType: "json",
                                    data: $("#addExhibitorForm").serializeJson(),
                                    success: function (data) {
                                        if (data.resultCode == 0) {
                                            $("#addExhibitorDlg").dialog("close");
                                            $.messager.show({
                                                title: '成功',
                                                msg: '添加展商账号成功',
                                                timeout: 5000,
                                                showType: 'slide'
                                            });
                                            $("#exhibitors").datagrid("reload");
                                            $('#exhibitors').datagrid('clearSelections');
                                            $("#addExhibitorForm").clearForm();
                                        } else if (data.resultCode == 2) {
                                            $.messager.alert('错误', data.description);
                                        } else {
                                            $.messager.alert('错误', '系统错误');
                                        }
                                    }
                                });
                        	}else{
                        		$.messager.alert('错误', '展商中文名或英文名至少要填一个');
                        	}
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("addExhibitorForm").reset();
                    	$("#addExhibitorDlg").dialog("close");
                    }
                }
            ]
        });
		// 批量修改所属人弹出框
        $('#modifyExhibitorsTagDlg').dialog({
            title: '批量修改所属人',
            width: 360,
            height: 150,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	if(checkedItems.length > 0){
                    		var tag = document.getElementById("modifyTag").value;
                    		$.ajax({
                                url: "${base}/user/modifyExhibitorsTag",
                                type: "post",
                                dataType: "json",
                                data: {"eids": checkedItems, "tag": tag},
                                traditional: true,
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                    	$("#modifyExhibitorsTagDlg").dialog("close");
                                    	$("#exhibitors").datagrid("reload");
                                        $('#exhibitors').datagrid('clearSelections');
                                    	checkedItems = [];
                                        $.messager.show({
                                            title: '成功',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                		}else{
                			$.messager.alert('提示', '请至少选择一项展商再修改');
                		}
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyExhibitorsTagForm").reset();
                    	$("#modifyExhibitorsTagDlg").dialog("close");
                    }
                }
            ]
        });
     	// 批量修改展团弹出框
        $('#modifyExhibitorsGroupDlg').dialog({
            title: '批量修改展团',
            width: 360,
            height: 150,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	if(checkedItems.length > 0){
                    		var group = document.getElementById("modifyGroup").value;
                    		$.ajax({
                                url: "${base}/user/modifyExhibitorsGroup",
                                type: "post",
                                dataType: "json",
                                data: {"eids": checkedItems, "group": group},
                                traditional: true,
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                    	$("#exhibitors").datagrid("reload");
                                        $('#exhibitors').datagrid('clearSelections');
                                    	$("#modifyExhibitorsGroupDlg").dialog("close");
                                    	checkedItems = [];
                                        $.messager.show({
                                            title: '成功',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                		}else{
                			$.messager.alert('提示', '请至少选择一项展商再修改');
                		}
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyExhibitorsGroupForm").reset();
                    	$("#modifyExhibitorsGroupDlg").dialog("close");
                    }
                }
            ]
        });
		// 批量修改展区弹出框
        $('#modifyExhibitorsAreaDlg').dialog({
            title: '批量修改展区',
            width: 360,
            height: 150,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	if(checkedItems.length > 0){
                    		var area = document.getElementById("modifyArea").value;
                    		$.ajax({
                                url: "${base}/user/modifyExhibitorsArea",
                                type: "post",
                                dataType: "json",
                                data: {"eids": checkedItems, "area": area},
                                traditional: true,
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                    	$("#modifyExhibitorsAreaDlg").dialog("close");
                                    	$("#exhibitors").datagrid("reload");
                                        $('#exhibitors').datagrid('clearSelections');
                                    	checkedItems = [];
                                        $.messager.show({
                                            title: '成功',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                		}else{
                			$.messager.alert('提示', '请至少选择一项展商再修改');
                		}
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyExhibitorsAreaForm").reset();
                    	$("#modifyExhibitorsAreaDlg").dialog("close");
                    }
                }
            ]
        });
		// 导入展商账号弹出框
        $('#importExhibitorsDlg').dialog({
            title: '导入展商账号',
            width: 350,
            height: 340,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认添加',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	var file = document.getElementById("file").value;
                    	if(file == null || file == ""){
                    		$.messager.alert('提示', '请选择所要上传的文件！');
                    	} else {
	                    	var index = file.lastIndexOf(".");
	                    	if(index < 0) {
	                    		$.messager.alert('提示', '上传的文件格式不正确，请选择97-2003Excel文件(*.xls)！');
	                    	} else {
		                    	var ext = file.substring(index + 1, file.length);
		                    	if(ext != "xls") {
		                    		$.messager.alert('提示', '上传的文件格式不正确，请选择97-2003Excel文件(*.xls)！');
		                    	} else {
		                    		$.ajaxFileUpload({
										url:'upload/exhibitors',
										dataType: 'text/html',
										data:$("#importExhibitorsForm").serializeJson(),
										fileElementId:'file',
										success: function (data){
											$("#importExhibitorsDlg").dialog("close");
											filter();
											var report = data;
											report = report.replace(new RegExp('","', 'g'), '<br/>');
											report = report.substring(2, report.length-2);
											$.messager.alert('成功', report);
											$.messager.show({
                                                title: '成功',
                                                msg: '导入展商账号成功',
                                                timeout: 5000,
                                                showType: 'slide'
                                            });
										},
										error: function (data){
											$.messager.alert('错误', data);
	                    		        }
		                    		});
		                    	}
	                    	}
	                    }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	$("#importExhibitorsDlg").dialog("close");
                    }
                }
            ]
        });

		// 展位确认涵和布展委托涵弹出框
		$('#downloadExhibitorInvitationDlg').dialog({
			title: '下载展位确认涵和布展委托涵',
			width: 222,
			height: 200,
			closed: true,
			cache: false,
			modal: true,
			buttons: [
				{
					text: '取消',
					handler: function () {
						$("#downloadExhibitorInvitationDlg").dialog("close");
					}
				}
			]
		});

		//下载展位确认涵
		$('#downloadBoothConfirmation').click(function(){
			eidParm8.innerHTML = "";
			if(checkedItems.length > 0){
				$.messager.confirm('确认下载','你确定要下载展位确认涵吗?',function(r){
					if(r){
						for (var i = 0; i < checkedItems.length; i++) {
							var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
							eidParm8.innerHTML += node;
						}
						document.getElementById("exportExhibitorBoothConfirmToZip").submit();
						$.messager.alert('提示', '所选展商展位确认涵下载成功');
						$("#downloadExhibitorInvitationDlg").dialog("close");
					}
				});
			}else{
				$.messager.alert('提示', '请至少选择一项展商');
			}
		});
    });
</script>