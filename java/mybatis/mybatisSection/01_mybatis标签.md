## ibatis #与$区别
### #与$用法与区别
~~~
区别同ibatis 一样
语法不一样：
# #{str}
$ ${str}
~~~
## 支持的JDBC类型
### 支持的JDBC类型
~~~
MyBatis 支持下列JDBC 类型，通过JdbcType 枚举：
	BIT，FLOAT，CHAR，TIMESTAMP，OTHER，UNDEFINED，TINYINT，REAL，VARCHAR，BINARY，
	BLOB，NVARCHAR，SMALLINT，DOUBLE，LONGVARCHAR，VARBINARY，CLOB，NCHAR，INTEGER，
	NUMERIC，DATE，LONGVARBINARY，BOOLEAN，NCLOB，BIGINT，DECIMAL，TIME，NULL，CURSOR
~~~
##mybatis 映射文件标签元素 
### mapper 标签
~~~
共同属性：
id	在这个模式下唯一的标识符，可被其它语句引用	 	 
parameterType	传给此语句的参数的完整类名或别名	 	 
flushCache	如果设为true，则会在每次语句调用的时候就会清空缓存。select 语句默认设为false
useCache	如果设为true，则语句的结果集将被缓存。select 语句默认设为false 
timeout 	设置驱动器在抛出异常前等待回应的最长时间，默认为不设值，由驱动器自己决定	正整数
fetchSize	设置一个值后，驱动器会在结果集数目达到此数值后，激发返回，默认为不设值，由驱动器自己决定	正整数
statementType	statement，preparedstatement，callablestatement。
预准备语句、可调用语句	STATEMENT PREPARED CALLABLE	PREPARED 
~~~
#### sql sql语句
~~~
配合 <include> 用于sql语句重复使用
eg:
<sql id="test"> 
 select 1 from dual
</sql>
<select id="gettest" parameterType="String" resultMap="ResultMap">  
    <include refid="test"/>  
            WHERE  1=1   
</select> 
~~~

#### insert 添加
~~~
insert可以使用数据库支持的自动生成主键策略，设置useGeneratedKeys=”true”，然后把keyProperty 设成对应的列.

useGeneratedKeys 告诉MyBatis 使用JDBC 的getGeneratedKeys 方法来获取数据库自己生成的主键（MySQL、SQLSERVER 等关系型数据库会有自动生成的字段）。默认：false
keyProperty 标识一个将要被MyBatis 设置进getGeneratedKeys 的key 所返回的值，或者为insert 语句使用一个selectKey 子元素。
 	 
selectKey语句属性配置细节：
keyProperty	selectKey 语句生成结果需要设置的属性。	 
resultType	生成结果类型，MyBatis 允许使用基本的数据类型，包括String 、int类型。	 
order	可以设成BEFORE 或者AFTER，如果设为BEFORE，那它会先选择主键，然后设置keyProperty，再执行insert语句；如果设为AFTER，它就先运行insert 语句再运行selectKey 语句，通常是insert 语句中内部调用数据库（像Oracle）内嵌的序列机制。 	BEFORE
AFTER
statementType	像上面的那样， MyBatis 支持STATEMENT，PREPARED和CALLABLE 的语句形式， 对应Statement ，PreparedStatement 和CallableStatement 响应	STATEMENT PREPARED CALLABLE

eg:
<insert id="insertStudentAutoKey" parameterType="StudentEntity">  
    <selectKey keyProperty="studentID" resultType="String" order="BEFORE">  
            select nextval('student')  
    </selectKey>  
    INSERT INTO 表名 (列1,列2,....)  
           VALUES   (#{列1},#{列2},....)      
</insert>  
~~~

#### delete 删除
~~~
<delete id="deleteStudent" parameterType="StudentEntity">  
    DELETE FROM STUDENT_TBL WHERE STUDENT_ID = #{studentID}  
</delete>
~~~

#### update 修改
~~~
<update id="updateStudent" parameterType="StudentEntity">  
    UPDATE STUDENT_TBL  
        SET STUDENT_TBL.STUDENT_NAME = #{studentName},   
            STUDENT_TBL.STUDENT_SEX = #{studentSex},  
            STUDENT_TBL.STUDENT_BIRTHDAY = #{studentBirthday},  
            STUDENT_TBL.CLASS_ID = #{classEntity.classID}  
     WHERE STUDENT_TBL.STUDENT_ID = #{studentID};     
</update>
~~~

#### select 查询
~~~
不同的属性
resultType	语句返回值类型的整类名或别名。注意，如果是集合，那么这里填写的是集合的项的整类名或别名，而不是集合本身的类名。（resultType 与resultMap 不能并用）	 	 
resultMap	引用的外部resultMap 名。结果集映射是MyBatis 中最强大的特性。许多复杂的映射都可以轻松解决。（resultType 与resultMap 不能并用）	 	 
resultSetType	forward_only，scroll_sensitive，scroll_insensitive只转发，滚动敏感，不区分大小写的滚动

<select id="getStudent" parameterType="String" resultMap="studentResultMap">  
    SELECT ST.STUDENT_ID,  
               ST.STUDENT_NAME,  
               ST.STUDENT_SEX,  
               ST.STUDENT_BIRTHDAY,  
               ST.CLASS_ID  
          FROM STUDENT_TBL ST  
         WHERE ST.STUDENT_ID = #{studentID}  
</select>  
~~~

#### cache 与cache-ref  缓存
~~~
MyBatis 包含一个强在的、可配置、可定制的缓存机制。
MyBatis 3 的缓存实现有了许多改进，既强劲也更容易配置。
默认的情况，缓存是没有开启，除了会话缓存以外，它可以提高性能，且能解决全局依赖。
开启二级缓存，你只需要在SQL 映射文件中加入简单的一行：<cache/>

这句简单的语句的作用如下：
1. 所有在映射文件里的select 语句都将被缓存。
2. 所有在映射文件里insert,update 和delete 语句会清空缓存。
3. 缓存使用“最近很少使用”算法来回收
4. 缓存不会被设定的时间所清空。
5. 每个缓存可以存储1024 个列表或对象的引用（不管查询出来的结果是什么）。
6. 缓存将作为“读/写”缓存，意味着获取的对象不是共享的且对调用者是安全的。不会有其它的调用
7. 者或线程潜在修改。

Cache 语句属性配置细节： 
eviction  缓存策略： LRU FIFI SOFT WEAK 默认LRU
			LRU - 最近最少使用法：移出最近较长周期内都没有被使用的对象。
			FIFI- 先进先出：移出队列里较早的对象
			SOFT - 软引用：基于软引用规则，使用垃圾回收机制来移出对象
			WEAK - 弱引用：基于弱引用规则，使用垃圾回收机制来强制性地移出对象	
flushInterval	代表一个合理的毫秒总计时间。默认是不设置，因此使用无间隔清空即只能调用语句来清空。	正整数	 
size	缓存的对象的大小	正整数	默认1024
readOnly 只读缓存将对所有调用者返回同一个实例。
		 因此都不能被修改，这可以极大的提高性能。
		 可写的缓存将通过序列化来返回一个缓存对象的拷贝。
		 这会比较慢，但是比较安全。所以默认值是false。
eg:
<cache eviction="FIFO" flushInterval="60000" size="512" readOnly="true">  
</cache>  
还可以在不同的命名空间里共享同一个缓存配置或者实例。在这种情况下，你就可以使用cache-ref 来引用另外一个缓存。
 
<cache-ref namespace="com.liming.manager.data.StudentMapper"/>  
~~~

#### resultMap 标签
>这是最复杂而却强大的一个元素了，它描述如何从结果集中加载对象

~~~
   resultMap 是MyBatis 中最重要最强大的元素了。你可以让你比使用JDBC 调用结果集省掉90%的代码，也可以让你做许多JDBC 不支持的事。
现实上，要写一个等同类似于交互的映射这样的复杂语句，可能要上千行的代码。ResultMaps 的目的，就是这样简单的语句而不需要多余的结果映射，更多复杂的语句，
除了只要一些绝对必须的语句描述关系以外，再也不需要其它的。
resultMap属性：type为java实体类；id为此resultMap的标识。
 
resultMap可以设置的映射：
1. constructor – 用来将结果反射给一个实例化好的类的构造器
	a) idArg – ID 参数；将结果集标记为ID，以方便全局调用
	b) arg –反射到构造器的通常结果
2. id – ID 结果，将结果集标记为ID，以方便全局调用
3. result – 反射到JavaBean 属性的普通结果
4. association – 复杂类型的结合；多个结果合成的类型
	a) nested result mappings – 几resultMap 自身嵌套关联，也可以引用到一个其它上
5. collection –复杂类型集合a collection of complex types
6. nested result mappings – resultMap 的集合，也可以引用到一个其它上
7. discriminator – 使用一个结果值以决定使用哪个resultMap
	a) case – 基本一些值的结果映射的case 情形
		i. nested result mappings –一个case 情形本身就是一个结果映射，因此也可以包括一些相同的元素，也可以引用一个外部resultMap。

id、result语句属性配置:
property 需要映射到JavaBean的属性名称。
column  数据表的列名或者标签别名。
javaType 一个完整的类名，或者是一个类型别名。如果你匹配的是一个JavaBean，那MyBatis通常会自行检测到。
		 然后，如果你是要映射到一个HashMap，那你需要指定javaType要达到的目的。 
jdbcType 数据表支持的类型列表。这个属性只在insert,update或delete 的时候针对允许空的列有用。JDBC需要这项，但MyBatis 不需要。
		 如果你是直接针对JDBC编码，且有允许空的列，而你要指定这项。
typeHandler 使用这个属性可以覆写类型处理器。这项值可以是一个完整的类名，也可以是一个类型别名。
eg:
<resultMap type="liming.student.manager.data.model.StudentEntity" id="studentResultMap">  
    <id  property="studentId"        column="STUDENT_ID" javaType="String" jdbcType="VARCHAR"/>  
    <result property="studentName"       column="STUDENT_NAME" javaType="String" jdbcType="VARCHAR"/>  
    <result property="studentSex"        column="STUDENT_SEX"  javaType="int" jdbcType="INTEGER"/>  
    <result property="studentBirthday"   column="STUDENT_BIRTHDAY"  javaType="Date" jdbcType="DATE"/>  
    <result property="studentPhoto"  column="STUDENT_PHOTO" javaType="byte[]" jdbcType="BLOB" typeHandler="org.apache.ibatis.type.BlobTypeHandler" />  
</resultMap>  
~~~
##### constructor 构造器
~~~
我们使用id、result时候，需要定义java实体类的属性映射到数据库表的字段上。
这个时候是使用JavaBean实现的。当然我们也可以使用实体类的构造方法来实现值的映射，这个时候是通过构造方法参数的书写的顺序来进行赋值的。
使用construcotr功能有限（例如使用collection级联查询）
eg:
<resultMap type="StudentEntity" id="studentResultMap" >  
    <constructor>  
        <idArg javaType="String" column="STUDENT_ID"/>  
        <arg javaType="String" column="STUDENT_NAME"/>  
        <arg javaType="String" column="STUDENT_SEX"/>  
        <arg javaType="Date" column="STUDENT_BIRTHDAY"/>  
    </constructor>  
</resultMap>  
~~~
#####  association 联合
~~~
联合元素用来处理“一对一”的关系。需要指定映射的Java实体类的属性，属性的javaType（通常MyBatis 自己会识别）。
对应的数据库表的列名称。如果想覆写的话返回结果的值，需要指定typeHandler。
不同情况需要告诉MyBatis 如何加载一个联合。MyBatis 可以用两种方式加载：
1. select: 执行一个其它映射的SQL 语句返回一个Java实体类型。较灵活；
2. resultsMap: 使用一个嵌套的结果映射来处理通过join查询结果集，映射成Java实体类型。
eg:
<resultMap type="ClassEntity" id="classResultMap">  
    <id property="classID" column="CLASS_ID" />  
    <result property="className" column="CLASS_NAME" />  
    <result property="classYear" column="CLASS_YEAR" />  
    <association property="teacherEntity" column="TEACHER_ID" select="getTeacher"/>  注：select 换成 resultsMap 
</resultMap>  
  
<select id="getClassByID" parameterType="String" resultMap="classResultMap">  
    SELECT * FROM CLASS_TBL CT  
    WHERE CT.CLASS_ID = #{classID};  
</select>  
~~~
##### collection 集合
~~~
聚集元素用来处理“一对多”的关系。需要指定映射的Java实体类的属性，属性的javaType（一般为ArrayList）；列表中对象的类型ofType（Java实体类）；对应的数据库表的列名称；
不同情况需要告诉MyBatis 如何加载一个聚集。MyBatis 可以用两种方式加载：
1. select: 执行一个其它映射的SQL 语句返回一个Java实体类型。较灵活；
2. resultsMap: 使用一个嵌套的结果映射来处理通过join查询结果集，映射成Java实体类型。
 
用法和联合很类似，区别在于，这是一对多，所以一般映射过来的都是列表。
所以这里需要定义javaType为ArrayList，还需要定义列表中对象的类型ofType，以及必须设置的select的语句名称（需要注意的是，这里的查询student的select语句条件必须是外键classID）
eg:
<resultMap type="ClassEntity" id="classResultMap">  
    <id property="classID" column="CLASS_ID" />  
    <result property="className" column="CLASS_NAME" />  
    <result property="classYear" column="CLASS_YEAR" />  
    <association property="teacherEntity" column="TEACHER_ID"  select="getTeacher"/>  
    <collection property="studentList" column="CLASS_ID" javaType="ArrayList" ofType="StudentEntity" select="getStudentByClassID"/>  注：select换成 resultMap
</resultMap>  
  
<select id="getClassByID" parameterType="String" resultMap="classResultMap">  
    SELECT * FROM CLASS_TBL CT  
    WHERE CT.CLASS_ID = #{classID};  
</select>  
~~~
##### discriminator鉴别器
~~~
有时一个单独的数据库查询也许返回很多不同（但是希望有些关联）数据类型的结果集。鉴别器元素就是被设计来处理这个情况的，还有包括类的继承层次结构。鉴别器非常容易理解，因为它的表现很像Java语言中的switch语句。
定义鉴别器指定了column和javaType属性。列是MyBatis查找比较值的地方。JavaType是需要被用来保证等价测试的合适类型（尽管字符串在很多情形下都会有用）。
<resultMap type="liming.student.manager.data.model.StudentEntity" id="resultMap_studentEntity_discriminator">  
    <id  property="studentId"        column="STUDENT_ID" javaType="String" jdbcType="VARCHAR"/>  
    <result property="studentName"       column="STUDENT_NAME" javaType="String" jdbcType="VARCHAR"/>  
    <result property="studentSex"        column="STUDENT_SEX"  javaType="int" jdbcType="INTEGER"/>  
    <result property="studentBirthday"   column="STUDENT_BIRTHDAY"  javaType="Date" jdbcType="DATE"/>  
    <result property="studentPhoto"  column="STUDENT_PHOTO" javaType="byte[]" jdbcType="BLOB" typeHandler="org.apache.ibatis.type.BlobTypeHandler" />  
    <result property="placeId"           column="PLACE_ID" javaType="String" jdbcType="VARCHAR"/>  
    <discriminator column="CLASS_ID" javaType="String" jdbcType="VARCHAR">  
        <case value="20000001" resultType="liming.student.manager.data.model.StudentEntity" >  
            <result property="classId" column="CLASS_ID" javaType="String" jdbcType="VARCHAR"/>  
        </case>  
    </discriminator>  
</resultMap>
~~~

### 动态标签
#### where
~~~
<where> 条件语句 </where>  
动态判断是否需要以AND或OR 开头
~~~

#### if 
~~~
<if test="studentName !=null ">  
    条件语句
</if>  
~~~

#### set
~~~
当update语句中没有使用if标签时，如果有一个参数为null，都会导致错误。
当在update语句中使用if标签时，如果前面的if没有执行，则或导致逗号多余错误。
使用set标签可以将动态的配置SET关键字，和剔除追加到条件末尾的任何不相关的逗号。
使用if+set标签修改后，如果某项为null则不进行更新，而是保持数据库原值
<set>  
    <if test="studentName != null and studentName != '' ">  
        STUDENT_TBL.STUDENT_NAME = #{studentName},  
    </if>  
</set>
~~~

#### trim
~~~
if + trim代替where/set标签
trim是更灵活的去处多余关键字的标签，他可以实践where和set的效果。
 <trim prefix="WHERE" prefixOverrides="AND|OR">  
    <if test="studentName !=null ">  
        ST.STUDENT_NAME LIKE CONCAT(CONCAT('%', #{studentName, jdbcType=VARCHAR}),'%')  
    </if>  
 </trim>     
或
 <trim prefix="SET" suffixOverrides=",">  
        <if test="studentName != null and studentName != '' ">  
            STUDENT_TBL.STUDENT_NAME = #{studentName},  
        </if>  
</trim>
~~~

#### choose(when, otherwise)
~~~
有时候我们并不想应用所有的条件，而只是想从多个选项中选择一个。而使用if标签时，只要test中的表达式为true，就会执行if标签中的条件。
MyBatis提供了choose 元素。if标签是与(and)的关系，而choose比傲天是或（or）的关系。
choose标签是按顺序判断其内部when标签中的test条件出否成立，如果有一个成立，则choose结束。
当choose中所有when的条件都不满则时，则执行otherwise中的sql。类似于Java 的switch 语句，choose为switch，when为case，otherwise则为default。

 <where>  
    <choose>  
        <when test="studentName !=null ">  
            ST.STUDENT_NAME LIKE CONCAT(CONCAT('%', #{studentName, jdbcType=VARCHAR}),'%')  
        </when >  
		<otherwise>  
        </otherwise>  
    </choose>  
</where>    
~~~

#### foreach
~~~
对于动态SQL 非常必须的，主是要迭代一个集合，通常是用于IN条件。List 实例将使用“list”做为键，数组实例以“array”做为键。
foreach元素是非常强大的，它允许你指定一个集合，声明集合项和索引变量，它们可以用在元素体内。它也允许你指定开放和关闭的字符串，在迭代之间放置分隔符。这个元素是很智能的，它不会偶然地附加多余的分隔符。
注意：你可以传递一个List实例或者数组作为参数对象传给MyBatis。当你这么做的时候，MyBatis会自动将它包装在一个Map中，用名称在作为键。List实例将会以“list”作为键，而数组实例将会以“array”作为键。

 <foreach collection="array" item="classIds"  open="(" separator="," close=")">  
       #{classIds}  
 </foreach>  
~~~

## configuration MyBatis配置文件
~~~
configuration 标签结构
configuration 
|--- properties
|--- settings
|--- typeAliases
|--- typeHandlers
|--- objectFactory
|--- plugins
|--- environments
|--- |--- environment
|--- |--- |--- transactionManager
|--- |--- |__ dataSource
|__ mappers
~~~