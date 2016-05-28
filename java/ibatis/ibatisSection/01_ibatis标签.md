##ibatis 映射文件标签元素 
>即： sqlMap 标签

~~~
1)Ibatis的SQL Map的核心概念是Mapped Statement。Mapped Statement可以使用任意的SQL语句，
  并拥有 parameterMap/parameterClass(输入参数)和resultMap/resultClass(输出结果)。
(2)<statement>元素是个通用的声明，可以用于任何类型的SQL语句，但是通常使用具体的<statement>类型，
   如：查询使用<select>，添加使用<insert>，更新使用<update>，删除使用<delete>
(3)Ibatis对象之间的关系：
	Ibatis的输入参数和输出参数只能是一个，因此，当输入参数在一个实体对象时，使用 parameterClass ，当输入对象也只在一个实体对象中时，使用 resultClass 。
  但是有很多时候输入参数和输出参数可能包含在几个实体对象中，我们不能为了只传递一个参数而专门为这些输入和输出参数组合专门创建类，
  因此就需要使用 parameterMap和resultMap 来组合多个实体对象中的字段。
~~~
### sqlMap 标签：
#### sql sql语句
~~~
与include标签结合使用可以拆分sql语句减少重用
<sql id="test">
	select 1 from dual
</sql>
<select id=”selectTest” resultClass=”查询结果类型” >  
      <include refid="test"/>
</select>
~~~
#### insert 添加
~~~
<insert id=”Ibatis添加实体操作Id” parameterClass=”参数类型”>  
	<selectkey resultClass=”int” keyProperty=”自定义主键名称”>  
         select 序列名.nextval from dual;  
    </selectkey>  
    insert into 表名(主键,列名1, 列名2,……) 
		   values(#自定义主键名称#，#实体类字段1#,#实体类字段2#......);  
</insert>
注：主键自增长可选择<selectkey>标签
   selectkey标签中的keyProperty属性是主键赋值的对象。
~~~
#### delete 删除
~~~
<delete id=”Ibatis删除实体操作Id” parameterClass=”参数类型”>  
       delete from 实体对应数据库中的表名 where 列名=#列名对应的实体字段名#;  
</delete>
~~~
#### update 更新
~~~
<update id=”Ibatis更新实体操作Id” parameterClass=”参数类型”>  
       update 实体对应数据库的表名 set 列名1=#字段1#，列名2=#字段2#，…….where ….;  
</update> 
~~~
#### select 查询 
~~~
id    指定名称  
parameterClass  参数类型，类的别名或全名  
parameterMap    传入参数的显示映射  
resultClass     返回类型，类的别名或全名  
resultMap       返回类型的显示映射  
cacheModel      缓存模式  
resultSetType   结果集类型，如游标的类型只能往前  
fetchSize       预取回指定大小的数据  
xmlResultName   当resultClass值为xml时在此指定XML文件的根标签  
remapResults    如果返回的字段不确定，将此属性设为true，默认为false    
                如:select * from $table$  或select $fields$ from table  
timeout         超时   
eg：
 <select id=”Ibatis查询实体操作Id” resultClass=”查询结果类型”>  
   select * from 实体对应的表名;
 </select> 

注意： 
当设置remapResults为"true"时：
iBATIS会在每次查询的时候内省查询结果来设置元数据，来保证返回恰当的结果。  
这个属性会造成一定的性能损失，所以要谨慎使用，只在你需要的时候使用－－  
查询列发生变化，直接的，或者隐含的，检索的表发生变化。  

~~~
#### procedure 存储过程
>需要定义存储过程 输入输出参数

~~~~~~~
<parameterMap id=”存储过程参数” class=”map”>  
	<parameter property=”email1” jdbcType=”varchar” javaType=”java.lang.String” mode=”INOUT”/>  
	<parameter property=”email2” jdbcType=”varchar” javaType=”java.lang.String” mode=”INOUT”/>  
</parameterMap>   

<procedure id=”Ibatis调用存储过程” parameterMap=” 存储过程参数”>  
       {call 存储过程名(?,?)}  
</procedure>   

或
<procedure id="getXswdlBypkg"  parameterClass="java.util.HashMap" resultClass="java.util.HashMap" remapResults="true">
	<![CDATA[
		{ call lo_zhxswdl_web(  #sdate,jdbcType=VARCHAR,mode=IN# ,
								#edate,jdbcType=VARCHAR,mode=IN#,
								#dwdm,jdbcType=VARCHAR,mode=IN#,
								#dwtjbz,jdbcType=VARCHAR,mode=IN#, #getXswdl,javaType=java.sql.ResultSet,jdbcType=ORACLECURSOR,mode=OUT#
							)
		}	
	]]>
</procedure>

~~~~~~~

#### typeAlias 类别名 
~~~
定义别名，使用时就可省略包名
<typeAlias alias="Account" type="com.mydomain.domain.Account"/> 
~~~
#### resultMap 
>返回类型显示映射关系 

~~~
<resultMap id="AccountResult" class="Account"> 
	<result property="id" column="ACC_ID"/> 
	<result property="firstName" column="ACC_FIRST_NAME"/> 
</resultMap>
~~~
#### parameterMap 
>参数类型外联映射关系 

~~~
<parameterMap id=”存储过程参数” class=”map”>  
   <parameter property=”email1” jdbcType=”varchar” javaType=”java.lang.String” mode=”INOUT”/>  
   <parameter property=”email2” jdbcType=”varchar” javaType=”java.lang.String” mode=”INOUT”/>  
</parameterMap>
~~~


## ibatis 动态标签
### 动态标签详情
#### dynamic
>SQL语句的动态部分

~~~
<dynamic prepend="WHERE">  

</dynamic>
~~~
### 二元判断标签
~~~
即：与静态值或属性的值比较 
共同的元素 ：
prepend（可选） 
property(必选)    比较的属性
compareProperty  另一个用于和前者比较的属性（必选或选择compareValue）
compareValue     用于比较的值（必选或选择compareProperty）

eg:
<isLessEqual prepend=”AND” property=”test” compareValue=”0”>
  sql条件语句
</isLessEqual>
~~~
#### isEqual
>比较属性值和静态值或另一个属性值是否相等。

#### isNotEqual
>比较属性值和静态值或另一个属性值是否不相等。

#### isGreaterThan
>比较属性值是否大于静态值或另一个属性值。

#### isGreaterEqual
>比较属性值是否大于等于静态值或另一个属性值。

#### isLessThan
>比较属性值是否小于静态值或另一个属性值。

#### isLessEqual
>比较属性值是否小于等于静态值或另一个属性值。 

### 一元判断标签
~~~
即：检查属性的状态是否符合特定的条件
共同的元素：
prepend（可选） 
property(必选)    比较的属性

eg:
<isNotEmpty prepend=”AND” property=”test” > 
 sql条件语句
</isNotEmpty>
~~~
#### isPropertyAvailable
>检查是否存在该属性（存在parameter bean的属性）。

#### isNotPropertyAvailable
>检查是否不存在该属性（不存在parameter bean的属性）。

#### isNull
>检查属性是否为null。

#### isNotNull
>检查属性是否不为null。

#### isEmpty
>检查Collection.size()的值，属性的String或String.valueOf()值,是否为null或空（“”或size() < 1）。

#### isNotEmpty
>检查Collection.size()的值，属性的String或String.valueOf()值,是否不为null或不为空（“”或size() > 0）

### 高级标签
#### iterate
>迭代标签

~~~
遍历类型为java.util.List(或数组)的元素
标签元素：
prepend（可选）    
property（必选）   类型为java.util.List的用于遍历的元素
open（可选）       整个遍历内容体开始的字符串，用于定义括号
close（可选）      整个遍历内容体结束的字符串，用于定义括号
conjunction（可选）每次遍历内容之间的字符串，用于定义AND或OR

eg:
id in 
<iterate  prepend="" property="ids"  open="("  close=")"  conjunction="," > 
#ids[]# 
</iterate>
生成的sql语句是：id in (xx1,xx2,xx3,.....)，括号中的(包括括号)是标签生成的

注意：使用标签时，在List元素名后面包括方括号[]非常重要，方括号[]将对象标记为List，以防解析器简单地将List输出成String。
~~~