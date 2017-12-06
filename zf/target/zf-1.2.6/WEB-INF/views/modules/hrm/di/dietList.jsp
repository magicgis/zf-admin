<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>日常菜谱管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/hrm/di/diet/">菜谱列表</a></small>
            <shiro:hasPermission name="hrm:di:diet:edit">
	            <small>|</small>
                <small><i class="fa-form-edit"></i><a href="${ctx}/hrm/di/diet/form">菜谱添加</a></small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>查询条件</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            
            <form:form id="searchForm" modelAttribute="diet" action="${ctx}/hrm/di/diet/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">菜谱日期</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="date" inputName="date" value="${diet.date }" isMandatory="false" tip="请选择所属日期" inputId="date" format="YYYY-MM-DD"></sys:datetime>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                        <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                    </div>
                </div>
            </form:form>
        </div>
    
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th class="zf-dataTables-multiline"></th>
                                <th>菜谱日期</th>
                                <th>评价得分</th>
                                <th style="display:none">创建者</th>
                                <th style="display:none">创建时间</th>
                                <th style="display:none">更新者</th>
                                <th style="display:none">更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="hrm:di:diet:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="diet" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${diet.date}" pattern="yyyy-MM-dd"/>
									</td>
                                    <td>
                                        ${diet.score}
									</td>
									<td data-hide="true">
                                        ${fns:getUserById(diet.createBy.id).name}
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${diet.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td data-hide="true">
										${fns:getUserById(diet.updateBy.id).name}
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${diet.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                        ${diet.remarks}
									</td>
                                    <shiro:hasPermission name="hrm:di:diet:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/hrm/di/diet/form?id=${diet.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li>
                                                	<a href="${ctx}/hrm/di/dish/list?id=${diet.id}" style="color: #fff">菜品管理</a>
                                                </li>
                                                <li>
                                                	<a href="${ctx}/hrm/di/diet/delete?id=${diet.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该日常菜谱吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/hrm/di/diet/info?id=${diet.id}" target="">详情</a></li>
                                            </ul>
                                        </div>
                                    </td></shiro:hasPermission>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box-footer">
                <div class="dataTables_paginate paging_simple_numbers">${page}</div>
            </div>
        </div>
     </section>
    </div>
    
    <script>
      $(function () {
        
        ZF.bigImg();
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
          
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : false,
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        })
      });
      
   </script>
</body>
</html>