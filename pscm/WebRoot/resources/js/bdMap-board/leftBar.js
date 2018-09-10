$('#leftbar-trigger').click(function () {
    let opened = $('#leftbar-trigger-icon').hasClass('glyphicon-menu-left');
    let menuLeft = 'glyphicon-menu-left', menuRight = 'glyphicon-menu-right';
    $('#leftbar').stop().animate({left: opened ? "-300px" : "0px"}, 500);
    $('#leftbar-trigger-icon').removeClass(opened ? menuLeft : menuRight);
    $('#leftbar-trigger-icon').addClass(opened ? menuRight : menuLeft);
});

function openLeftBar() {
    let opened = $('#leftbar-trigger-icon').hasClass('glyphicon-menu-left');
    if(!opened) $('#leftbar-trigger').click();
}

function leftBar_showCableSectionList(sectionList, cableName) {
    if(!sectionList) return;
    $("#sectionList_contentScroll").empty();
    let index = 1;
    for(let i = 0; i < sectionList.length; i++){
        let section = sectionList[i];
        if(!cableName || cableName.trim() == '' || section.cableName.indexOf(cableName) >=0)
            showQueryCable(section, index++);
    }

    $("#searchCableBtn").click(function () {
        leftBar_showCableSectionList(dataContainer.sectionList, $("#sectionInfoListDiv_cableName").val());
    })

    function showQueryCable(cableSection, index) {
        let _addDiv = $("#template_cableItem").clone();
        _addDiv.show();
        _addDiv.find("span[name='index']").text(index);
        _addDiv.find("div[name='name']").text(cableSection.cableName);
        _addDiv.click(function () {
            leftBar_showCableInfo(cableSection);
        });
        $("#sectionList_contentScroll").append(_addDiv);
    }
}
function leftBar_showCableInfo(cableSection) {
    $("#cableInfoDiv_cableName").html(cableSection.cableName);
    $("#cableInfoDiv_level").html("一干");
    $("#cableInfoDiv_sectionList").empty();
    for(let i = 0; i < dataContainer.sectionList.length; i++){
        let cs = dataContainer.sectionList[i];
        if(cs.cableId == cableSection.cableId){
            let _addDiv = $("#template_sectionItem").clone();
            _addDiv.show();
            _addDiv.find("div[name='sectionName']").text(cs.sectionName);
            _addDiv.find("div[name='method']").text("未知");
            _addDiv.find("div[name='length']").text("未知");
            _addDiv.click(function () {
                changeLeftBarInfo({cableName: cs.cableName, sectionName: cs.sectionName, code: "L05.PSH00-DAGYQ/ZGG01/01", filberNum: "24", length: "1143米"});
                BD_viewport(cs.sectionId);
            });
            $("#cableInfoDiv_sectionList").append(_addDiv);
        }
    }

    leftBar_controlInfomation("cableInfoDiv");
}


function leftBar_showQueryInfo() {
    leftBar_controlInfomation("sectionInfoListDiv");
}
//控制leftbar的内容，控制div的显示和隐藏
function leftBar_controlInfomation(name) {
    let infoDivs = $("#leftbar > div[name='mainInfoDiv']");
    for(let i = 0; i < infoDivs.length; i++){
        let $infoDiv = $(infoDivs[i]);
        if($infoDiv.attr("id") == name)
            $infoDiv.show();
        else
            $infoDiv.hide();
    }
}

function changeLeftBarInfo(data) {
    leftBar_controlInfomation("sectionInfoDiv")
    for (let index in data){
        $("#left-bar-" + index).html(data[index]);
    }
}