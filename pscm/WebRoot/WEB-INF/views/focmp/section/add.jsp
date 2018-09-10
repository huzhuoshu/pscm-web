<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/imports.jsp" %>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <%--<%@ include file="/WEB-INF/views/common/headWithAuto.jsp" %>--%>
        <c:if test="${autoToken != null && autoToken != ''}"><%@ include file="/WEB-INF/views/common/auto/autoToken.jsp" %></c:if>
        <c:if test="${autoLogging}"><%@ include file="/WEB-INF/views/common/auto/autoLogging.jsp" %></c:if>
    </head>
    <body>
        <div class="single-layout">
            <form id="addSection" method="post" action="${_webPath}/focmp/section/add">
                <div class="single-title-wrapper">
                    <span class="single-title">
                        <i class="fa fa-plus-square-o fa-lg mr5"></i>增加光缆段(带<i class="need"></i>为需要填写的项)
                    </span>
                </div>
                <ul class="single-info">
                    <li class="single-info-item" style="display: none;">
                        <label class="single-info-item-name" for="optcableid">光缆ID：</label>
                        <d:validate name="optcableid" css="common-input common-input-long" validateObject="${TFocmpSection}" value="${tFocmpSection.optcableid}"/>
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="optsegcode">光缆段编码：</label>
                        <d:validate name="optsegcode" css="common-input common-input-long" validateObject="${TFocmpSection}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="optsegname"><i class="need"></i>光缆段名称：</label>
                        <d:validate name="optsegname" css="common-input common-input-long" validateObject="${TFocmpSection}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="regionname">地区：</label>
                        <d:validate name="regionname" css="common-input common-input-long" validateObject="${TFocmpSection}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="fibernum">纤芯数：</label>
                        <d:validate name="fibernum" css="common-input common-input-long" validateObject="${TFocmpSection}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="optseglen">皮长（米）：</label>
                        <d:validate name="optseglen" css="common-input common-input-long" validateObject="${TFocmpSection}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="installation">敷设方式：</label>
                        <d:validate name="installation" css="common-input common-input-long" validateObject="${TFocmpSection}" />
                    </li>
                    <li class="single-info-item">
                        <label class="single-info-item-name" for="memo">备注：</label>
                        <d:validate name="memo" css="common-input common-input-long" validateObject="${TFocmpSection}" />
                    </li>

                    <li class="single-info-item">
                        <label class="single-info-item-name"></label>
                        <button type="submit" id="addBtn" class="common-button">
                            <i class="fa fa-save mr5"></i>提交
                        </button>
                    </li>
                </ul>
            </form>
        </div>

        <script>
            $("#addSection").submit(function() {
                var url = "${_webPath}/focmp/section/add";
                var optcablecode = $("#optcablecode").val();
                var optcablename = $("#optcablename").val();

                if(optcablename == ''){
                    alert("请填写光缆段名称！");
                    return false;
                }

                $.post(url, $(this).serialize(), function(data) {
                    if (data == "1") {
                        alert("保存成功！");
                        $("#readySelectNodeStepparent").click();
                        location.reload();
                    } else {
                        alert("数据异常");
                    }
                });
                return false;
            });
        </script>
    </body>
</html>