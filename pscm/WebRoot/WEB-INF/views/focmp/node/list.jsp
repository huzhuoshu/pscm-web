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
                        <label class="query-form-item-name">设施名称:</label>
                        <input type="text"class="common-input" name="nodename" type="text" value="${TFocmpNode.nodename}">
                    </li>
                    <li class="query-form-item">
                        <label class="query-form-item-name">设施类型:</label>
                        <input type="text"class="common-input" name="nodetypeid" type="text" value="${TFocmpNode.nodetypeid}">
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
                            <%--<th id="nodeid" class="sort"><span>信息点编号</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <th id="nodename" class="sort"><span>设施名称</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="nodetypeid" class="sort"><span>设施类型</span><i class="fa fa-sort ml2 init"></i></th>
                            <%--<th id="areaid" class="sort"><span>所在区域</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <%--<th id="nodegpsx" class="sort"><span>gps经度</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <%--<th id="nodegpsy" class="sort"><span>gps纬度</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <th id="nodex" class="sort"><span>百度经度</span><i class="fa fa-sort ml2 init"></i></th>
                            <th id="nodey" class="sort"><span>百度纬度</span><i class="fa fa-sort ml2 init"></i></th>
                            <%--<th id="pndistance" class="sort"><span>与前相邻信息点距离</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <th id="remarks" class="sort"><span>备注</span><i class="fa fa-sort ml2 init"></i></th>
                            <%--<th id="coordinate" class="sort"><span>坐标获取方式类型 1：手机gps 2.百度 ，其他自行补充</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <th id="operUser" class="sort"><span>最后操作用户</span><i class="fa fa-sort ml2 init"></i></th>
                            <%--<th id="operUserType" class="sort"><span> 修改用户类型1手机端用户 2PC端用户</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <th id="operDate" class="sort"><span>最后操作日期</span><i class="fa fa-sort ml2 init"></i></th>
                            <%--<th id="stat" class="sort"><span>状态：S0A或者为空有效，S0X无效</span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <%--<th id="city" class="sort"><span></span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <%--<th id="district" class="sort"><span></span><i class="fa fa-sort ml2 init"></i></th>--%>
                            <th class="no-export">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${dataList}" var="obj" varStatus="vs">
                            <tr>
                                <%--<td><a href="javascript:;" class="common-link" id="detail" rid="${obj.nodeid}">${obj.nodeid}</a></td>  --%>
                                <td>${d:fs(obj.nodename)}</td>
                                <td>${d:fs(obj.nodetypeid)}</td>
                                <%--<td>${d:fs(obj.areaid)}</td>--%>
                                <%--<td>${obj.nodegpsx}</td>--%>
                                <%--<td>${obj.nodegpsy}</td>--%>
                                <td>${obj.nodex}</td>
                                <td>${obj.nodey}</td>
                                <%--<td>${d:fs(obj.pndistance)}</td>--%>
                                <td>${d:fs(obj.remarks)}</td>
                                <%--<td>${d:fs(obj.coordinate)}</td>--%>
                                <td>${d:fs(obj.operUser)}</td>
                                <%--<td>${obj.operUserType}</td>--%>
                                <td>${d:defaultDate(obj.operDate)}</td>
                                <%--<td>${d:fs(obj.stat)}</td>--%>
                                <%--<td>${d:fs(obj.city)}</td>--%>
                                <%--<td>${d:fs(obj.district)}</td>--%>
                                <td class="f0">
                                    <a href="javascript:;" id="detail" title="详情" rid="${obj.nodeid}"><i class="fa fa-file-o ml5 fa-lg common-link" ></i></a>    
                                    <a href="javascript:;" id="edit" title="修改" rid="${obj.nodeid}"><i class="fa fa-edit ml5 fa-lg common-link" ></i></a>
                                    <a href="javascript:;" id="del" title="删除" rid="${obj.nodeid}"><i class="fa fa-trash-o ml5 fa-lg common-link" ></i></a>
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