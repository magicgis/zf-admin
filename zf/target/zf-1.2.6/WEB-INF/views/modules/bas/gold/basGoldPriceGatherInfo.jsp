<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>实时金价管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="basGoldPriceGather" action="${ctx}/bas/gold/basGoldPriceGather/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>实时金价信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>显示名称</strong>
                            <p class="text-primary">
                                ${basGoldPriceGather.name}
                            </p>
                            <hr class="zf-hr">
                            <strong>采集类型（999金价/等）</strong>
                            <p class="text-primary">
                                ${basGoldPriceGather.priceType}
                            </p>
                            <hr class="zf-hr">
                            <strong>价格</strong>
                            <p class="text-primary">
                                ${basGoldPriceGather.price}
                            </p>
                            <hr class="zf-hr">
                            <strong>获取时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${basGoldPriceGather.gatherTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${basGoldPriceGather.remarks}
                            </p>
                            <hr class="zf-hr">
                        </div>
                        
                        <div class="box-footer">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                                <i class="fa fa-mail-reply"></i>返回
                            </button>
                        </div>
                    </div>
               </div>
            </div>
         </section>
    </form:form>
</div>
</body>
</html>