var webPath = "/" + window.location.pathname.split("/")[1];
//获取光缆段-路由信息
function getSectionData(callBack, paramsUrl) {
    let url = webPath + '/focmp/map/getSectionByParam';
    if(paramsUrl)
        url += "?" + paramsUrl;
    $.ajax({
        url: url,
        method: 'GET',
        success: callBack
    });
}