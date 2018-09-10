<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/imports.jsp" %>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <%@ include file="/WEB-INF/views/common/headWithAuto.jsp" %>
    </head>
    <style>
        .addSection-template{display: none; border: 1px solid #0e90d2;margin-top: 10px;border-radius: 10px;width: 70%;}
        label.BMapLabel{max-width:none;}
        .BMap_cpyCtrl, .anchorBL{display: none;}
    </style>
    <body>
        <div class="single-layout">
            <form method="post">
                <div class="single-title-wrapper">
                    <span class="single-title">
                        <i class="fa fa-plus-square-o fa-lg mr5"></i>增加(带<i class="need"></i>为需要填写的项)
                    </span>
                </div>
                <ul class="single-info">
                    <li class="single-info-item">
                        <label class="single-info-item-name" style="width: 143px;">STEP1：基础信息填写</label>
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="nodename"><i class="need"></i>节点名称：</label>
                        <d:validate name="nodename" css="common-input common-input-long" validateObject="${TFocmpNode}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="nodetypeid"><i class="need"></i>节点类型：</label>
                        <d:validate name="nodetypeid" css="common-input common-input-long" validateObject="${TFocmpNode}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="areaid">所在区域：</label>
                        <d:validate name="areaid" css="common-input common-input-long" validateObject="${TFocmpNode}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="remarks">备注：</label>
                        <d:validate name="remarks" css="common-input common-input-long" validateObject="${TFocmpNode}" />
                    </li>
                    <li class="single-info-item" style="border-top: 1px solid #00DDDE;">
                        <label class="single-info-item-name" style="width: 171px;">STEP2：选择经过的光缆段</label>
                    </li>
                    <li class="single-info-item" id="addSection-container">
                        <label class="single-info-item-name">设施经过的光缆段：</label>
                        光缆：
                        <select id="addSection-cable" class="common-input">
                            <option value="">--请选择--</option>
                        </select>
                        光缆段：
                        <select id="addSection-section" class="common-input">
                            <option value="">--请选择--</option>
                        </select>
                        <button id="addSection-btn" type="button" class="common-button common-button-green ml10">
                            <i class="fa fa-chevron-left mr5"></i>增加
                        </button>
                    </li>

                    <li class="single-info-item" style="border-top: 1px solid #00DDDE;">
                        <label class="single-info-item-name" style="width: 171px;">STEP3：双击地图选择位置</label>
                    </li>
                    <li class="single-info-item" style="display: inline-flex;">
                        <label class="single-info-item-name">位置选择：</label>
                        <div id="map" style="width:700px;height: 600px;">

                        </div>
                    </li>

                    <li class="single-info-item">
                        <label class="single-info-item-name"></label>
                        <button type="submit" id="addBtn" class="common-button">
                            <i class="fa fa-save mr5"></i>提交
                        </button>
                        <button type="button" id="backBtn" class="common-button common-button-green ml10">
                            <i class="fa fa-chevron-left mr5"></i>返回
                        </button>
                    </li>
                </ul>
            </form>
        </div>
        <div id="addSection-template" class="addSection-template">
            <button style="float: right;margin: 10px;" remark="del-btn" type="button" class="common-button common-button-red ml10">
                取消选择
            </button>
            <li class="single-info-item">
                <label class="single-info-item-name" style="width:550px;text-align: left;padding-left: 70px;" name="cableSectionName"></label>
            </li>
            <li class="single-info-item">
                <label class="single-info-item-name"><i class="need"></i>前一设施：</label>
                <select remark="nodeA" class="common-input common-input-long">
                    <option value="">-- 该光缆段上暂时没有设施(无需选择前后设施) --</option>
                </select>
            </li>
            <li class="single-info-item">
                <label class="single-info-item-name"><i class="need"></i>后一设施：</label>
                <select remark="nodeZ" class="common-input common-input-long">
                    <option value="">--添加光缆段端点（无需选择后一设施）--</option>
                </select>
            </li>
            <li class="single-info-item">
                <label class="single-info-item-name"><i class="need"></i>距前一设施皮长：</label>
                <input type="text" class="common-input common-input-long"/>
            </li>
            <li class="single-info-item">
                <label class="single-info-item-name"><i class="need"></i>距后一设施皮长：</label>
                <input type="text" class="common-input common-input-long"/>
            </li>
        </div>
        <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=OmG5K7LIT4ceCCiqIZ4AG7XZ"></script>
        <script>
            var webPath = "/" + window.location.pathname.split("/")[1];
            $(function () {
                findAndInitCableSelect();
                initMap();
            })

            var allCable = null, allSection = {}
            function findAndInitCableSelect(){
                let cableName = $("#cableName").val();
                let url = webPath + "/focmp/cable/findCableList?optcablename=";
                $.ajax({
                    url: url,
                    method: "GET",
                    success: function (data) {
                        data = eval(data);
                        allCable = eval(data[0]);
                        initCableSelect(allCable);

                        let sectionData = eval(data[1]);
                        for(let i = 0; i < sectionData.length; i++) {
                            let section = sectionData[i];
                            let cableSections = allSection["c" + section.optcableid];
                            if(cableSections == null || cableSections == undefined){
                                cableSections = [];
                                allSection["c" + section.optcableid] = cableSections;
                            }
                            cableSections.push(section);
                        }
                    }
                });
            }
            function initCableSelect(cableData) {
                let html = "";
                for(let i = 0; i < cableData.length; i++){
                    let cable = cableData[i];
                    html += '<option value="' + cable.optcableid + '"> ' + cable.optcablename + ' </option>';
                }
                $("#addSection-cable").append(html);
            }

            $("#addSection-cable").change(function () {
                let cableId = $(this).val();
                $("#addSection-section").empty();
                if(cableId == "" || allSection["c" + cableId] == null || allSection["c" + cableId] == undefined)
                    return;

                let sections = allSection["c" + cableId];
                let html = "";
                for(let i = 0; i < sections.length; i++){
                    let section = sections[i];
                    html += '<option value="' + section.optsegid + '"> ' + section.optsegname + ' </option>';
                }
                $("#addSection-section").append(html);
            });

            var addedSection = [];
            $("#addSection-btn").click(function () {
                let sectionId = $("#addSection-section").val();
                if(sectionId == '' || sectionId == undefined || sectionId == null){
                    alert("请选择设施所在的光缆、光缆段！");
                    return;
                }
                if(addedSection.indexOf(sectionId) >=0) return;
                addedSection.push(sectionId);

                let _addSectionContainer = $("#addSection-template").clone().insertBefore("#addSection-container");
                _addSectionContainer.attr("id", sectionId);
                _addSectionContainer.show();
                _addSectionContainer.find("button[remark='del-btn']").click(function () {
                    for(let i = 0; i < addedSection.length; i++){
                        if(sectionId == addedSection[i]){
                            addedSection.splice(i, 1);
                            break;
                        }
                    }
                    delFromCableSectionList(sectionId);
                    _addSectionContainer.remove();
                });


                let sections = allSection["c" + $("#addSection-cable").val()];
                for(let i = 0; i < sections.length; i++){
                    if(sections[i].optsegid == sectionId){
                        initSectionNodeInfos(_addSectionContainer, sections[i]);
                        break;
                    }
                }
            });

            function initSectionNodeInfos(_addSectionContainer, section) {
                _addSectionContainer.find("label[name='cableSectionName']").text(section.optsegname);
                getSectionData(initSectionSelects, section.optsegid, _addSectionContainer);
            }

            var cableSectionList = [];
            function addToCableSectionList(data) {
                cableSectionList.push(data);
                drawSections(cableSectionList);
            }
            function delFromCableSectionList(sectionId) {
                for(let i = 0; i < cableSectionList.length; i++){
                    if(cableSectionList[i].sectionId == sectionId){
                        cableSectionList.splice(i, 1);
                        break;
                    }
                }
                drawSections(cableSectionList);
            }

            function initSectionSelects(data, _addSectionContainer) {
                data = eval(data);
                if(data.length <= 0)
                    return;
                let nodes = data[0].nodes, html = "";
                if(nodes == null || nodes == undefined || nodes.length <= 0)
                    return;
                addToCableSectionList(data[0]);
                for(let i = 0; i < nodes.length; i++){
                    let node = nodes[i];
                    html += '<option value="' + node.nodeId + '">' + node.nodeName + '</option>'
                    if(i == 1){
                        _addSectionContainer.find("select[remark='nodeZ']").append('<option value="' + node.nodeId + '">' + node.nodeName + '</option>');
                    }
                }
                _addSectionContainer.find("select[remark='nodeA']").empty();
                _addSectionContainer.find("select[remark='nodeA']").append(html);
                _addSectionContainer.find("select[remark='nodeA']").change(function () {
                    let options = $(this).children();
                    for(let i = 0; i < options.length; i++){
                        let _option = $(options[i]);
                        if(_option.val() == $(this).val()){
                            _addSectionContainer.find("select[remark='nodeZ']").empty();
                            if(i == 0 || i == options.length - 1)
                                _addSectionContainer.find("select[remark='nodeZ']").append('<option value="">--添加光缆段端点（无需选择后一设施）--</option>')
                            if(i > 0)
                                _addSectionContainer.find("select[remark='nodeZ']").append($(options[i - 1]).context.outerHTML);
                            if(i < options.length - 1)
                                _addSectionContainer.find("select[remark='nodeZ']").append($(options[i + 1]).context.outerHTML);
                        }
                    }

                });
            }
            function getSectionData(callBack, sectionId, _addSectionContainer) {
                $.ajax({
                    url: webPath + '/focmp/map/getSectionByParam?optsegid=' + sectionId,
                    method: 'GET',
                    success: function (data) {
                        callBack(data, _addSectionContainer);
                    }
                });
            }

            var map = null ;
            var positionMarker = null;
            function initMap(){
                if(map == null)
                    map = new BMap.Map("map", {enableMapClick: false});
                map.disableDoubleClickZoom()
                map.centerAndZoom(new BMap.Point(114.341823, 22.713299), 15);
                map.enableScrollWheelZoom();
                map.addEventListener("dblclick", function (e) {
                    let point = new BMap.Point(e.point.lng, e.point.lat);
                    drawPosition(point);
                });
                map.addEventListener("moveend", function (e) {
                    displayMarkers(map.getZoom());
                });
                map.addEventListener("zoomend", function (e) {
                    displayMarkers(map.getZoom());
                });
            }

            var position = null;
            function drawPosition(point){
                if(!position){
                    position = new BMap.Marker(point);
                    position.disableMassClear();
                    var label = new BMap.Label("当前设施的位置",{offset:new BMap.Size(20,-10)});
                    position.setLabel(label);

                    map.addOverlay(position);
                }else
                    position.setPosition(point);
                for(let i = 0; i < cableSectionList.length; i++){
                    let sectionId = cableSectionList[i].sectionId;
                    let _div = $("#" + sectionId);
                    let nodeA = _div.find("select[remark='nodeA']").val();
                    let nodeZ = _div.find("select[remark='nodeZ']").val();
                    let path = polylineMap[sectionId].extDataPath;
                    polylineMap[sectionId].setPath(path);

                    path = polylineMap[sectionId].getPath();
                    let index = getIndexFromNodes(cableSectionList[i].nodes, nodeA, nodeZ);
                    if(nodeZ != '')
                        index++;
                    else if(index == cableSectionList[i].nodes.length - 1)
                        index++;
                    path.splice(index, 0, point);
                    polylineMap[sectionId].setPath(path);
                }
            }

            function getIndexFromNodes(nodes, nodeId, nodeId2){
                for(var i = 0; i < nodes.length; i++){
                    if(nodes[i].nodeId == nodeId || nodes[i].nodeId == nodeId2)
                        return i;
                }
                return 0;
            }

            var polylineMap = {};
            function drawSections(datas) {
                map.clearOverlays();
                var viewPath = [];
                for(let i = 0; i < datas.length; i++) {
                    let cableSection = datas[i];
                    let path = getPathByNodes(cableSection.nodes);
                    viewPath = viewPath.concat(path);
                    let polyline = new BMap.Polyline(path, {strokeColor: "blue", strokeWeight: 6, strokeOpacity: .5});
                    polyline.extData = cableSection;
                    let infoWindow =  new BMap.InfoWindow('',{title: cableSection.cableName + "-" + cableSection.sectionName});
                    polyline.addEventListener("click", function (e) {
                        map.openInfoWindow(infoWindow, new BMap.Point(e.point.lng, e.point.lat));
                    });
                    map.addOverlay(polyline);
                    polyline.extDataPath = path;
                    polylineMap[cableSection.sectionId] = polyline;
                }
                map.setViewport(viewPath);
            }

            function getPathByNodes(nodes){
                var path = []
                for(var i = 0; i < nodes.length; i++){
                    var node = nodes[i];
                    path.push(new BMap.Point(node.nodex, node.nodey));
                }
                return path;
            }

            var showMarkers = [];
            function displayMarkers(zoom) {
                for(let i = 0; i < showMarkers.length; i++)
                    map.removeOverlay(showMarkers[i]);
                showMarkers = [];
                if (zoom < 18) return;

                let bounds = map.getBounds();
                let sw = bounds.getSouthWest(), ne = bounds.getNorthEast();
                for(let i = 0; i < cableSectionList.length; i++){
                    let nodes = cableSectionList[i].nodes;
                    for(let j = 0; j < nodes.length; j++){
                        let node = nodes[j];
                        if(!isNodeInBounds(sw, ne, node.nodex, node.nodey))
                            continue;
                        let marker = new BMap.Marker(new BMap.Point(node.nodex, node.nodey));
                        let label = new BMap.Label(node.nodeName,{offset:new BMap.Size(20,-10)});
                        marker.setLabel(label);
                        map.addOverlay(marker);
                        showMarkers.push(marker);
                    }
                }
            }
            
            function isNodeInBounds(sw, ne, x, y) {
                let minX = sw.lng, maxX = ne.lng;
                let minY = sw.lat, maxY = ne.lat;
                return x > minX && x < maxX && y > minY && y < maxY;
            }
        </script>
    </body>
</html>