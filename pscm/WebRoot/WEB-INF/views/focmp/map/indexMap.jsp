<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>地图首页</title>
    <link rel="stylesheet" href="${_pluginPath}/bootstrap/css/bootstrap.min-3.3.7.css"/>
    <link rel="stylesheet" href="${_cssPath}/map/mapIndex-leftBar.css"/>
    <style type="text/css">
        .result-box {width: 100%;padding: 7px;cursor: pointer;border-top: 1px solid #EEEEEE;}
        .cable-img {display: inline-block; font-size: 20px;color: #0091ff;width: 12%;padding-top: 3px;}
        .cable-info {display: inline-block}
        .badge {background-color: #0091ff;color: white}
        .result-box:hover{background-color: #CCCCCC;border: 1px solid #0091ff;}

        #cablecontent>div {display: inline-block;padding: 4px;}
        .existedhazard {padding: 5px;background-color: #eeeeee;font-weight: bold;border-bottom: 1px solid #CCCCCC;}
        .linelist .sectioncontent {width: 100%;padding: 4px;cursor: pointer;}
        .linelist .sectioncontent>div {display: inline-block;padding: 4px;vertical-align: middle;}
        .linelist .sectioncontent:hover{background-color: #CCCCCC;border: 1px solid #0091ff;}
        .back{color:#3A3A3A;cursor: pointer;}
        .back:hover{color: #0091ff;}
    </style>
    <script src="${_jsPath}/jquery.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=OmG5K7LIT4ceCCiqIZ4AG7XZ"></script>

</head>
<body>
<input type="hidden" id="sectionId" value="${sectionId}"/>
<input type="hidden" id="cableId" value="${cableId}"/>
<%------------------模版--------------------%>
<%--左侧光缆段选择列表--%>
<div class="result-box" title="点击查看" id="template_cableItem" style="display: none;">
    <div class="cable-img"><span class="badge" name="index"></span></div>
    <div class="cable-info"><div name="name"></div></div>
</div>
<%--左侧光缆详情里面 光缆段列表--%>
<div class="sectioncontent" title="点击查看" id="template_sectionItem" style="display: none;">
    <div class="sectionname col-width-10" name="sectionName"></div>
    <div class="col-width-2">敷设：</div><div class="erectiontype col-width-3" name="method"></div>
    <div class="col-width-2">长度：</div><div class="length col-width-3" name="length"></div>
</div>
<!-- 地图容器 -->
<div id="container"></div>
<div id="leftbar" class="leftbar">
    <%--光缆列表--%>
    <div name="mainInfoDiv" id="sectionInfoListDiv" class="info-box" style="">
        <div class="info-header">
            <span class="glyphicon glyphicon-stats" style="color: #0091ff;"></span>
            <span>光缆查询</span>
        </div>
        <div class="info-content">
            <div class="input-group">
                <input type="text" id="sectionInfoListDiv_cableName" class="form-control" placeholder="输入光缆名称">
                <span class="input-group-btn">
			      	<button class="btn btn-info" type="button" id="searchCableBtn" style="font-size: 20px;"><i class="glyphicon glyphicon-search"></i></button>
                </span>
            </div>
            <div class="tab-content" style="padding-top: 16px;">
                <div role="tabpanel" class="tab-pane active body-tab">
                    <div id="sectionList_contentScroll" class="content-scroll"></div>
                </div>
            </div>
        </div>
    </div>
    <%--光缆信息--%>
    <div name="mainInfoDiv" id="cableInfoDiv" class="info-box" style="display: none;">
        <div class="info-header">
            <span class="glyphicon glyphicon-stats" style="color: #0091ff;"></span>
            <span>光缆信息</span>
            <div class="back pull-right" onclick="leftBar_showQueryInfo();">
                <span>返回查询</span>
            </div>
        </div>
        <div class="info-content">
            <div id="cablecontent">
                <div class="col-width-3">光缆名称：</div><div id="cableInfoDiv_cableName" class="col-width-7">广州海口架空光缆</div>
                <div class="col-width-3">光缆等级：</div><div id="cableInfoDiv_level" class="col-width-7">一干</div>
            </div>
            <div class="existedhazard">光缆段</div>
            <div class="scrollbox">
                <div class="contentbox">
                    <div class="linelist" id="cableInfoDiv_sectionList">

                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--光缆段信息--%>
    <div name="mainInfoDiv" id="sectionInfoDiv" class="info-box" style="display: none;">
        <div class="info-header">
            <span class="glyphicon glyphicon-stats" style="color: #0091ff;"></span>
            <span>光缆段信息</span>
            <div class="back pull-right" onclick="leftBar_showQueryInfo();">
                <span>返回查询</span>
            </div>
        </div>
        <div class="info-content">
            <div id="sectioncontent">
                <div class="col-width-3">光缆：</div>
                <div id="left-bar-cableName" class="col-width-7 font-size15"></div>
                <div class="col-width-3">光缆段：</div>
                <div id="left-bar-sectionName" class="col-width-7 font-size15"></div>
                <div class="col-width-3">光缆段编码：</div>
                <div id="left-bar-code" class="col-width-7 font-size15"></div>
                <div class="col-width-3">纤芯数量：</div>
                <div id="left-bar-filberNum" class="col-width-7 font-size15"></div>
                <div class="col-width-3">长度：</div>
                <div id="left-bar-length" class="col-width-7 font-size15"></div>
            </div>
        </div>
    </div>
    <div id="leftbar-trigger" class="leftbar-trigger">
        <span class="glyphicon glyphicon-menu-right" id="leftbar-trigger-icon"></span>
    </div>
</div>
</body>
<script src="${_jsPath}/bdMap-board/getData.js"></script>
<script src="${_jsPath}/bdMap-board/leftBar.js"></script>
<script src="${_jsPath}/bdMap-board/bMapUtils.js"></script>
<!-- 自定义的js -->
<script type="text/javascript">
    $(function () {
        initMap();
        let path1 = [new BMap.Point(114.327306, 22.713216), new BMap.Point(114.330504, 22.714182), new BMap.Point(114.333666, 22.715016), new BMap.Point(114.337008, 22.715983), new BMap.Point(114.339092, 22.716549), new BMap.Point(114.340709, 22.716916), new BMap.Point(114.342039, 22.716816), new BMap.Point(114.343584, 22.716349), new BMap.Point(114.345596, 22.715516), new BMap.Point(114.347321, 22.715149), new BMap.Point(114.348542, 22.715149), new BMap.Point(114.349836, 22.715449), new BMap.Point(114.351237, 22.715949), new BMap.Point(114.352675, 22.716583), new BMap.Point(114.353788, 22.717316), new BMap.Point(114.356699, 22.71925), new BMap.Point(114.358891, 22.72085), new BMap.Point(114.361406, 22.72275), new BMap.Point(114.363131, 22.724083), new BMap.Point(114.364352, 22.72515), new BMap.Point(114.365466, 22.725817), new BMap.Point(114.36967, 22.729084), new BMap.Point(114.373587, 22.731717), new BMap.Point(114.376102, 22.73255), new BMap.Point(114.378474, 22.733217), new BMap.Point(114.379588, 22.730584), new BMap.Point(114.380953, 22.727917), new BMap.Point(114.382929, 22.725183), new BMap.Point(114.385014, 22.72205), new BMap.Point(114.386666, 22.720583), new BMap.Point(114.388247, 22.720916), new BMap.Point(114.389685, 22.721183)];
        let path2 = [new BMap.Point(114.303555, 22.67027), new BMap.Point(114.310167, 22.674605), new BMap.Point(114.318719, 22.677473), new BMap.Point(114.327414, 22.680941), new BMap.Point(114.340134, 22.686076), new BMap.Point(114.343871, 22.68881), new BMap.Point(114.348542, 22.694612), new BMap.Point(114.357238, 22.711015), new BMap.Point(114.359609, 22.719216), new BMap.Point(114.361047, 22.72135), new BMap.Point(114.361837, 22.72235), new BMap.Point(114.362915, 22.729617), new BMap.Point(114.363993, 22.7324), new BMap.Point(114.365071, 22.738533), new BMap.Point(114.365215, 22.740333), new BMap.Point(114.367299, 22.744166), new BMap.Point(114.369742, 22.746266), new BMap.Point(114.372473, 22.748599), new BMap.Point(114.375456, 22.750732), new BMap.Point(114.379767, 22.752299), new BMap.Point(114.382247, 22.753832), new BMap.Point(114.383433, 22.755798), new BMap.Point(114.38566, 22.756898), new BMap.Point(114.388391, 22.757298)];
        let s1 = {cableName: "坪山机楼-大工业区/ZGG01", sectionName: "坪山机楼-大工业区/ZGG01/01", code: "L05.PSH00-DAGYQ/ZGG01/01", filberNum: "24", length: "1143米"};
        let s2 = {cableName: "坪山-葵涌ZJG01", sectionName: "坪山-葵涌ZJG01/01", code: "L05.PSH00-L06.KYO00/ZJG01/01", filberNum: "24", length: "8296米"};

        drawSection(path1, s1);
        drawSection(path2, s2);
        getSectionData(queryDrawSections);
    });

    function drawSection(path, data) {
        console.log("this is my test@@@")
        let polyline = BD_getPolyline(path, 'blue', 6, .5);
        polyline.extData = data;
        let infoWindow = getSectionWindowInfo(data);
        polyline.addEventListener("click", function (e) {
            map.openInfoWindow(infoWindow, new BMap.Point(e.point.lng, e.point.lat));
            changeLeftBarInfo(e.target.extData)
            openLeftBar();
        });
        if(data.sectionId)
            dataContainer.drawPolyLineMap[data.sectionId] = polyline;
        map.addOverlay(polyline);
    }

    function getSectionWindowInfo(data) {
        let infoWindowOpt = {width: 300, height: 200, title: "光缆信息"};
        let olpHtml = '<div>';
        olpHtml +=      '<div style="padding-top: 5px;">光缆：<span style="font-size: 18px">' + data.cableName + '</span></div>';
        olpHtml +=      '<div style="padding-top: 5px;">光缆段：<span style="font-size: 18px">' + data.sectionName + '</span></div>';
        olpHtml +=      '<div style="padding-top: 5px;">光缆段编码：<span style="font-size: 18px">' + data.code + '</span></div>';
        olpHtml +=      '<div style="padding-top: 5px;">纤芯数量：<span style="font-size: 18px">' + data.filberNum + '</span></div>';
        olpHtml +=      '<div style="padding-top: 5px;">皮长：<span style="font-size: 18px">' + data.length + '</span></div>';
        olpHtml +=    '</div>';
        return new BMap.InfoWindow(olpHtml, infoWindowOpt);
    }


    function queryDrawSections(data){
        data = eval(data);
        dataContainer.sectionList = data;
        leftBar_showCableSectionList(data);
        for(let i = 0; i < data.length; i++){
            let cableSection = data[i];
            let path = getPathByNodes(cableSection.nodes);
            drawSection(path, {
                cableId : cableSection.cableId,
                sectionId: cableSection.sectionId,
                cableName: cableSection.cableName,
                sectionName: cableSection.sectionName,
                code: "L05.PSH00-DAGYQ/ZGG01/01",
                filberNum: "24",
                length: "1143米"
            })
        }
    }

    function getPathByNodes(nodes){
        let path = []
        for(let i = 0; i < nodes.length; i++){
            let node = nodes[i];
            path.push(new BMap.Point(node.nodex, node.nodey));
        }
        return path;
    }


</script>
</html>