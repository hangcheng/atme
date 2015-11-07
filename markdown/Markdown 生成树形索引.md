#Markdown 生成树形索引 方法
##
>推荐 天书： 理由没有引入第三方`js`或`css`，用 `tpl` 模板只生成一个 `html` 文件，非常简洁

>而且`Markdown`文件也可以拆开写，最终也只生成一个`html`文件


##方法一 、 天书
>想用`markdown`编写带索引的单页结构`HTML`文档的话，可以试试天书。

### 1、安装

	npm install tianshu -g

### 2、使用

>首先参考`demo/`目录，使用`markdown`编写一些章节文件（位于`demo/section/`），并使用`HTML`编写好页面模板文件（位于`demo/index.tpl`）。在模板文件中，使用`x-markdown`标签引用`.md`文件，并使用`x-index`标签指定索引输出位置。

>准备好所有文件后，使用以下命令将模板文件编译为HTML文件。

    D:\天书>tianshu index.tpl
	

>如果希望生成的`index.html`好看一些，可以在`index.tpl`里写一些CSS。

<br>

##方法二 、 JS形成左边树用法
###1、页面结构
>放入在文章页内容前面

~~~~
<div class="BlogAnchor">
    <p>
        <b id="AnchorContentToggle" title="收起" style="cursor:pointer;">目录[-]</b>
    </p>
    <div class="AnchorContent" id="AnchorContent"> </div>
</div>
~~~~
###2、Js代码
>在文章中查找title并填充到div AnchorContent中

~~~~
$(".post-content").find("h2,h3,h4,h5,h6").each(function(i,item){
    var tag = $(item).get(0).localName;
    $(item).attr("id","wow"+i);
    $("#AnchorContent").append('<li><a class="new'+tag+' anchor-link" onclick="return false;" href="#" link="#wow'+i+'">'+(i+1)+" · "+$(this).text()+'</a></li>');
    $(".newh2").css("margin-left",0);
    $(".newh3").css("margin-left",20);
    $(".newh4").css("margin-left",40);
    $(".newh5").css("margin-left",60);
    $(".newh6").css("margin-left",80);
});
$("#AnchorContentToggle").click(function(){
    var text = $(this).html();
    if(text=="目录[-]"){
        $(this).html("目录[+]");
        $(this).attr({"title":"展开"});
    }else{
        $(this).html("目录[-]");
        $(this).attr({"title":"收起"});
    }
    $("#AnchorContent").toggle();
});
~~~~
###3、CSS代码
~~~~
.BlogAnchor {
    background: #f4f7f9;
    padding: 10px;
    line-height: 180%;
}
.BlogAnchor p {
    font-size: 18px;
    color: #15a230;
    margin-bottom: 0.3em;
}
.BlogAnchor .AnchorContent {
    padding: 5px 0px;
}
.BlogAnchor li{
    text-indent: 20px;
    font-size: 14px;
}
#AnchorContentToggle {
    font-size: 13px;
    font-weight: normal;
    color: #FFF;
    display: inline-block;
    line-height: 20px;
    background: #5cc26f;
    font-style: normal;
    padding: 1px 8px;
    margin-right: 10px;
}
.BlogAnchor a:hover {
    color: #5cc26f;
}
.BlogAnchor a {
    text-decoration: none;
}
~~~~
###4、导航扩展
>同时也可以实现锚点之间的平滑滚动，使用jquery animate

~~~~
$(".anchor-link").click(function(){
    $("html,body").animate({scrollTop: $($(this).attr("link")).offset().top}, 1000);
});
~~~~

<br>
##方法三 、 JS形成左边树用法
> 优点：扩展性强、可折叠 
> 
> 缺点：需要引用js css 不方便 繁琐
> 
##
###1、在选项 > 高级 > HTML Head 编辑器 中加入以下代码：
~~~
	<link rel="stylesheet" href="E:/MarkDownWorkspace/common/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript"  src="E:/MarkDownWorkspace/common/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript"  src="E:/MarkDownWorkspace/common/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript"  src="E:/MarkDownWorkspace/common/js/ztree_toc.js"></script>
	<script type="text/javascript"  src="E:/MarkDownWorkspace/common/js/MathJax.js"></script>
	<script type="text/javascript" >
		$(document).ready(function(){
			$('#tree').ztree_toc({
				is_auto_number:true
			});
		});
	</script>
~~~
>注：MathJax.js 为数学 其他则是树形必要的js，如果有用到其他js，则需要在此引用js


###2、在md 中加入 html 代码如下：
~~~
<div style="width:300px;align:left;">
  <ul id="tree" class="ztree"></ul>
</div>

<div style="margin-left:100px !important;" class='first_part'>
~~~
>注：第二个div 不需要结束

##方法四、i5ting_toc 生成索引
>其实就是 方法三  不过是采用nodejs 进行生成

####1、安装
~~~~~
npm install -g i5ting_toc
~~~~~
####2、使用 
~~~~
i5ting_toc -f sample.md -o
----------------------------------------
选项：
	-h, --help             输出帮助信息
    -V, --version          输出版本
    -f, --file [filename]  默认文件为 README.md 
    -o, --open          	   是否打开到浏览器
    -v, --verbose          打印详细日志
~~~~
