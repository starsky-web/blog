<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/11/18 0018
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/style.css" />
    <link rel="stylesheet" href="/static/css/editormd.preview.css" />
    <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
    <style>
        .editormd-html-preview {
            width: 90%;
            margin: 0 auto;
            padding-top: 9em;
        }
    </style>
</head>
<body>
<div id="layout">
    <div id="test-editormd-view">
        <textarea style="display:none;" name="test-editormd-markdown-doc"></textarea>
    </div>
    <div id="test-editormd-view2">
        <%--存放md数据--%>
        <textarea id="append-test" style="display:none;">
            ${articleContent}
        </textarea>
    </div>
</div>
<script src="static/js/jquery.min.js"></script>
<script src="static/lib/marked.min.js"></script>
<script src="static/lib/prettify.min.js"></script>
<script src="static/lib/raphael.min.js"></script>
<script src="static/lib/underscore.min.js"></script>
<script src="static/lib/sequence-diagram.min.js"></script>
<script src="static/lib/flowchart.min.js"></script>
<script src="static/lib/jquery.flowchart.min.js"></script>
<script src="static/js/editormd.js"></script>
<script type="text/javascript">
    $(function() {
        var testEditormdView, testEditormdView2;
        $.get("test.md", function(markdown) {
            testEditormdView = editormd.markdownToHTML("test-editormd-view", {
                markdown        : markdown ,//+ "\r\n" + $("#append-test").text(),
                htmlDecode      : "style,script,iframe",  // you can filter tags decode
                tocm            : true,    // Using [TOCM]
//                 markdownSourceCode : true, // 是否保留 Markdown 源码，即是否删除保存源码的 Textarea 标签
                emoji           : true,
                taskList        : true,
                tex             : true,  // 默认不解析
                flowChart       : true,  // 默认不解析
                sequenceDiagram : true,  // 默认不解析
            });
            // 获取Markdown源码
            //console.log(testEditormdView.getMarkdown());
            //alert(testEditormdView.getMarkdown());
        });
        testEditormdView2 = editormd.markdownToHTML("test-editormd-view2", {
            htmlDecode      : "style,script,iframe",  // you can filter tags decode
            emoji           : true,
            taskList        : true,
            tex             : true,  // 默认不解析
            flowChart       : true,  // 默认不解析
            sequenceDiagram : true,  // 默认不解析
        });
    });
</script>
</body>
</html>
