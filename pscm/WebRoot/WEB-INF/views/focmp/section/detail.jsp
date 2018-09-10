<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/imports.jsp" %>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <%@ include file="/WEB-INF/views/common/head.jsp" %>
    </head>
    <body>
        <div class="single-layout">
            <div class="single-title-wrapper">
                <span class="single-title">
                    <i class="fa fa-file-o fa-lg mr5"></i>光缆段详情
                </span>
            </div>
            <ul class="single-info">
                <li class="single-info-item">
                    <label class="single-info-item-name" for="optcableid">光缆编码：</label>
                    <span><d:trans sourceKey="optcableid,optcablecode" value="${d:fs(tFocmpSection.optcableid)}" source="TFocmpCable"/></span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="optsegcode">光缆段编码：</label>
                    <span>${d:fs(tFocmpSection.optsegcode)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="optsegname">光缆段名称：</label>
                    <span>${d:fs(tFocmpSection.optsegname)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="regionname">地区：</label>
                    <span>${d:fs(tFocmpSection.regionname)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="ocfaType">A端交接设施类型：</label>
                    <span>${d:fs(tFocmpSection.ocfaType)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="ocfaId">A端交接设施ID：</label>
                    <span>${d:fs(tFocmpSection.ocfaId)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="ocfbType">B端交接设施类型：</label>
                    <span>${d:fs(tFocmpSection.ocfbType)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="ocfbId">B端交接设施ID：</label>
                    <span>${d:fs(tFocmpSection.ocfbId)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="fibernum">纤芯数：</label>
                    <span>${tFocmpSection.fibernum}</span>
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="optseglen">皮长（米）：</label>
                    <span>${tFocmpSection.optseglen}</span>
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="installation">敷设方式：</label>
                    <span>${d:fs(tFocmpSection.installation)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="maintainunit">维护部门：</label>
                    <span>${d:fs(tFocmpSection.maintainunit)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="usedept">使用部门：</label>
                    <span>${d:fs(tFocmpSection.usedept)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="operUser">操作帐号：</label>
                    <span>${d:fs(tFocmpSection.operUser)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="operDate">操作时间：</label>
                    <span>${d:defaultDate(tFocmpSection.operDate)}</span>
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="memo">备注：</label>
                    <span>${d:fs(tFocmpSection.memo)}</span>  
                </li>         
                <li class="single-info-item">
                    <label class="single-info-item-name" for="areaId">区域编码：</label>
                    <span>${d:fs(tFocmpSection.areaId)}</span>  
                </li>         

                <li class="single-info-item">
                    <label class="single-info-item-name"></label>
                    <button type="button" id="backBtn" class="common-button common-button-green">
                        <i class="fa fa-chevron-left mr5"></i>返回
                    </button>
                </li>
            </ul>
        </div>
        
        <script>
            require([ 'common' ], function(common) {
                // 初始化页面
                common.initDetail();
            });
        </script>
    </body>
</html>