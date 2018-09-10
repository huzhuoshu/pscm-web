<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/imports.jsp" %>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <%@ include file="/WEB-INF/views/common/head.jsp" %>
    </head>
    <body>
        <div class="list-layout">
            <form class="query-form">
                <input type="hidden" id="totalRecords" value="${pagination.totalRecords}">
                <input type="hidden" id="page" name="page" value="${pagination.currentPage}">
                <input type="hidden" id="size" name="size" value="${pagination.pageSize}">
                <input type="hidden" id="order" name="order" value="${order}">
                <ul>
                    <li class="query-form-item">
                        <label class="query-form-item-name" for="optsegcode">光缆段编码:</label>
                        <input type="text"class="common-input" id="optsegcode" name="optsegcode" type="text" value="${Section.optsegcode}">
                    </li>
                    <li class="query-form-item ml5">
                        <button type="submit" class="common-button" id="queryBtn">
                            <i class="fa fa-search mr5"></i>查询
                        </button>
                        <button type="button" class="common-button common-button-green" id="resetBtn">
                            <i class="fa fa-square-o mr5"></i>重置
                        </button>
                    </li>
                </ul>
            </form>
            <div class="func-bar">
                <ul>
                    <li id="refreshBtn" class="func-item"><i class="fa fa-refresh mr5"></i>刷新</li>
                    <li id="addBtn" class="func-item"><i class="fa fa-plus-square-o mr5"></i>增加</li>
                    <li id="sortBtn" class="func-item"><i class="fa fa-sort-alpha-asc mr5"></i>排序</li>
                    <li id="exportBtn" class="func-item"><i class="fa fa-download mr5"></i>导出</li>
                </ul>
            </div>
            <div class="data-wrapper">
                <table class="common-table common-table-nowrap common-table-row" id="dataTable">
                    <thead>
                        <tr>
                            <!-- <th id="optsegid" class="sort"><span>光缆段ID</span><i class="fa fa-sort ml2 init"></i></th> -->
                            <th id="optsegcode" class="sort"><span>光缆段编码</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="optcableid" class="sort"><span>光缆编码</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="optsegname" class="sort"><span>光缆段名称</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="regionname" class="sort"><span>地区</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="ocfaType" class="sort"><span>A端交接设施类型</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="ocfaId" class="sort"><span>A端交接设施ID</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="ocfbType" class="sort"><span>B端交接设施类型</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="ocfbId" class="sort"><span>B端交接设施ID</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="fibernum" class="sort"><span>纤芯数</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="optseglen" class="sort"><span>皮长（米）</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="installation" class="sort"><span>敷设方式</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="maintainunit" class="sort"><span>维护部门</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="usedept" class="sort"><span>使用部门</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="operUser" class="sort"><span>操作帐号</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="operDate" class="sort"><span>操作时间</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="memo" class="sort"><span>备注</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="areaId" class="sort"><span>区域编码</span><i class="fa fa-sort ml2 init"></i></th>
                            <th class="no-export">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${dataList}" var="obj" varStatus="vs">
                            <tr>
                                <td><a href="javascript:;" class="common-link" id="detail" rid="${obj.optsegid}">${d:fs(obj.optsegcode)}</a></td>
                                <td><d:trans sourceKey="optcableid,optcablecode" value="${d:fs(obj.optcableid)}" source="TFocmpCable"/></td>
                                <td>${d:fs(obj.optsegname)}</td>
                                <td>${d:fs(obj.regionname)}</td>
                                <td>${d:fs(obj.ocfaType)}</td>
                                <td>${d:fs(obj.ocfaId)}</td>
                                <td>${d:fs(obj.ocfbType)}</td>
                                <td>${d:fs(obj.ocfbId)}</td>
                                <td>${obj.fibernum}</td>
                                <td>${obj.optseglen}</td>
                                <td>${d:fs(obj.installation)}</td>
                                <td>${d:fs(obj.maintainunit)}</td>
                                <td>${d:fs(obj.usedept)}</td>
                                <td>${d:fs(obj.operUser)}</td>
                                <td>${d:defaultDate(obj.operDate)}</td>
                                <td>${d:fs(obj.memo)}</td>
                                <td>${d:fs(obj.areaId)}</td>
                                <td class="f0">
                                    <a href="javascript:;" id="detail" title="详情" rid="${obj.optsegid}"><i class="fa fa-file-o ml5 fa-lg common-link" ></i></a>    
                                    <a href="javascript:;" id="edit" title="修改" rid="${obj.optsegid}"><i class="fa fa-edit ml5 fa-lg common-link" ></i></a>
                                    <a href="javascript:;" id="del" title="删除" rid="${obj.optsegid}"><i class="fa fa-trash-o ml5 fa-lg common-link" ></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="paginationBar" class="pagination-bar"></div>
        </div>
        
        <script>
            require(['common'], function(common) {
                var totalRecords = $("#totalRecords").val();
                var page = $("#page").val();
                var size = $("#size").val();
                var order = $("#order").val();
                
                common.initList(totalRecords, page, size, order);
            }); 
        </script>
    </body>
</html>