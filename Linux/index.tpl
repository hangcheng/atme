<!doctype HTML>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1" />
<title>Linux 学习</title>
<style>
/* RESET
=============================================================================*/
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p,
	blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn,
	em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var,
	b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend,
	table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas,
	details, embed, figure, figcaption, footer, header, hgroup, menu, nav,
	output, ruby, section, summary, time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
}

/* BODY
=============================================================================*/
body {
	font-family: Helvetica, arial, freesans, clean, sans-serif;
	font-size: 14px;
	line-height: 1.6;
	color: #333;
	background-color: #fff;
	padding: 0 30px 0 270px;
	max-width: 960px;
	margin: 0 auto;
}

body>*:first-child {
	margin-top: 0 !important;
}

body>*:last-child {
	margin-bottom: 0 !important;
}

/**********   索引 **********************************/
nav {
	font-size: 10pt;
	overflow-x: hidden;
	overflow-y: auto;
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	width: 270px;
}

nav .menubar {
	border-bottom: solid 1px #ccc;
	display: none;
	height: 48px;
	line-height: 48px;
	padding: 0 10px;
}

nav .button {
	background: #777;
	border: 1px solid #333;
	color: #fff;
	font-size: 10pt;
	font-weight: bold;
	padding: 8px;
	border-radius: 4px;
}

nav ul {
	padding: 0 0 0 10px;
}

nav ul a {
	color: #333;
	text-decoration: none;
}

nav ul a:hover {
	text-decoration: underline;
}

nav li {
	line-height: 180%;
	list-style: none;
	margin: 0;
	padding: 0;
}

nav .level2 {
	font-size: 11pt;
	font-weight: bold;
}

nav .level3 {
	padding-left: 1em;
}

nav .level4 {
	padding-left: 2em;
}

nav .level5 {
	padding-left: 4em;
}

nav .level6 {
	padding-left: 8em;
}

header {
	text-align: center;
}

/* BLOCKS
=============================================================================*/
p, blockquote, ul, ol, dl, table, pre {
	margin: 15px 0;
}

/* HEADERS
=============================================================================*/
h1, h2, h3, h4, h5, h6 {
	margin: 20px 0 10px;
	padding: 0;
	font-weight: bold;
	-webkit-font-smoothing: antialiased;
}

h1 tt, h1 code, h2 tt, h2 code, h3 tt, h3 code, h4 tt, h4 code, h5 tt,
	h5 code, h6 tt, h6 code {
	font-size: inherit;
}

h1 {
	font-size: 28px;
	color: #000;
}

h2 {
	font-size: 24px;
	border-bottom: 1px solid #ccc;
	color: #000;
}

h3 {
	font-size: 18px;
}

h4 {
	font-size: 16px;
}

h5 {
	font-size: 14px;
}

h6 {
	color: #777;
	font-size: 14px;
}

body>h2:first-child, body>h1:first-child, body>h1:first-child+h2, body>h3:first-child,
	body>h4:first-child, body>h5:first-child, body>h6:first-child {
	margin-top: 0;
	padding-top: 0;
}

a:first-child h1, a:first-child h2, a:first-child h3, a:first-child h4,
	a:first-child h5, a:first-child h6 {
	margin-top: 0;
	padding-top: 0;
}

h1+p, h2+p, h3+p, h4+p, h5+p, h6+p {
	margin-top: 10px;
}

/* LINKS
=============================================================================*/
a {
	color: #4183C4;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

/* LISTS
=============================================================================*/
ul, ol {
	padding-left: 30px;
}

ul li>:first-child, ol li>:first-child, ul li ul:first-of-type, ol li ol:first-of-type,
	ul li ol:first-of-type, ol li ul:first-of-type {
	margin-top: 0px;
}

ul ul, ul ol, ol ol, ol ul {
	margin-bottom: 0;
}

dl {
	padding: 0;
}

dl dt {
	font-size: 14px;
	font-weight: bold;
	font-style: italic;
	padding: 0;
	margin: 15px 0 5px;
}

dl dt:first-child {
	padding: 0;
}

dl dt>:first-child {
	margin-top: 0px;
}

dl dt>:last-child {
	margin-bottom: 0px;
}

dl dd {
	margin: 0 0 15px;
	padding: 0 15px;
}

dl dd>:first-child {
	margin-top: 0px;
}

dl dd>:last-child {
	margin-bottom: 0px;
}

/* CODE
=============================================================================*/
pre, code, tt {
	font-size: 12px;
	font-family: Consolas, "Liberation Mono", Courier, monospace;
}

code, tt {
	margin: 0 0px;
	padding: 0px 0px;
	white-space: nowrap;
	border: 1px solid #eaeaea;
	background-color: #f8f8f8;
	border-radius: 3px;
}

pre>code {
	margin: 0;
	padding: 0;
	white-space: pre;
	border: none;
	background: transparent;
}

pre {
	background-color: #f8f8f8;
	border: 1px solid #ccc;
	font-size: 13px;
	line-height: 19px;
	overflow: auto;
	padding: 6px 10px;
	border-radius: 3px;
}

pre code, pre tt {
	background-color: transparent;
	border: none;
}

kbd {
	-moz-border-bottom-colors: none;
	-moz-border-left-colors: none;
	-moz-border-right-colors: none;
	-moz-border-top-colors: none;
	background-color: #DDDDDD;
	background-image: linear-gradient(#F1F1F1, #DDDDDD);
	background-repeat: repeat-x;
	border-color: #DDDDDD #CCCCCC #CCCCCC #DDDDDD;
	border-image: none;
	border-radius: 2px 2px 2px 2px;
	border-style: solid;
	border-width: 1px;
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	line-height: 10px;
	padding: 1px 4px;
}

/* QUOTES
=============================================================================*/
blockquote {
	border-left: 4px solid #DDD;
	padding: 0 15px;
	color: #777;
}

blockquote>:first-child {
	margin-top: 0px;
}

blockquote>:last-child {
	margin-bottom: 0px;
}

/* HORIZONTAL RULES
=============================================================================*/
hr {
	clear: both;
	margin: 15px 0;
	height: 0px;
	overflow: hidden;
	border: none;
	background: transparent;
	border-bottom: 4px solid #ddd;
	padding: 0;
}

/* TABLES
=============================================================================*/
table th {
	font-weight: bold;
}

table th, table td {
	border: 1px solid #ccc;
	padding: 6px 13px;
}

table tr {
	border-top: 1px solid #ccc;
	background-color: #fff;
}

table tr:nth-child(2n) {
	background-color: #f8f8f8;
}

/* IMAGES
=============================================================================*/
img {
	max-width: 100%
}

/***********  底部 *************************/
footer {
	border-top: 1px solid #ccc;
	font-size: 10pt;
	margin-top: 4em;
}

/******************** media **********************************/
@media ( max-width : 768px) {
	body {
		padding: 0 10px 0 300px;
	}
	nav {
		width: 300px;
	}
}

@media ( max-width : 480px) {
	body {
		padding: 64px 10px 0 10px;
	}
	header .banner {
		display: none;
	}
	nav {
		position: absolute;
		width: 100%;
	}
	nav .menubar {
		display: block;
	}
	nav .banner {
		float: right;
	}
	nav ul {
		background: #fff;
		display: none;
		font-size: 14pt;
		margin: 0;
		padding: 0 0 0 8px;
	}
	nav .level2 {
		font-size: 16pt;
		font-weight: bold;
	}
	nav li {
		line-height: 240%;
	}
	.index nav ul {
		display: block;
	}
	.index article {
		display: none;
	}
}
</style>
<script>
  (function (tags) {
    var i = 0, len = tags.length;

    for (; i < len; ++i) {
        document.createElement(tags[i]);
    }
  }([ 'header', 'nav', 'article', 'footer' ]));
</script>
</head>
<body>
<header>
<x-markdown src="section/00_header.md" />
</header>
<nav>
<div class="menubar">
<a class="button">&#9776;&nbsp;索引</a>
</div>
<x-index />
</nav>
<article>
<x-markdown src="section/01_基础知识.md" />
<x-markdown src="section/02_常用命令.md" />
</article>
<footer>
<x-markdown src="section/99_footer.md" />
</footer>
</body>
</html>