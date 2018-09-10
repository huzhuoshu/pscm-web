<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/imports.jsp" %>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <%@ include file="/WEB-INF/views/common/headWithAuto.jsp" %>
    </head>
    <body>
        <div class="single-layout">
            <form method="post">
                <div class="single-title-wrapper">
                    <span class="single-title">
                        <i class="fa fa-edit fa-lg mr5"></i>修改(带<i class="need"></i>为需要填写的项)
                    </span>
                </div>
                <ul class="single-info">
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="nodeid"><i class="need"></i>信息点编号：</label>
                        <d:validate name="nodeid" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.nodeid}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="nodename"><i class="need"></i>节点名称：</label>
                        <d:validate name="nodename" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.nodename}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="nodetypeid"><i class="need"></i>节点类型：</label>
                        <d:validate name="nodetypeid" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.nodetypeid}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="areaid">所在区域：</label>
                        <d:validate name="areaid" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.areaid}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="nodegpsx">gps经度：</label>
                        <d:validate name="nodegpsx" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.nodegpsx}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="nodegpsy">gps纬度：</label>
                        <d:validate name="nodegpsy" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.nodegpsy}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="nodex">百度经度：</label>
                        <d:validate name="nodex" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.nodex}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="nodey">百度纬度：</label>
                        <d:validate name="nodey" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.nodey}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="pndistance">与前相邻信息点距离：</label>
                        <d:validate name="pndistance" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.pndistance}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="remarks">备注：</label>
                        <d:validate name="remarks" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.remarks}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="coordinate">坐标获取方式类型 1：手机gps 2.百度 ，其他自行补充：</label>
                        <d:validate name="coordinate" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.coordinate}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="operUser">最后操作用用户ID：</label>
                        <d:validate name="operUser" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.operUser}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="operUserType"> 修改用户类型1手机端用户 2PC端用户：</label>
                        <d:validate name="operUserType" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.operUserType}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="operDate">最后操作日期：</label>
                        <d:validate name="operDate" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.operDate}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="stat">状态：S0A或者为空有效，S0X无效：</label>
                        <d:validate name="stat" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.stat}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="city">：</label>
                        <d:validate name="city" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.city}" />
                    </li>	    		
                		<li class="single-info-item">
                        <label class="single-info-item-name" for="district">：</label>
                        <d:validate name="district" css="common-input common-input-long" validateObject="${TFocmpNode}" value="${tFocmpNode.district}" />
                    </li>	    		

                    <li class="single-info-item">
                        <label class="single-info-item-name"></label>
                        <button type="submit" id="editBtn" class="common-button">
                            <i class="fa fa-save mr5"></i>提交
                        </button>
                        <button type="button" id="backBtn" class="common-button common-button-green ml10">
                            <i class="fa fa-chevron-left mr5"></i>返回
                        </button>
                    </li>
                </ul>
            </form>
        </div>

        <script>
            require([ 'common' ], function(common) {
                // 初始化页面
                common.initEdit();
            });
        </script>
    </body>
</html>