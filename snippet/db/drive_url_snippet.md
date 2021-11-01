### 数据库驱动与链接
- 驱动

|数据库|驱动|
|:----|:----|
|h2|org.h2.Driver|
|mySQL|com.mysql.jdbc.Driver|
|Oracle|oracle.jdbc.driver.OracleDriver|
|PostgreSQL|org.postgresql.Driver|
|Apache|org.apache.derby.jdbc.EmbeddedDriver|
|HyperSQL|org.hsqldb.jdbcDriver|
|SourceForge|net.sourceforge.jtds.jdbc.Driver|
|IBM|com.ibm.db2.jcc.DB2Driver|
|SQLite|org.sqlite.JDBC|
|Firebird|org.firebirdsql.jdbc.FBDriver|
|Sybase|com.sybase.jdbc4.jdbc.SybDriver|


- 链接

|数据库|链接|
|:----|:----|
|mySQL|jdbc:mysql://localhost/sampleroot?tinyInt1isBit=false&zeroDateTimeBehavior=convertToNull|
|Oracle|jdbc:oracle:thin:@127.0.0.1:1521:sampleroot|
|PostgreSQL|jdbc:postgresql://localhost/sampleroot|
|Apache|jdbc:derby:sampleroot;create=true|
|HyperSQL|jdbc:hsqldb:file:sampleroot;shutdown=true|
|SourceForge|jdbc:jtds:sqlserver://localhost:1433;sendStringParametersAsUnicode=false; useCursors=true;bufferMaxMemory=10240;lobBuffer=5242880|
|IBM|jdbc:db2://localhost/samproot|
|SQLite|jdbc:sqlite:target/sqlite/client|
|Firebird|jdbc:firebirdsql://host[:port]/client|
|Sybase|jdbc:sybase:Tds:localhost:5000/client|