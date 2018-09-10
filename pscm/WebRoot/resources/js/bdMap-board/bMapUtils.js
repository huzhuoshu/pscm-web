var map = null;
var webPath = "/" + window.location.pathname.split("/")[1];
const icon_none = new BMap.Icon(webPath + "/resources/img/index/xunjian.png", new BMap.Size(0,0))

var dataContainer = {
    sectionList : null,
    drawPolyLineMap: {},
}

function initMap(){
    map = new BMap.Map("container", {enableMapClick: false});
    map.centerAndZoom(new BMap.Point(114.341823, 22.713299), 15);
    map.enableScrollWheelZoom();
    map.addEventListener("click", function (e) {
        console.log("new BMap.Point(" + e.point.lng + ", " + e.point.lat + "),");
    })
}

function BD_getPolyline(path, color, weight, opacity) {
    return new BMap.Polyline(path, {strokeColor: color, strokeWeight: weight, strokeOpacity: opacity});
}

function BD_getMarker(point, lableTitle) {
    let marker = new BMap.Marker(point);
    marker.setShadow(icon_none);
    if(lableTitle){
        let label = new BMap.Label(lableTitle,{offset:new BMap.Size(20,-10)});
        marker.setLabel(label);
    }
    return marker;
}

function BD_viewport(sectionId){
    if(dataContainer.drawPolyLineMap[sectionId])
        map.setViewport(dataContainer.drawPolyLineMap[sectionId].getPath());
}

//像素转坐标点
function mapPixelToPoint(pixel){
    return map.pixelToPoint(pixel);
}
/**********************  百度地图工具类 ****************************/
function miniRangeFromPolylineClick(pixel) {
    let minx = pixel.x - 5;
    let maxx = pixel.x + 5;
    let miny = pixel.y - 5;
    let maxy = pixel.y + 5;

    let ltPixel = createMapPixel(minx, miny);//左上
    let rtPixel = createMapPixel(maxx, miny);
    let lbPixel = createMapPixel(minx, maxy);
    let rbPixel = createMapPixel(maxx, maxy);

    let ltPoint = mapPixelToPoint(ltPixel);
    let rtPoint = mapPixelToPoint(rtPixel);
    let lbPoint = mapPixelToPoint(lbPixel);
    let rbPoint = mapPixelToPoint(rbPixel);

    let lt = {x: ltPoint.lng, y: ltPoint.lat};
    let rt = {x: rtPoint.lng, y: rtPoint.lat};
    let lb = {x: lbPoint.lng, y: lbPoint.lat};
    let rb = {x: rbPoint.lng, y: rbPoint.lat};

    let polylineids = checkSegmentCrossRectangle(lt, lb, rt, rb);
    return polylineids;
};

//判断线段是否经过矩形
function checkSegmentCrossRectangle(lt,lb,rt,rb,bounds){
    let overlays = map.getOverlays();
    let polylineids = new Array;
    $.each(overlays,function(idx,alay){
        //判断是否为折线
        if(alay instanceof BMap.Polyline){
            let polypoints = alay.getPath();
            let formerPoint = null;
            //增加判断线段是否隐藏了，隐藏了则忽略
            let isvisible = alay.isVisible();
            if(!isvisible) return true;
            $.each(polypoints,function(pidx,aPoint){
                //如果点在矩形内
                let pointInBounds = BMapLib.GeoUtils.isPointInRect(aPoint, bounds);
                if(pointInBounds){
                    var isInArray = checkStringInStringArray(polylineids,alay.extData.optsegid);//index
                    if(!isInArray)
                        polylineids.push(alay.extData.optsegid);
                    return false;
                }
                if(pidx == 0) {formerPoint = aPoint;return true;}
                let segmentPointSt = {x: formerPoint.lng,y: formerPoint.lat};
                let segmentPointEnd = {x: aPoint.lng,y: aPoint.lat};

                let crossLeft = checkCross(segmentPointSt,segmentPointEnd,lt,lb);
                let crossTop = checkCross(segmentPointSt,segmentPointEnd,lt,rt);
                let crossRight = checkCross(segmentPointSt,segmentPointEnd,rt,rb);
                let crossBottom = checkCross(segmentPointSt,segmentPointEnd,lb,rb);
                let isCross = crossLeft || crossTop || crossRight || crossBottom;
                formerPoint = aPoint;

                if (isCross) {
                    let isInArray = checkStringInStringArray(polylineids, alay.extData.optsegid);
                    if (!isInArray)
                        polylineids.push(alay.extData.optsegid);
                    return false;
                }
            });
        }
    });
    return polylineids;
}

function checkStringInStringArray(strArr, str) {
    if (!strArr || strArr.length == 0) return false;
    var result = false;
    $.each(strArr, function (idx, aStr) {
        if (str == aStr) {
            result = true;
            return false;
        }
    });
    return result;
};
//检查线段相交：判断线段两端是否在另一条线段两侧
//同侧，叉积结果的垂直方向相同，异侧，相反
//true:相交；false:不相交
function checkCross(p1, p2, p3, p4) {
    //计算向量叉积
    function crossMul(v1, v2) {
        return v1.x * v2.y - v1.y * v2.x;
    };

    let v1 = {x: p1.x - p3.x, y: p1.y - p3.y},//向量P3P1: P1-P3
        v2 = {x: p2.x - p3.x, y: p2.y - p3.y},//向量P3P2: P2-P3
        v3 = {x: p4.x - p3.x, y: p4.y - p3.y};//向量P3P4: P4-P3
    let cross1 = crossMul(v1, v3) * crossMul(v2, v3);
    //线段互换
    v1 = {x: p3.x - p1.x, y: p3.y - p1.y};//向量P1P3: P3-P1
    v2 = {x: p4.x - p1.x, y: p4.y - p1.y};//向量P1P4: P4-P1
    v3 = {x: p2.x - p1.x, y: p2.y - p1.y};//向量P1P2: P2-P1
    let cross2 = crossMul(v1, v3) * crossMul(v2, v3);
    return (cross1 <= 0 && cross2 <= 0) ? true : false;
};