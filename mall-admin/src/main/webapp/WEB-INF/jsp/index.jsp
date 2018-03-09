<%--
  Created by IntelliJ IDEA.
  User: 314-d04
  Date: 2018/03/05
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/easyui-1.5.4.2/themes/default/easyui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/easyui-1.5.4.2/themes/icon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/easyui-1.5.4.2/jquery-easyui-texteditor/texteditor.css">

    <style>
        html,body{
            margin: 0;
            padding: 0;
        }
        .button {
            text-decoration: none;
            color: inherit;
        }
    </style>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/static/easyui-1.5.4.2/jquery.min.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/static/easyui-1.5.4.2/jquery.easyui.min.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/static/easyui-1.5.4.2/jquery-easyui-texteditor/jquery.texteditor.js"></script>

    <script type="application/javascript">

    </script>
</head>
<body>
<div class="easyui-layout" style="width: 100%;height: 100%;">
    <div data-options="region:'west',split:true" title="菜单栏" style="width:200px;height: 100%;">
        <ul id="menu" class="easyui-tree" data-options="{
                 onClick:function (node) {
                    if(node.attributes&&node.attributes.url){
                        var tabs = $('#tt')
                        if(tabs.tabs('getTab',node.text)){
                            tabs.tabs('select',node.text)
                        }else{
                            tabs.tabs('add',{
                                title:node.text,
                                href:node.attributes.url,
                                closable:true
                            })
                        }
                    }
                }
            }">
            <li data-options="attributes:{'url':'${pageContext.request.contextPath}/product'}">
                <span>商品分类管理</span>
            </li>
            <li>
                <span>订单管理</span>
                <ul>
                    <li>
                        <span>Photos</span>
                    </li>
                    <li>
                        <span>Program Files</span>
                    </li>
                    <li>index.html</li>
                    <li>about.html</li>
                    <li>welcome.html</li>
                </ul>
            </li>
            <li>
                <span>用户管理</span>
                <ul>
                    <li>
                        <span>Photos</span>
                    </li>
                    <li>
                        <span>Program Files</span>
                    </li>
                    <li>index.html</li>
                    <li>about.html</li>
                    <li>welcome.html</li>
                </ul>
            </li>
            <li>
                <span>首页管理</span>
                <ul>
                    <li>
                        <span>Photos</span>
                    </li>
                    <li>
                        <span>Program Files</span>
                    </li>
                    <li>index.html</li>
                    <li>about.html</li>
                    <li>welcome.html</li>
                </ul>
            </li>
        </ul>
    </div>
    <div data-options="region:'center'" style="height: 100%;">
        <div id="tt" class="easyui-tabs" style="width:100%;height: 100%;">
        </div>
    </div>
</div>
</body>
</html>
