<%@ taglib prefix="method" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>

<%--图片大小--%>
<style>
    .photo {
        width: 70px;
        height: 70px;
        margin: 10px;
    }
</style>
<script>

    /**
     * 上架时间修改为正确的显示格式
     * */
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    /**
     * 双击判断是否插入新的菜单栏节点
     * */
    function onCategoryDblClick(node) {
        if (node.children && node.children.length > 0) {
            return
        }
        $.ajax({
            url: node.id ? '${pageContext.request.contextPath}/category/list.json?id=' + node.id : '${pageContext.request.contextPath}/category/list.json',
            method: 'get',
            success: function (data) {
                $('#category_list').tree('append', {
                    parent: node.target,
                    data: data
                });
            }
        })
    }

    /**
     * 商品新增
     * */
    function productAppend() {
        <%--打开新增商品页面--%>
        //TODO
        $("#product_insert_win").window("open")
    }

    function productRemove() {
        <%--删除商品--%>
        //TODO
    }

    /**
     * 菜单栏新增分类
     */
    function append() {
        var t = $('#category_list');
        var node = t.tree('getSelected');
        $("#category_dialog").dialog('open')
    }

    /**
     * 菜单栏新增取消
     * */
    function cancelDialog() {
        $("#category_dialog").dialog('close')
        $("#category_name").textbox('setText', "")
    }

    /**
     * 菜单栏新增提交
     * */
    function submitDialog() {
        var t = $('#category_list');
        var node = t.tree('getSelected');
        var categoryName = $("#category_name").textbox("getText")
        $.ajax({
            url: '${pageContext.request.contextPath}/category/add',
            method: 'post',
            data: {
                name: categoryName,
                parentId: node.id
            },
            success: function (data) {
                if (!node.children || !node.children.length) {
                    onCategoryDblClick(node)
                } else {
                    $('#category_list').tree('append', {
                        parent: node.target,
                        data: [data]
                    });
                }
                $("#category_dialog").dialog('close')
                $("#category_name").textbox('setText', "")
            }
        })
    }

    /**
     * 菜单栏删除分类
     */
    function remove() {
        var t = $('#category_list');
        var node = t.tree('getSelected');
        var categoryName = $("#category_name").textbox("getText")
        $.ajax({
            url: '${pageContext.request.contextPath}/category/delete',
            method: 'post',
            data: {
                name: categoryName,
                id: node.id
            },
            success: function () {
                t.tree('remove', node.target);
            }
        })
    }

    /**
     * 菜单栏修改分类
     */
    function edit() {
        var t = $('#category_list');
        var node = t.tree('getSelected');
        var categoryName = $("#category_name").textbox("getText")
        $.ajax({
            url: '${pageContext.request.contextPath}/category/update',
            method: 'post',
            data: {
                name: categoryName,
                id: node.id,
            },
            success: function () {
                t.tree('beginEdit', node.target);
            }
        })
    }

    /**
     * 取出菜单栏
     * */
    function categoryFilter(data) {
        var arr = []
        for (var i = 0; i < data.length; i++) {
            arr.push({
                id: data[i].id,
                text: data[i].name,
                parentId: data[i].parentId
            })
        }
        return arr
    }

    // /**
    //  * 点击跳转至图片详情
    //  * @param val
    //  * @param row
    //  * @returns {string}
    //  */
    // function formatImage(val, row) {
    //     return '<a href=' + val + ' target="_blank">点击查看图片</a>'
    // }

    // /**
    //  * 点击跳转至图片描述详情
    //  * @param val
    //  * @param row
    //  * @returns {string}
    //  */
    // function formatDescriptionImage(val, row) {
    //     return '<a href=' + val + ' target="_blank">点击查看图片描述</a>'
    // }

    // /**
    //  * 点击跳转至商品描述窗口
    //  * @param val
    //  * @param row
    //  * @returns {string}
    //  */
    // function formatParams(val, row) {
    //     return '<a href="javascript:void(0)" onclick="paramsClick(this)" data-params=\'' + val + '\'>点击查看商品详细参数</a>'
    // }

    /**
     * 双击进入商品详情修改界面
     * @param index
     * @param row
     */
    function onTableClickRow(index, row) {
        $.ajax({
            url: '${pageContext.request.contextPath}/category?id=' + row.categoryId,
            method: 'get',
            success: function (category) {
                $("#productCategory").textbox('setText', category.name)
            }
        })
        $.ajax({
            url: '${pageContext.request.contextPath}/product/description.json?id=' + row.id,
            method: 'get',
            success: function (productDescription) {
                $("#productDescription").texteditor('setValue', productDescription.description)
            }
        })
        $("#productName").textbox('setText', row.name)
        $("#productPrice").textbox('setText', row.price)
        $("#productDiscount").textbox('setText', row.discount)
        $("#productStoreNum").textbox('setText', row.storeNum)
        $("#productSaleNum").textbox('setText', row.saleNum)
        $("#productCommentNum").textbox('setText', row.commentNum)
        var status
        if (row.status == "ON_SHELF")
            status = "上架"
        else
            status = "下架"
        $("#productStatus").textbox('setText', status)
        var date = row.saleDate
        $("#productSaleDate").textbox('setText', new Date(date).Format("yyyy/MM/dd HH:mm:ss"))
        var images = row.imageUrls.split(";")
        $("#image").empty()
        for (var i = 0; i < images.length; i++) {
            var url = images[i]
            var photo = $('<img class="photo" src="' + url + '"/>')
            photo.bind('contextmenu', function (e) {
                e.preventDefault();
                console.log(url)
                $('#product_image_menu').menu('show', {
                    left: e.pageX,
                    top: e.pageY
                });
            })
            $("#image").append(photo)
        }
        // var upload = $('<input class="easyui-filebox" label="File1:" labelPosition="top" data-options="prompt:\'Choose a file...\'" style="width:100%">')
        // $("#image").append(upload)
        <%--打开修改商品窗口页面--%>
        $("#product_win").window("open")
    }

    /**
     * 初始菜单栏
     * */
    $(function () {
        setTimeout(function () {
            $("#category_list").tree('loadData', [{
                id: null,
                name: '所有分类'
            }])
        }, 500)
        /**
         * 上传图片
         * @type {string}
         */
        var photoImgUrl = '';
        //file change event
        $('input[type="file"]').change(function (e) {
            // $('#img').attr('src',$("#tmpfile").val());
            var file = this.files[0];
            if (window.FileReader) {
                var reader = new FileReader();
                reader.readAsDataURL(file);
                //监听文件读取结束后事件
                reader.onloadend = function (e) {
                    // $("#img").attr("src",e.target.result);    //e.target.result就是最后的路径地址
                    var url = e.target.result;
                    var photo = $('<img class="photo" src="' + url + '"/>')
                    $("#image").append(photo)
                    // photoImgUrl+=
                };
                $('#selectImage').empty();
            }
        })


        <%--商品描述框--%>
        $('#productDescription').texteditor({
            //...
        });
    });

</script>
<%--参数窗口--%>
<div id="product_win" class="easyui-window" title="详细参数" data-options="iconCls:'icon-save',closed:true,modal:true"
     style="padding:10px;width: 500px;height: 100%">
    <form id="product_description" action="product.jsp" method="post">
        <div style="margin-bottom:20px">
            <input id="productName" class="easyui-textbox" name="name" style="width:100%"
                   data-options="label:'商品名称:',required:true">
        </div>
        <div id="image" style="margin-bottom:20px">

        </div>
        <div id="imageUpload" style="margin-bottom:20px">

            <input type="file" id="selectImage">
        </div>

        <div style="margin-bottom:20px">
            <input id="productPrice" class="easyui-textbox" name="price" style="width:100%"
                   data-options="label:'商品价格:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="productDiscount" class="easyui-textbox" name="discount" style="width:100%"
                   data-options="label:'优惠价:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" name="state" label="商品状态:" labelPosition="left" style="width:100%;"
                    panelHeight="50">
                <option value="ON_SHELF">上架</option>
                <option value=" LEAVE_SHELF">下架</option>
            </select>
        </div>
        <div style="margin-bottom:20px">
            <input id="productSaleDate" class="easyui-textbox" name="saleDate" style="width:100%"
                   data-options="label:'上架日期:',required:true" readonly>
        </div>
        <%--<div style="margin-bottom:20px">--%>
        <%--<input id="productCategory" class="easyui-combotree" name="category" value="122"--%>
        <%--data-options="url:'${pageContext.request.contextPath}/category',method:'get',--%>
        <%--label:'商品分类:',labelPosition:'left'" style="width:100%">--%>
        <%--</div>--%>
        <div style="margin-bottom:20px">
            <input id="productStoreNum" class="easyui-textbox" name="storeNum" style="width:100%"
                   data-options="label:'商品库存总量:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="productSaleNum" class="easyui-textbox" name="saleNum" style="width:100%"
                   data-options="label:'商品销售总量:',required:true" readonly>
        </div>
        <div style="margin-bottom:20px">
            <input id="productCommentNum" class="easyui-textbox" name="commentNum" style="width:100%"
                   data-options="label:'评论总数:',required:true" readonly>
        </div>
        <div id="productDescription" class=" easyui-texteditor" data-options=label:'商品信息' style="height: 300px">
        </div>
    </form>
</div>
<%--录入商品--%>
<div id="product_insert_win" class="easyui-window" title="录入商品" data-options="iconCls:'icon-save',closed:true,modal:true"
     style="padding:10px;width: 500px;height: 100%">
    <form id="product_description1" action="product.jsp" method="post">
        <div style="margin-bottom:20px">
            <input id="productName1" class="easyui-textbox" name="name" style="width:100%"
                   data-options="label:'商品名称:',required:true">
        </div>
        <div id="image" style="margin-bottom:20px">

        </div>
        <div id="imageUpload" style="margin-bottom:20px">

            <input type="file" id="selectImage1">
        </div>

        <div style="margin-bottom:20px">
            <input id="productPrice1" class="easyui-textbox" name="price" style="width:100%"
                   data-options="label:'商品价格:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="productDiscount1" class="easyui-textbox" name="discount" style="width:100%"
                   data-options="label:'优惠价:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" name="state" label="商品状态:" labelPosition="left" style="width:100%;"
                    panelHeight="50">
                <option value="ON_SHELF">上架</option>
                <option value=" LEAVE_SHELF">下架</option>
            </select>
        </div>
        <div style="margin-bottom:20px">
            <input id="productSaleDate1" class="easyui-textbox" name="saleDate" style="width:100%"
                   data-options="label:'上架日期:',required:true" readonly>
        </div>
        <%--<div style="margin-bottom:20px">--%>
        <%--<input id="productCategory1" class="easyui-combotree" name="category" value="122"--%>
        <%--data-options="url:'${pageContext.request.contextPath}/category',method:'get',--%>
        <%--label:'商品分类:',labelPosition:'left'" style="width:100%">--%>
        <%--</div>--%>
        <div style="margin-bottom:20px">
            <input id="productStoreNum1" class="easyui-textbox" name="storeNum" style="width:100%"
                   data-options="label:'商品库存总量:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="productSaleNum1" class="easyui-textbox" name="saleNum" style="width:100%"
                   data-options="label:'商品销售总量:',required:true" readonly>
        </div>
        <div style="margin-bottom:20px">
            <input id="productCommentNum1" class="easyui-textbox" name="commentNum" style="width:100%"
                   data-options="label:'评论总数:',required:true" readonly>
        </div>
        <div id="productDescription" class=" easyui-texteditor" data-options=label:'商品信息' style="height: 300px">
        </div>
    </form>
</div>
<%--商品分类栏新增窗口--%>
<div id="category_dialog" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true"
     style="width:400px;height:200px;padding:10px">
    <input id="category_name" class="easyui-textbox" name="name" style="width:100%"
           data-options="label:'商品名称:',required:true">
    <button onclick="submitDialog()">提交</button>
    <button onclick="cancelDialog()">取消</button>
</div>

<%--&lt;%&ndash;副文本&ndash;%&gt;--%>
<%--<div id="#description_win" class="easyui-window" title="aa" data-options="closed:true"--%>
<%--style="width:700px;height:300px;padding:20px">--%>
<%--<div id="tt1" class="easyui-texteditor"   style="width:600px;height:200px;padding:20px" >--%>
<%--</div>--%>
<%--</div>--%>

<%--商品分类用户工具栏--%>
<div id="product_category_tool">
    <a href="javascript:void(0)" class="icon-add" onclick="append()"></a>
    <a href="javascript:void(0)" class="icon-remove" onclick="remove()" style="margin-right: 10px"></a>
    <a href="javascript:void(0)" class="icon-edit" onclick="edit()" style="margin-right: 10px"></a>
</div>
<%--商品列表用户工具栏--%>
<div id="product_tool">
    <a href="javascript:void(0)" class="icon-add" onclick="productAppend()"></a>
    <a href="javascript:void(0)" class="icon-remove" onclick="productRemove()" style="margin-right: 10px"></a>
</div>
<%--图片删除--%>
<div id="product_image_menu" class="easyui-menu" style="width:120px;">
    <div onclick="remove()" data-options="iconCls:'icon-remove'">删除</div>
</div>
<%--工具栏--%>
<div id="product_category_tool2" class="easyui-menu" style="width:120px;">
    <div onclick="append()" data-options="iconCls:'icon-add'">添加</div>
    <div onclick="remove()" data-options="iconCls:'icon-remove'">删除</div>
    <div onclick="edit()" data-options="iconCls:'icon-edit'">修改</div>
</div>
<%--商品分类菜单栏--%>
<div class="easyui-layout" style="width: 100%;height: 100%;">
    <div data-options="region:'west',split:true" style="width:250px;height: 100%;">
        <div class="easyui-panel" title="商品分类" data-options="tools:'#product_category_tool'"
             border="false">
            <ul id="category_list" class="easyui-tree" data-options="{
                 loadFilter: categoryFilter,
                 onContextMenu: function(e,node){
                    e.preventDefault();
                    $(this).tree('select',node.target);
                    $('#product_category_tool2').menu('show',{
                        left: e.pageX,
                        top: e.pageY
                    });
                 },
                 onClick:function (node) {
                    var table = $('#product_table')
                    if(node.id>0){
                        $.ajax({
                            url:'${pageContext.request.contextPath}/product/list?categoryId='+node.id,
                            method:'get',
                            success:function(data){
                                table.datagrid('loadData',data)
                            }
                         })
                    }
                },
                onDblClick: onCategoryDblClick,
                onAfterEdit: function(node){
                    if(node.id && node.id>0){
                        $.ajax({
                            url:'${pageContext.request.contextPath}/category/update',
                            method:'post',
                            data:{
                                id:node.id,
                                name:node.text,
                                parentId: node.parentId
                            },
                            success:function(category){
                                node.text = category.name
                            }
                        })
                        return
                    }
                    $.ajax({
                        url:'${pageContext.request.contextPath}/category/add',
                        method:'post',
                        data:{
                            name:node.text,
                            parentId: node.parentId
                        },
                        success:function(category){
                            node.id = category.id
                            node.text = category.name
                            node.parentId = category.parentId
                        }
                    })
                }
            }">
            </ul>
        </div>
    </div>
    <%--商品表单--%>
    <div data-options="region:'center'">
        <div class="easyui-panel" title="商品列表" data-options="tools:'#product_tool'" style="width: 100%">
            <table class="easyui-datagrid" id="product_table" style="width:auto;height:auto;border:1px solid #ccc;"
                   data-options="{
                                    singleSelect:true,
                                    collapsible:true,
                                    onDblClickRow:onTableClickRow
                                }">
                <thead>
                <%--表格显示项目--%>
                <tr>
                    <%--<th data-options="field:'id'">商品ID</th>--%>
                    <th data-options="field:'name'">商品名</th>
                    <th data-options="field:'price',align:'right'">商品价格</th>
                    <th data-options="field:'discount',align:'right'">优惠价</th>
                    <%--<th data-options="field:'status'">商品状态</th>--%>
                    <%--<th data-options="field:'saleDate'">上架时间</th>--%>
                    <%--<th data-options="field:'categoryId'">商品分类ID</th>--%>
                    <th data-options="field:'storeNum'">商品库存总量</th>
                    <th data-options="field:'saleNum'">商品销售总量</th>
                    <%--<th data-options="field:'imageUrls',width:150,formatter:formatImage">商品图片</th>--%>
                    <th data-options="field:'commentNum'">总评论数</th>
                </tr>
                </thead>
            </table>
            <div>

            </div>
        </div>
    </div>
</div>

</body>
</html>
