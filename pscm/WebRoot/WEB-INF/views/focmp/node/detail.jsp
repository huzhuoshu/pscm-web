<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/imports.jsp" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
        label.BMapLabel {
            max-width: none;
        }

        .BMap_cpyCtrl, .anchorBL {
            display: none;
        }
    </style>
</head>
<body>
<div class="single-layout">
    <div class="single-title-wrapper">
                <span class="single-title">
                    <i class="fa fa-file-o fa-lg mr5"></i>详情
                </span>
    </div>
    <ul class="single-info">
        <input type="hidden" id="info_nodeName" value="${d:fs(tFocmpNode.nodename)}"/>
        <input type="hidden" id="info_x" value="${tFocmpNode.nodex}"/>
        <input type="hidden" id="info_y" value="${tFocmpNode.nodey}"/>
        <input type="hidden" id="info_id" value="${tFocmpNode.nodeid}"/>
        <li class="single-info-item">
            <label class="single-info-item-name" for="nodeid">信息点编号：</label>
            <span>${d:fs(tFocmpNode.nodeid)}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="nodename">节点名称：</label>
            <span>${d:fs(tFocmpNode.nodename)}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="nodetypeid">节点类型：</label>
            <span>${d:fs(tFocmpNode.nodetypeid)}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="areaid">所在区域：</label>
            <span>${d:fs(tFocmpNode.areaid)}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="nodegpsx">gps经度：</label>
            <span>${tFocmpNode.nodegpsx}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="nodegpsy">gps纬度：</label>
            <span>${tFocmpNode.nodegpsy}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="nodex">百度经度：</label>
            <span>${tFocmpNode.nodex}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="nodey">百度纬度：</label>
            <span>${tFocmpNode.nodey}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="remarks">备注：</label>
            <span>${d:fs(tFocmpNode.remarks)}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="operUser">最后操作用用户ID：</label>
            <span>${d:fs(tFocmpNode.operUser)}</span>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name" for="operDate">最后操作日期：</label>
            <span>${d:defaultDate(tFocmpNode.operDate)}</span>
        </li>

        <li class="single-info-item" id="map-li" style="display: inline-flex;">
            <label class="single-info-item-name">设施位置：</label>
            <div id="container" style="width:700px;height: 600px;"></div>
        </li>
        <li class="single-info-item">
            <label class="single-info-item-name"></label>
            <button type="button" id="backBtn" class="common-button common-button-green">
                <i class="fa fa-chevron-left mr5"></i>返回
            </button>
        </li>
    </ul>
</div>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=OmG5K7LIT4ceCCiqIZ4AG7XZ"></script>
<script src="${_jsPath}/bdMap-board/bMapUtils.js"></script>
<script src="${_jsPath}/bdMap-board/getData.js"></script>
<script>
    require(['common'], function (common) {
        // 初始化页面
        common.initDetail();
        initMap();
        createMarkerAndPanTO();
        getSectionData(showSections, "nodeId=" + $("#info_id").val());
    });

    function createMarkerAndPanTO() {
        let nodeName = $("#info_nodeName").val(), nodeX = $("#info_x").val(), nodeY = $("#info_y").val();
        let point = new BMap.Point(nodeX, nodeY);
        let position = BD_getMarker(point, nodeName);
        map.addOverlay(position);
        map.panTo(point);
    }

    function showSections(data) {
        data = eval(data);
        let html = "";
        for(let i = 0; i < data.length; i++){
            html += '<li class="single-info-item">';
            html +=      '<label class="single-info-item-name">经过的光缆段：</label>';
            html +=      '<span>' + data[i].cableName + ' —— ' + data[i].sectionName + '</span>';
            html += '</li>';
        }

        if(html == ''){
            html += '<li class="single-info-item">';
            html +=      '<label class="single-info-item-name">经过的光缆段：</label>';
            html +=      '<span>未经过光缆段</span>';
            html += '</li>';
        }
        $("#map-li").before(html);
    }
</script>
</body>
</html>